function [results, settings] = ...
    f_analysis(settings, analysis, model_folders, analysis_options, results)
% This function performs a specific analysis based on the given analysis
% options. The function calls the appropriate analysis functions
% (f_diagnostics, f_opt, f_sim_score, f_lsa, f_gsa, f_PL_m) depending on
% the selected analysis type. The analysis results are stored in an updated
% 'rst' structure, and the settings are updated as needed.
%
% Inputs:
% - stg: Settings to use in the analysis
% - analysis: Type of analysis to be performed
% - mmf: Main model files
% - analysis_options: List of possible analysis options
% - rst: Structure for storing analysis results
%
% Outputs:
% - rst: Updated structure containing the results of the analysis
% - stg: Updated settings after the analysis
%
% Used Functions:
% - f_diagnostics: Performs diagnostic analysis
% - f_opt: Performs optimization analysis
% - f_sim_score: Runs simulation for a given option
% - f_lsa: Performs Local sensititivity Analysis (LSA)
% - f_gsa: Performs Global ensititivity Analysis (GSA)
% - f_PL_m: Performs Profile Likelihood Analysisa (PLA)
%
% Variables:
% Initialized:
% - matching_option_idx: Index of the selected analysis option
% - sim_results: Cell array for storing simulation results
% - valid_options: Array of valid optimization options
%
% Persistent: None
% analysis
% analysis_options
% matching_option_idx
matching_option_idx = find(contains(analysis_options, analysis), 1);

% display start message
disp("Starting " + {analysis_options(matching_option_idx)})

% Perform the analysis based on the current analysis option index
switch matching_option_idx
    case 1
        % run diagnostic analysis
        results.diag = f_diagnostics(settings, model_folders);
    case 2
        % run optimization analysis
        [results.opt, pa] = f_opt(settings, model_folders);
        % find valid optimization options
        valid_options = find(pa(:, 1) ~= 0);
        % update settings with valid options
        settings.pat = transpose(valid_options);
        % create cell array for simulation results
        sim_results = cell(length(valid_options), 1);
        % parallelize simulation runs
        for j = settings.pat
            % run simulation for current valid option
            [~, sim_results{j}, ~] = ...
                f_sim_score(pa(j, :), settings, model_folders, 0, 0);
        end
        % store simulation results in results structure
        results.diag(settings.pat) = [sim_results{:}];
    case 3
        % run LSA analysis
        results.lsa = f_lsa(settings, model_folders);
    case 4
        % run GSA analysis
        results.gsa = f_gsa(settings, model_folders);
    case 5
        % run PLA analysis
        results.PLA = f_PL_m(settings, model_folders);
end

% display completion message
disp(analysis_options(matching_option_idx) + " completed successfully")
end