function f_sbtab_to_model(stg,sb)
% Saves the model in .mat, .sbproj and .xml format, while also creating a
% file whith the data to run the model in all different experimental
% settings defined in the sbtab

modelobj = sbiomodel (stg.name);
compObj = [];

sbtab.species = cat(2,sb.Compound.Name,sb.Compound.InitialValue,...
    sb.Compound.IsConstant,sb.Compound.Unit,sb.Compound.Location);

sbtab.defpar = cat(2,sb.Parameter.Comment,sb.Parameter.Value_linspace,...
    sb.Parameter.Unit);

for n = 1:size(sb.Compartment.ID,2)
    compObj{n} = addcompartment(modelobj, sb.Compartment.Name{n});
    set(compObj{n}, 'CapacityUnits', sb.Compartment.Unit{n});
    set(compObj{n}, 'Value', sb.Compartment.Size{n});
end

for n = 1:size(sbtab.species,1)
    
    for m = 1:size(compObj,2)
        if string(compObj{m}.Name) == string(sb.Compound.Location{n})
            compartment_number_match = m;
        end
    end
    
    addspecies (compObj{compartment_number_match}, sb.Compound.Name{n},sb.Compound.InitialValue{n}...
        ,'InitialAmountUnits',sb.Compound.Unit{n});
end

for n = 1:size(sbtab.defpar,1)
    addparameter(modelobj,sb.Parameter.Name{n},...
        sb.Parameter.Value_linspace{n},'ValueUnits',sb.Parameter.Unit{n},'Notes',sb.Parameter.Comment{n});
end

for n = 1:size(sb.Reaction.ID,1)
    
    if ischar(sb.Reaction.IsReversible{n})
        if contains(convertCharsToStrings(sb.Reaction.IsReversible{n}),"true")
            reaction_name = strrep(sb.Reaction.ReactionFormula{n},'<=>',' <-> ');
        else
            reaction_name = strrep(sb.Reaction.ReactionFormula{n},'<=>',' -> ');
        end
        
    else
        if sb.Reaction.IsReversible{n}
            reaction_name = strrep(sb.Reaction.ReactionFormula{n},'<=>',' <-> ');
        else
            reaction_name = strrep(sb.Reaction.ReactionFormula{n},'<=>',' -> ');
        end
    end
    
    reaction_name_compartment = reaction_name;
    
    % Check if running matlab 2020a or later
    if f_check_minimum_version(9,8)
        
        for m = 1:size(sb.Compound.Name,1)
            reaction_name_compartment = insertBefore(string(reaction_name_compartment)," " + string(sb.Compound.Name{m})," " + string(sb.Reaction.Location{n}));
        end
        
        while strfind(reaction_name_compartment,string(sb.Reaction.Location{n})+" "+string(sb.Reaction.Location{n}))
            reaction_name_compartment = strrep(reaction_name_compartment,string(sb.Reaction.Location{n})+" "+string(sb.Reaction.Location{n}), " "+sb.Reaction.Location{n});
        end
        
        while strfind(reaction_name_compartment,"  ")
            reaction_name_compartment = strrep(reaction_name_compartment,"  "," ");
        end
        
        reaction_name_compartment = strrep(reaction_name_compartment,sb.Reaction.Location{n} + " ",sb.Reaction.Location{n}+".");
        reaction_name_compartment = string(sb.Reaction.Location{n})+"."+reaction_name_compartment;
    end
    
    reactionObj = addreaction(modelobj,reaction_name_compartment);
    set(reactionObj,'ReactionRate',sb.Reaction.KineticLaw{n});
end

for n = 1:size(sb.Compound.ID,1)
    if ischar(sb.Compound.Assignement{n})
        if contains(convertCharsToStrings(sb.Compound.Assignement{n}),["true","True"])
            modelobj.species(n).BoundaryCondition = 1;
        end
    else
        if sb.Compound.Assignement{n} == 1
            modelobj.species(n).BoundaryCondition = 1;
        end
    end
    if ischar(sb.Compound.Interpolation{n})
        if contains(convertCharsToStrings(sb.Compound.Interpolation{n}),["true","True"])
            modelobj.species(n).BoundaryCondition = 1;
        end
    else
        if sb.Compound.Interpolation{n} == 1
            modelobj.species(n).BoundaryCondition = 1;
        end
    end
    if ischar(sb.Compound.IsConstant{n})
        if contains(convertCharsToStrings(sb.Compound.IsConstant{n}),["true","True"])
            modelobj.species(n).BoundaryCondition = 1;
        end
    else
        if sb.Compound.IsConstant{n} == 1
            modelobj.species(n).BoundaryCondition = 1;
        end
    end
end

sbtab.sim_time = [sb.Experiments.Sim_Time{:}];

species_INP_matcher ={};
for n = 1:size(sb.Compound.ID,1)
    if isfield(sb.Experiments,"S"+(n-1))
        species_INP_matcher{size(species_INP_matcher,1)+1,1} = n;
    end
end

