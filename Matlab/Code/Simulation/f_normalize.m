function [sim_results,sim_results_detailed] = f_normalize(rst,stg,exp_number,output_number)

persistent sbtab
persistent Data
persistent sb

if isempty(Data)
    load("Model/" +stg.folder_model + "/Data/data_"+stg.name+".mat",'Data','sbtab','sb')
end

sim_results = rst.simd{1,exp_number}.Data(:,end-...
    size(sbtab.datasets(exp_number).output,2)+output_number);

if stg.simdetail
    sim_results_detailed = rst.simd{1,exp_number+2*stg.expn}.Data(:,end-...
        size(sbtab.datasets(exp_number).output,2)+output_number);
    
else
    sim_results_detailed = [];
end

if ~isempty(sbtab.datasets(exp_number).Normalize)
    if contains(sbtab.datasets(exp_number).Normalize,'Max')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if
        %             contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
        end
        
        sim_results = sim_results/max(norm_factor);
        if stg.simdetail
            sim_results_detailed = sim_results_detailed/max(norm_factor);
        end
        
    end
    if contains(sbtab.datasets(exp_number).Normalize,'Min')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if
        %             contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
        end
        
        sim_results = sim_results/min(norm_factor);
        if stg.simdetail
            sim_results_detailed = sim_results_detailed/min(norm_factor);
        end
        
    end
    
    if contains(sbtab.datasets(exp_number).Normalize,'Time')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if
        %             contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
        end
        for n = 1:size(Data(exp_number).Experiment.t,1)
            if contains(sbtab.datasets(exp_number).Normalize,eval("sb.E"+(exp_number-1)+".ID(n)"))
                sim_results = sim_results/norm_factor(n);
                if stg.simdetail
                    sim_results_detailed = sim_results_detailed/norm_factor(n);
                end
            end
        end
        
    end
end
end