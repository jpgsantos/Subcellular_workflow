function [nOutputs,outputNames] = f_get_outputs(stg)

persistent n_out
persistent out_name

if isempty(n_out)
    
    load("Model/" +stg.folder_model +"/Data/" + "data_"+stg.name+".mat",'sbtab')
    
    n_out = 0;
    out_name = [];
    for n = stg.exprun
        for j = 1:size(sbtab.datasets(n).output,2)
            n_out = n_out + 1;
            out_name{n_out} = {"E" + (n-1) + " " + string(sbtab.datasets(n).output{1,j})};
        end
    end
end

nOutputs = n_out;
outputNames = out_name;
end