for n = 1:size(sb.Experiments.ID,1)
    startamount = cell(1,size(species_INP_matcher,1));
    nInputTime = 0;
    nInput = 0;
    nOutput = 0;
    nExpression = 0;
    
    a = 0;
    for m = 1:size(sb.Compound.ID,1)
        if isfield(sb.Experiments,"S"+(m-1))
            a = a+1;
            startamount{a} = eval("sb.Experiments.S"+(m-1)+"(n)");
            startAmountName(a) = sb.Compound.Name(m);
        end
    end
    
    if isfield(sb.Experiments,"Normalize")
        sbtab.datasets(n).Normalize = sb.Experiments.Normalize{n};
    else
        sbtab.datasets(n).Normalize = [];
    end
    
    if isfield(eval(("sb.E")+(n-1)),"Time")
        Data(n).Experiment.t = transpose(eval("[sb.E"+(n-1)+".Time{:}]"));
    end
    
    for m = 1:size(sb.Compound.ID,1)
        if isfield(eval(("sb.E")+(n-1)+"I"),"Input_Time_S"+(m-1))
            nInputTime = nInputTime + 1;
            sbtab.datasets(n).input_time{1,nInputTime} = ...
                eval(("[sb.E") + (n-1) + "I.Input_Time_S" + (m-1) + "{:}]");
        end
        if isfield(eval(("sb.E")+(n-1)+"I"),"S"+(m-1))
            nInput = nInput + 1;
            sbtab.datasets(n).input_value{1,nInput} = ...
                eval(("[sb.E") + (n-1) + "I.S" + (m-1) + "{:}]");
            sbtab.datasets(n).input{nInput} = char("S" + (m-1));
        end
    end
    
    for m = 1:size(sb.Output.ID,1)
        if isfield(eval(("sb.E")+(n-1)),"Y"+(m-1))
            nOutput = nOutput+1;
            Data(n).Experiment.x(:,nOutput) = eval(("[sb.E") +...
                (n-1) + ".Y" + (m-1) + "{:}]");
            Data(n).Experiment.x_SD(:,nOutput) = eval(("[sb.E") +...
                (n-1) + ".SD_Y" + (m-1) + "{:}]");
            sbtab.datasets(n).output{nOutput} = sb.Output.Name(m);
            sbtab.datasets(n).output_value{nOutput} = ...
                {convertStringsToChars(...
                strrep(string(sb.Output.Location{m}) + "." +...
                string(sb.Output.Name{m}) + " = " +...
                string(sb.Output.Formula{m}),'eps','0.0001'))};
            sbtab.datasets(n).output_name{nOutput} = ...
                sb.Output.Name(m);
            sbtab.datasets(n).output_ID{nOutput} = ...
                sb.Output.ID(m);
            sbtab.datasets(n).output_location{nOutput} = ...
                sb.Output.Location(m);
        end
    end
    sbtab.datasets(n).stg.outnumber = nOutput;
    sbtab.datasets(n).start_amount = cat(2,startAmountName(:)...
        ,transpose([startamount{:}]),species_INP_matcher);
end

if isfield(sb,"Expression")
    for m = 1:size(sb.Expression.ID,1)
        if isfield(sb.Expression,'Formula')
            if isa(sb.Expression.Formula{m},'double')
                addspecies (modelobj, char(sb.Expression.Name(m)),...
                    str2double(string(sb.Expression.Formula{m})),...
                    'InitialAmountUnits',sb.Expression.Unit{m});
            else
                try
                    addspecies (modelobj, char(sb.Expression.Name(m)),0,...
                        'InitialAmountUnits',sb.Expression.Unit{m});
                catch
                end
                addrule(modelobj, char({convertStringsToChars(...
                    string(sb.Expression.Location{m}) + "." +...
                    string(sb.Expression.Name{m}) + " = " +...
                    string(sb.Expression.Formula{m}))}),...
                    'repeatedAssignment');
            end
        else
            addparameter(modelobj,char(sb.Expression.Name(m)),...
                str2double(string(sb.Expression.DefaultValue{m})),...
                'ValueUnits',sb.Expression.Unit{m});
        end
    end
end

if isfield(sb,"Input")
    for m = 1:size(sb.Input.ID,1)
        if isfield(sb.Input,'Formula')
            if isa(sb.Input.Formula{m},'double')
                addspecies (modelobj, char(sb.Input.Name(m)),...
                    str2double(string(sb.Input.DefaultValue{m})),...
                    'InitialAmountUnits',sb.Input.Unit{m});
            else
                try
                    addspecies (modelobj, char(sb.Input.Name(m)),0,...
                        'InitialAmountUnits',sb.Input.Unit{m});
                catch
                end
                addrule(modelobj, char({convertStringsToChars(...
                    string(sb.Input.Location{m}) + "." +...
                    string(sb.Input.Name{m}) + " = " +...
                    string(sb.Input.DefaultValue{m}))}),...
                    'repeatedAssignment');
            end
        else
            addparameter(modelobj,char(sb.Input.Name(m)),...
                str2double(string(sb.Input.DefaultValue{m})),...
                'ValueUnits',sb.Input.Unit{m});
        end
    end
end

if isfield(sb,"Constant")
    for m = 1:size(sb.Constant.ID,1)
        addparameter(modelobj,char(sb.Constant.Name(m)),...
            str2double(string(sb.Constant.Value{m})),...
            'ValueUnits',sb.Constant.Unit{m});
    end
end

sbiosaveproject(pwd + "/Model/" + stg.folder_model + "/Data/model_" +...
    stg.name + ".sbproj",'modelobj')

save(pwd + "/Model/" + stg.folder_model + "/Data/" + "model_" +...
    stg.name + ".mat",'modelobj')
save(pwd + "/Model/" + stg.folder_model + "/Data/data_" +...
    stg.name + ".mat",...
    'Data','sbtab','sb')

sbmlexport(modelobj,pwd + "/Model/" + stg.folder_model + "/Data/model_" +...
    stg.name + ".xml")

end