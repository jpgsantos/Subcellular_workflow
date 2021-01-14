function f_build_model_exp(stg,sb)
%Creates two .mat files for each experiment, one for the equilibrium 
%simulation and one for the proper simulation.
%This files have all the added rules, species and parameters needed 
%depending on the inputs and outputs specified on the SBtab.

persistent modelobj
persistent sbtab
persistent Data

if isempty(sbtab)
    
    %Find correct path for loading depending on the platform
    load("Model/" +stg.folder_model +"/Data/" + "data_" +...
        stg.name + ".mat",'Data','sbtab')
    load("Model/" +stg.folder_model +"/Data/" + "model_" +...
        stg.name + ".mat",'modelobj');
end

model_run = cell(size(sb.Experiments.ID,1),1);
configsetObj = cell(size(sb.Experiments.ID,1),1);

for number_exp = 1:size(sb.Experiments.ID,1)
    
    Compounds = sbtab.species;
    maxi = sbtab.datasets(number_exp).max;
    output_value = sbtab.datasets(number_exp).output_value;
    output = sbtab.datasets(number_exp).output;
    input_time = sbtab.datasets(number_exp).input_time;
    input_value = sbtab.datasets(number_exp).input_value;
    input_species = sbtab.datasets(number_exp).input;
    
    model_run{number_exp} = copyobj(modelobj);
    configsetObj{number_exp} = getconfigset(model_run{number_exp});
    
    set(configsetObj{number_exp}, 'MaximumWallClock', stg.maxt);
    set(configsetObj{number_exp}, 'StopTime', stg.eqt);
    set(configsetObj{number_exp}.CompileOptions,...
        'DimensionalAnalysis', stg.dimenanal);
    set(configsetObj{number_exp}.CompileOptions,...
        'UnitConversion', stg.UnitConversion);
    set(configsetObj{number_exp}.SolverOptions,...
        'AbsoluteToleranceScaling', stg.abstolscale);
    set(configsetObj{number_exp}.SolverOptions,...
        'RelativeTolerance', stg.reltol);
    set(configsetObj{number_exp}.SolverOptions,...
        'AbsoluteTolerance', stg.abstol);
    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes', stg.eqt);
    set(configsetObj{number_exp}, 'TimeUnits', stg.simtime);
    
    if ~isempty(stg.maxstep)
        set(configsetObj{number_exp}.SolverOptions,...
            'MaxStep', stg.maxstep);
    end
    
    model_exp = model_run{number_exp};
    
    save("Model/" + stg.folder_model + "/Data/Exp/Model_eq_" +...
        stg.name + "_" + number_exp + ".mat",'model_exp')
    
    set(configsetObj{number_exp}, 'StopTime', sbtab.sim_time(number_exp));
    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes',...
        Data(number_exp).Experiment.t);
    
    if ~isempty(stg.maxstep)
        set(configsetObj{number_exp}.SolverOptions, 'MaxStep', stg.maxstep);
    end
    for n = 1:size(output,2)
        
        m = 0;
        for k = 1:size(model_run{number_exp}.species,1)
            if model_run{number_exp}.species(k).name == string(output{1,n})
                model_run{number_exp}.species(k).BoundaryCondition = 1;
                m = 1;
            end
        end
        
        if isempty(sbtab.datasets(number_exp).max)
            
            if m == 0
                addspecies (model_run{number_exp}.Compartments(1),...
                    char(output{1,n}),0,...
                    'InitialAmountUnits',sb.Output.Unit{n});
            end
            
            addrule(model_run{number_exp}, char(output_value{1,n}),...
                'repeatedAssignment');
            
        else
            
            addspecies (model_run{number_exp}.Compartments(1), ...
                char(string(output{1,n}) + '_basal'),0,...
                'InitialAmountUnits',sb.Output.Unit{n});
            
            if m == 0
                addspecies (model_run{number_exp}.Compartments(1),...
                    char(output{1,n}),0,...
                    'InitialAmountUnits',sb.Output.Unit{n});
            end
            
            addrule(model_run{number_exp}, ...
                char(strrep(output_value{1,n},' =','_basal =')),...
                'initialAssignment');
            
            if maxi > 0
                addrule(model_run{number_exp},...
                    char(string(strrep(output_value{1,n},'= (','= ((')) +...
                    '/(0.00001+' + string(output{1,n}) + ...
                    '_basal)-1)/' + maxi/100 ), 'repeatedAssignment');
            else
                addrule(model_run{number_exp},...
                    char(string(strrep(output_value{1,n},'= (','= ((')) +...
                    '/(0.00001+' + string(output{1,n}) + ...
                    '_basal)-1)/' - maxi/100 + '+1'), 'repeatedAssignment');
            end
        end
    end
    
    for j = 1:size(input_species,2)
        if size(input_time{j},2) < 100
            
            for n = 1:size(input_time{j},2)
                if ~isnan(input_time{j}(n))
                    
                    addparameter(model_run{number_exp},char("time_event_t_" + j + "_" +  n),...
                        str2double(string(input_time{j}(n))),...
                        'ValueUnits',char(stg.simtime));
                    
                    addparameter(model_run{number_exp},char("time_event_r_" + j + "_" +  n),...
                        str2double(string(input_value{j}(n))),...
                        'ValueUnits',char(model_run{number_exp}.species(1 +...
                        str2double(strrep(input_species(j),'S',''))).InitialAmountUnits));
                    
                    addevent(model_run{number_exp}, ...
                        char("time>=time_event_t_" + j + "_" +  n),...
                        cellstr(sbtab.datasets(number_exp).output_location{1} +...
                        "." + string(model_run{number_exp}.species(1 +...
                        str2double(strrep(input_species(j),'S',''))).name)...
                        + " = time_event_r_" + j + "_" +  n));
                end
            end
        else
            name = string(model_run{number_exp}.species(1 +...
                str2double(strrep(input_species(j),'S',''))).name);
            
            addrule(model_run{number_exp}, char(sbtab.datasets(...
                number_exp).output_location{1} + "." + name +...
                "=" + string(model_run{number_exp}.name)+ "_input" + ...
                number_exp + "_" + name + "(time)"), 'repeatedAssignment');
        end
    end
    
    model_exp = model_run{number_exp};
    
    save("Model/" + stg.folder_model + "/Data/Exp/Model_" +...
        stg.name + "_" + number_exp + ".mat",'model_exp')
end
end