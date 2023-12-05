function [sim_results_norm,sim_results_detailed,sim_results] = ...
f_normalize(results, settings, exp_number, output_number, model_folders)
% This function processes and normalizes simulation results based on a
% specified normalization method. It accepts a set of inputs, including the
% simulation results, settings, experiment and output numbers, and a model
% metafile structure. The function returns normalized simulation results,
% along with detailed normalized simulation results if the 'simdetail'
% setting is enabled.
%
% Inputs:
% - rst: Structure containing the simulation results and scores
% - stg: Structure containing the settings for the simulation
% - exp_number: An integer representing the experiment number
% - output_number: An integer representing the output number
% - mmf: Structure containing the model directory information
%
% Outputs:
% - sim_results: A matrix containing the normalized simulation results
% - sim_results_detailed: A matrix containing the detailed normalized
% simulation results (if stg.simdetail is true)
%
% Used Functions:
% - extract_data: Helper function to extract data from the simulation
% results
%
% Variables
% Persistent:
% - sbtab: SBtab structure
% - Data: Loaded data from the model
% - sb: Structure containing experiment IDs

persistent sbtab
persistent Data
persistent sb

sim_results_norm = [];

% Load Data and sbtab if empty
if isempty(Data)
    load(model_folders.model.data.data_model, 'Data', 'sbtab','sb')
end

% Extract the data from the simulation results
sim_results = extract_data(results, exp_number, output_number, sbtab);
sim_results_detailed = [];

% Check if detailed simulation results are requested
if settings.simdetail
    sim_results_detailed =...
        extract_data(results, exp_number + 2 * settings.expn, ...
        output_number, sbtab);
end

% Get the normalization method
normalize = sbtab.datasets(exp_number).Normalize;

% Perform normalization if a method is specified
if ~isempty(normalize)
    output_ID = sbtab.datasets(exp_number).output_ID{output_number}{:};
    norm_factor = extract_data(results, exp_number, output_number, sbtab);

sim_results_norm = sim_results;

    % Normalize by the maximum value
    if contains(normalize, 'Max') && contains(normalize, output_ID)
        max_norm = max(norm_factor);
        sim_results_norm = sim_results / max_norm;
        if settings.simdetail
            sim_results_detailed = sim_results_detailed / max_norm;
        end
    end

    % Normalize to a value between 0 and 1
    if contains(normalize, 'Norm') && contains(normalize, output_ID)
        max_norm = max(norm_factor);
        min_norm = min(norm_factor);
        sim_results_norm = (sim_results-min_norm) / (max_norm-min_norm);
        if settings.simdetail
            sim_results_detailed = (sim_results_detailed-min_norm) / (max_norm-min_norm);
        end
    end


    % Normalize by the minimum value
    % if contains(normalize, 'Min') && contains(normalize, output_ID)
    % 
    %     min_norm = min(norm_factor);
    %     sim_results = sim_results / min_norm;
    %     min_norm
    %     if settings.simdetail
    %         sim_results_detailed = sim_results_detailed / min_norm;
    %     end
    % end

    % Normalize by time-dependent factors
    if contains(normalize, 'Time') && contains(normalize, output_ID)
        t_size = size(Data(exp_number).Experiment.t, 1);
        for n = 1:t_size
            exp_ID = getfield(sb, ['E' num2str(exp_number - 1) '.ID'], n);
            if contains(normalize, exp_ID)
                sim_results_norm = sim_results / norm_factor(n);
                if settings.simdetail
                    sim_results_detailed = ...
                    sim_results_detailed / norm_factor(n);
                end
            end
        end
    end
end
end

% Helper function to extract data
function data = extract_data(results, exp_number, output_number, sbtab)
% Helper function to extract data from the simulation results
% Input arguments:
% rst  - Structure containing the simulation results and scores.
% stg  - Structure containing the settings for the simulation.
% output_number - An integer representing the output number.
% sbtab - SBtab structure
% Output argument:
% data - extracted data from the simulation results
    data = results.simd{1, exp_number}.Data(:, end - ...
        size(sbtab.datasets(exp_number).output, 2) + output_number);
end