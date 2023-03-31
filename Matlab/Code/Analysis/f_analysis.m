function [rst,stg] = f_analysis(stg,analysis,mmf,analysis_options,rst)
% Function: f_analysis
% Description: This function performs a specific analysis based on the
% given analysis options. It takes settings, analysis type, main model
% files, a list of possible analysis options, and a structure for storing
% analysis results as input arguments. It outputs the results of the
% analysis and updates the settings as needed. The function calls the
% appropriate analysis functions (f_diagnostics, f_opt, f_sim_score, f_lsa,
% f_gsa, f_PL_m) depending on the selected analysis type.
%
% Inputs:
%   - stg: settings to use in the analysis
%   - analysis: type of analysis to be performed
%   - mmf: main model files
%   - analysis_options: list of possible analysis options
%   - rst: structure for storing analysis results
%
% Outputs:
%   - rst: updated structure containing the results of the analysis
%   - stg: updated settings after the analysis

matching_option_idx = find(contains(analysis_options, analysis), 1);

% display start message
disp("Starting " + {analysis_options(matching_option_idx)})

% Perform the analysis based on the current analysis option index
switch matching_option_idx
    case 1
        % run diagnostic analysis
        rst.diag = f_diagnostics(stg,mmf);
    case 2
        % run optimization analysis
        [rst.opt,pa] = f_opt(stg,mmf);
        % find valid optimization options
        valid_options = find(pa(:,1) ~= 0);
        % update settings with valid options
        stg.pat = transpose(valid_options);
        % create cell array for simulation results
        sim_results = cell(length(valid_options),1);
        % parallelize simulation runs
        for j = stg.pat
            % run simulation for current valid option
            [~,sim_results{j},~] = f_sim_score(pa(j,:),stg,mmf);
        end
        % store simulation results in results structure
        rst.diag(stg.pat) = [sim_results{:}];
    case 3
        % run LSA analysis
        rst.lsa = f_lsa(stg,mmf);
    case 4
        % run GSA analysis
        rst.gsa = f_gsa(stg,mmf);
    case 5
        % run PLA analysis
        rst.PLA = f_PL_m(stg,mmf);
end

% display completion message
disp(analysis_options(matching_option_idx) + " completed successfully")
end