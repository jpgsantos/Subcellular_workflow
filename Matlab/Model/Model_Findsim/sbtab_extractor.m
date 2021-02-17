clc
clear

modelObj = sbmlimport('subset.xml');



parameter_num = 0;


for n = 1:size(modelObj.Species,1)
    modelObj.Species(n)
    Species{n,1} = "S" + (n-1);
    Species{n,2} = modelObj.Species(n).Name;
    Species{n,4} = modelObj.Species(n).Value;
    Species{n,3} = modelObj.Species(n).Units;
%     Species{n,5} = modelObj.Species(n).ConstantAmount;
%     Species{n,6} = modelObj.Species(n).Constant;
    Species{n,5} = modelObj.Species(n).BoundaryCondition;
end
    

for n = 1:size(modelObj.Rules)
Expression{n,1} = "EX" + (n-1);
Expression{n,2} = modelObj.Rules(n).Rule;
end
    

    for n = 1:size(modelObj.Reactions,1)
%     modelObj.Reactions(n).Reaction;


    Reaction_name = strrep(modelObj.Reactions(n).Reaction,' <-> ','__');
    Reaction_name = strrep(Reaction_name,' -> ','__');
    Reaction_name = strrep(Reaction_name,' + ','X');
    Reaction_name = strrep(Reaction_name,'[','');
    Reaction_name = strrep(Reaction_name,']','');
    
    Reaction{n,1} = "R" + (n-1);
    
    
    Reaction_rate = strrep(modelObj.Reactions(n).ReactionRate,'kinetics*','Cell*');
    
    Reaction{n,2} = Reaction_rate;
    
    
    Reaction_formula = strrep(modelObj.Reactions(n).Reaction,' <-> ',' <=> ');
    Reaction_formula = strrep(Reaction_formula,' -> ',' <=> ');
    Reaction_formula = strrep(Reaction_formula,'[','');
    Reaction_formula = strrep(Reaction_formula,']','');
    
    Reaction{n,4} = 'Cell';
    
    Reaction{n,5} = Reaction_formula;
    
    
    for i = 1:size(modelObj.Reactions(n).KineticLaw.Parameters,1)
        parameter_num = parameter_num +1;
        
        
        Parameter{parameter_num,4} = append(Reaction_name,"_"+i);
        Parameter{parameter_num,2} = modelObj.Reactions(n).KineticLaw.Parameters(i).value;
        Parameter{parameter_num,3} = modelObj.Reactions(n).KineticLaw.Parameters(i).units;
        
        if i == 1
            Parameter{parameter_num,1} = "kf_R"+n;
            Reaction{n,3} = false;
            kinecticlaw{n,1} = Parameter{parameter_num,1};
            Reaction{n,2} = "Cell*" + kinecticlaw{n,1};
            
            size(modelObj.Reactions(n).Reactants,1)
            modelObj.Reactions(n).Reactants
            for k = 1:size(modelObj.Reactions(n).Reactants,1)
            Reaction{n,2} = append(Reaction{n,2}," + " + modelObj.Reactions(n).Reactants(k).name);
            end
        else
            Parameter{parameter_num,1} = "kr_R"+n;
            Reaction{n,3} = true; 
            kinecticlaw{n,2} = Parameter{parameter_num,1};
            Reaction{n,2} = append(Reaction{n,2},"-Cell*" + kinecticlaw{n,2});
            
            for k = 1:size(modelObj.Reactions(n).Products,1)
            Reaction{n,2} = append(Reaction{n,2}," + " + modelObj.Reactions(n).Products(k).name);
            end
        end
        
    end
    
    
    
    
    end

