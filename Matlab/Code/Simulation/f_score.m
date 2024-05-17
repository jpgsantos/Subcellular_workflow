function results = f_score(results, settings, model_folders)
% This function calculates the score for a set of simulated results by
% comparing them to experimental data. It computes the score for each
% dataset and experiment and then calculates the total score based on the
% selected scoring strategy. The score serves as a metric for comparing the
% accuracy of different simulations or models.
%
% Inputs:
% - rst: Structure containing the simulation results and scores.
% - stg: Structure containing the settings for the scoring strategy, such
% as the option to use log10 scaling, error score, and other options.
% - mmf: Structure containing the model directory information.
%
% Outputs:
% - rst: Updated structure containing the calculated scores for each
% dataset, experiment, and the total score.
%
% Used Functions:
% - calculate_score_per_experiment: Calculates the score for each
% experiment.
% - calculate_score_per_dataset: Calculates the score for each dataset in
% an experiment.
% - f_normalize: Normalizes the simulation results for a dataset.
%
% Variables:
% Loaded:
% - Data: Experimental data.
% - sbtab: sbtab structure containing dataset information.
%
% Persistent:
% - sbtab: sbtab structure containing dataset information (persistent).
% - Data: Experimental data (persistent).

persistent sbtab
persistent Data

data_model = model_folders.model.data.data_model;

% Import the data on the first run
if isempty(Data)
    load(data_model,'Data','sbtab')
end

% Iterate over the number of experiments
for n = settings.exprun
    results = calculate_score_per_experiment(results, settings, n, ...
        model_folders, sbtab, Data);
end

% Calculate the total score
results.st = sum(results.se);

% Calculate the log10 of total score if option selected
if settings.useLog == 3
    results.st = log10(results.st);
end
end

function results = ...
    calculate_score_per_experiment(results, settings, n, model_folders, ...
    sbtab, Data)

% Iterate over the number of datasets per experiment
for j = 1:size(sbtab.datasets(n).output, 2)
    results = ...
        calculate_score_per_dataset(results, settings, n, j, ...
        model_folders, Data);
end
% Calculate score per experiment
results.se(n, 1) = sum(results.sd(:, n));

% Calculate the log10 of experiment score if option selected
if settings.useLog == 2
    results.se(n, 1) = log10(results.se(n, 1));
end

end

function results = ...
    calculate_score_per_dataset(results, settings, n, j, model_folders, ...
    Data)

% Calculate score per dataset if there are no errors
if results.simd{n} ~= 0
    data = Data(n).Experiment.x(:, j);
    data_sd = Data(n).Experiment.x_SD(:, j);

    number_points = size(Data(n).Experiment.x(:, j), 1);
    [sim_results_norm,~,sim_results] = ...
        f_normalize(results, settings, n, j, model_folders);

    if ~isempty(sim_results_norm)
        sim_results = sim_results_norm;
    end
    results.xfinal{n, 1}(j) = sim_results(end);

    % Calculate score using formula that accounts for normalization
    % with the starting point of the result
    switch settings.useLog
        case {0, 2, 3}
            results.sd(j, n) = ...
                sum(((data - sim_results) ./ (data_sd)).^2) / ...
                number_points;
        case 1
            results.sd(j, n) = ...
                max(0, log10(sum(((data - sim_results) ./ ...
                (data_sd)).^2) / number_points));
        case 4
            results.sd(j, n) = ...
                sum(((data - sim_results) ./ ...
                (data_sd * sqrt(number_points))).^2);
        otherwise
            error('Invalid value for stage.useLog: %d', settings.useLog);
    end

    if results.sd(j, n) == inf || isnan(results.sd(j, n))
        results.sd(j, n) = settings.errorscore;
        results.xfinal{n, 1}(j) = 0;
    end

    % If there are errors output a very high score value (10^10)
elseif results.simd{n} == 0 %|| rst.sd(j, n) == inf || isnan(rst.sd(j, n))
    switch settings.useLog
        case {1, 2, 3}
            results.sd(j, n) = log10(settings.errorscore);
        case {0, 4}
            results.sd(j, n) = settings.errorscore;
    end
    results.xfinal{n, 1}(j) = 0;
end
end