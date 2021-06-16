function f_build_model_exp(stg,sb,mmf)
%Creates two .mat files for each experiment, with all the added rules,
%species and parameters needed depending on the inputs and outputs
%specified on the sbtab, one for the equilibrium simulation run and one for
%the proper run

data_model = mmf.model.data.data_model;
mat_model = mmf.model.data.mat_model;
model_exp_eq = mmf.model.data.model_exp.equilibration;
model_exp_default = mmf.model.data.model_exp.default;
model_exp_detail = mmf.model.data.model_exp.detail;

%Find correct path for loading depending on the platform
load(data_model,'Data','sbtab')
load(mat_model,'modelobj');

model_run = cell(size(sb.Experiments.ID,1),1);
configsetObj = cell(size(sb.Experiments.ID,1),1);

for number_exp = 1:size(sb.Experiments.ID,1)
    
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
    set(configsetObj{number_exp}.SolverOptions,...
        'MaxStep', stg.maxstepeq);
    
    set(configsetObj{number_exp}.SolverOptions,...
        'AbsoluteToleranceStepSize', stg.abstolstepsize_eq);
    
    
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    
    save(model_exp_eq + number_exp + ".mat",'model_exp','config_exp')
    
    sbiosaveproject(model_exp_eq + number_exp + ".sbproj",'model_exp')
    
    set(configsetObj{number_exp}, 'StopTime', sbtab.sim_time(number_exp));
    
    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes',...
        Data(number_exp).Experiment.t);
    
    set(configsetObj{number_exp}.SolverOptions, 'MaxStep', stg.maxstep);
    
    for n = 1:size(output,2)
        
        m = 0;
        for k = 1:size(model_run{number_exp}.species,1)
            if model_run{number_exp}.species(k).name == string(output{1,n})
                model_run{number_exp}.species(k).BoundaryCondition = 1;
                m = 1;
            end
        end
        
        if m == 0
            addspecies (model_run{number_exp}.Compartments(1),...
                char(output{1,n}),0,...
                'InitialAmountUnits',sb.Output.Unit{n});
        end
        
        addrule(model_run{number_exp}, char(output_value{1,n}),...
            'repeatedAssignment');
    end
    
    for j = 1:size(input_species,2)
        
        input_indexcode = str2double(strrep(input_species(j),'S',''));
        input_name = string(model_run{number_exp}.species(1 +...
                input_indexcode).name);
        
        if size(input_time{j},2) < 100
            
            model_run{number_exp}.species(...
                1 + input_indexcode).BoundaryCondition = 1;
            for n = 1:size(input_time{j},2)
                if ~isnan(input_time{j}(n))
                    
                    addparameter(model_run{number_exp},char("time_event_t_" + j + "_" +  n),...
                        str2double(string(input_time{j}(n))),...
                        'ValueUnits',char(stg.simtime));
                    
                    addparameter(model_run{number_exp},char("time_event_r_" + j + "_" +  n),...
                        str2double(string(input_value{j}(n))),...
                        'ValueUnits',char(model_run{number_exp}.species(1 +...
                        input_indexcode).InitialAmountUnits));
                    
                    addevent(model_run{number_exp}, ...
                        char("time>=time_event_t_" + j + "_" +  n),...
                        cellstr(sbtab.datasets(number_exp).output_location{1} +...
                        "." + input_name + " = time_event_r_" + j + "_" +  n));

                end
            end
        else
            
            addrule(model_run{number_exp}, char(sbtab.datasets(...
                number_exp).output_location{1} + "." + input_name +...
                "=" + string(model_run{number_exp}.name)+ "_input" + ...
                number_exp + "_" + input_name + "(time)"), 'repeatedAssignment');
        end
    end
    
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    
    save(model_exp_default + number_exp + ".mat",'model_exp','config_exp')
    
    sbiosaveproject(model_exp_default + number_exp + ".sbproj",'model_exp')
    
    set(configsetObj{number_exp}.SolverOptions,'OutputTimes', []);
    set(configsetObj{number_exp}.SolverOptions,'MaxStep', stg.maxstepdetail);
    
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    
    save(model_exp_detail + number_exp + ".mat",'model_exp','config_exp')
    
end
end