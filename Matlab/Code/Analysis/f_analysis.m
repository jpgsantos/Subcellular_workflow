function [rst,stg] = f_analysis(stg,analysis,mmf,analysis_options,rst)
% This function performs an analysis, based on the input analysis options
% Inputs:
% stg: settings to use in the analysis
% analysis: type of analysis to be performed
% mmf: main model files
% analysis_options: list of possible analysis options
% rst: structure for storing analysis results

for i = 1:length(analysis_options) % loop through all analysis options
    if contains(analysis_options(i),analysis) == 1 % check if current option matches desired analysis
        disp("Starting " + {analysis_options(i)}) % display start message
        switch i % switch based on current analysis option index
            case 1
                rst.diag = f_diagnostics(stg,mmf); % run diagnostic analysis
            case 2
                [rst.opt,pa] = f_opt(stg,mmf); % run optimization analysis
                valid_options = find(pa(:,1) ~= 0); % find valid optimization options
                stg.pat = transpose(valid_options); % update stage with valid options
                valid_options
                
                sim_results = cell(length(valid_options),1); % create cell array for simulation results
%                 pa
%                 valid_options
                for j = stg.pat % parallelize simulation runs
                    pa(j,:)
                    [~,sim_results{j},~] = f_sim_score(pa(j,:),stg,mmf); % run simulation for current valid option
                end
                sim_results{:}
                stg.pat
                [sim_results{:}]
                rst.diag(stg.pat) = [sim_results{:}]; % store simulation results in results structure
            case 3
                rst.lsa = f_lsa(stg,mmf); % run LSA analysis
            case 4
                rst.gsa = f_gsa(stg,mmf); % run GSA analysis
            case 5
                rst.PLA = f_PL_m(stg,mmf); % run PLA analysis
        end
        disp(analysis_options(i) + " completed successfully") % display completion message
    end
end
end