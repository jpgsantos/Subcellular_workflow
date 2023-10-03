function rst = f_score(rst, stg, mmf)
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

data_model = mmf.model.data.data_model;

% Import the data on the first run
if isempty(Data)
    load(data_model,'Data','sbtab')
end

% Iterate over the number of experiments
for n = stg.exprun
    rst = calculate_score_per_experiment(rst, stg, n, mmf,sbtab, Data);
end

% Calculate the total score
rst.st = sum(rst.se);

% Calculate the log10 of total score if option selected
if stg.useLog == 3
    rst.st = log10(rst.st);
end
end

function rst = calculate_score_per_experiment(rst, stg, n, mmf,sbtab, Data)

% Iterate over the number of datasets per experiment
for j = 1:size(sbtab.datasets(n).output, 2)
    rst = calculate_score_per_dataset(rst, stg, n, j, mmf, Data);
end

% Calculate score per experiment
rst.se(n, 1) = sum(rst.sd(:, n));

% Calculate the log10 of experiment score if option selected
if stg.useLog == 2
    rst.se(n, 1) = log10(rst.se(n, 1));
end
end

function rst = calculate_score_per_dataset(rst, stg, n, j, mmf, Data)

% Calculate score per dataset if there are no errors
if rst.simd{n} ~= 0
    data = Data(n).Experiment.x(:, j);
    data_sd = Data(n).Experiment.x_SD(:, j);


    % data = data /(max(data)-min(data));


    number_points = size(Data(n).Experiment.x(:, j), 1);
    sim_results = f_normalize(rst, stg, n, j, mmf);
    rst.xfinal{n, 1}(j) = sim_results(end);

    % Calculate score using formula that accounts for normalization
    % with the starting point of the result
    switch stg.useLog
        case {0, 2, 3}
            rst.sd(j, n) = sum(((data - sim_results) ./ (data_sd)).^2) / number_points;
        case 1
            rst.sd(j, n) = max(0, log10(sum(((data - sim_results) ./ (data_sd)).^2) / number_points));
        case 4
            rst.sd(j, n) = sum(((data - sim_results) ./ (data_sd * sqrt(number_points))).^2);
        otherwise
            error('Invalid value for stage.useLog: %d', stg.useLog);
    end

    % If there are errors output a very high score value (10^10)
elseif rst.simd{n} == 0 || rst.sd(n, j) == inf
    rst.sd(j, n) = stg.errorscore;
rst.xfinal{n, 1}(j) = 0;
end
end