function results = f_make_output_sample(results,settings,model_folders)
% This function calculates the outputs for three different matrices (GSA
% M1, GSA M2, and GSA N) based on the input parameters, settings, and a
% mathematical model. This code is inspired by Geir Halnes et al. 2009
% paper.
%
% Inputs:
% - results: A structure containing M1, M2, and N matrices
% - settings: A structure with settings, including sansamples and parnum
% - model_folders: A variable containing folders for the models
%
% Outputs:
% - results: A structure containing fM1, fM2, and fN fields, each
% containing computed outputs for corresponding GSA methods
%
% Used Functions :
% - compute_f: Compute the results for GSA M1, GSA M2, and GSA N methods
% - f_sim_score: Simulation score calculation function
% - progress_track: Track progress of the calculations
%
% Variables
% Loaded:
% - nSamples: Number of samples (loaded from settings.sansamples)
% - nPars: Number of parameters (loaded from settings.parnum)
%
% Initialized:
% - time_begin: The start time of the function
% - f_out: Structure holding the computed values for fM1, fM2, and fN
%
% Persistent:
% - current_sample: Keeps track of the current sample number for progress
% tracking
% - last_time: Keeps track of the last time progress was printed

% Number of samples
nSamples = settings.sansamples;

% Number of parameters
nPars = settings.parnum;

% Start time of the function
time_begin = datetime;

% Compute the results for GSA M1, GSA M2, and GSA N methods
results.fM1 = ...
    compute_f(results.M1, nSamples, settings, model_folders, nPars, ...
    time_begin, "GSA M1", "fM");
results.fM2 = ...
    compute_f(results.M2, nSamples, settings, model_folders, nPars, ...
    time_begin, "GSA M2", "fM");
results.fN = ...
    compute_f(results.N, nSamples, settings, model_folders, nPars, ...
    time_begin, "GSA N", "fN");
end

function [f_out] =...
    compute_f(parameter_array, nSamples, settings, model_folders, nPars, ...
    time_begin, task_name, matrix_type)

% Create a DataQueue for parallel processing
D = parallel.pool.DataQueue;

% Set up the progress tracker for the DataQueue
afterEach(D, @progress_track_GSA);

clear R RN

% Choose the matrix type and perform the calculations accordingly
switch matrix_type
    case 'fM'
        R = cell(nSamples, 1);
      
        % Parallel loop for computing the output
        parfor i = 1:nSamples
            [~, ~, R{i}] = ...
                f_sim_score(parameter_array(i,:), settings, ...
                model_folders, i, 1);
            send(D, {task_name, 0, time_begin, nSamples, nPars});
        end
        % Extract the computed values

        sd = zeros(nSamples, size(R{1}.sd, 1) * size(R{1}.sd, 2));
        se = zeros(nSamples, size(R{1}.se, 1));
        st = zeros(nSamples, size(R{1}.st, 1));
        xfinal = zeros(nSamples, size([R{1}.xfinal{:}], 2));

        for i = 1:nSamples
            sd(i, :) = reshape(R{i}.sd(:, :), 1, []);
            se(i, :) = R{i}.se(:);
            st(i, :) = R{i}.st;
            xfinal(i, :) = [R{i}.xfinal{:}];
        end
    case 'fN'
        % Nested parallel loop for computing the output
        RN = cell(nSamples, nPars);

        parfor i = 1:nSamples
            for j = 1:nPars
                % disp("i: " + i + " j: " + j)
                % settings.i = i;
                % setting.j = j;
                [~,~,RN{i,j}] = ...
                    f_sim_score(parameter_array(i, :, j), settings, ...
                    model_folders, i, j);
            end
            send(D, {task_name, 0, time_begin, nSamples, nPars});
        end

        sd = ...
            zeros(nSamples, size(RN{1, 1}.sd, 1) * ...
            size(RN{1, 1}.sd, 2), nPars);
        se = zeros(nSamples, size(RN{1, 1}.se, 1), nPars);
        st = zeros(nSamples, size(RN{1, 1}.st, 1), nPars);
        xfinal = zeros(nSamples, size([RN{1, 1}.xfinal{:}], 2), nPars);

        for i = 1:nSamples
            for j = 1:nPars
                sd(i, :, j) = reshape(RN{i, j}.sd, 1, []);
                se(i, :, j) = RN{i, j}.se;
                st(i, :, j) = RN{i, j}.st;
                xfinal(i, :, j) = [RN{i, j}.xfinal{:}];
            end
        end
end

f_out.sd = sd;
f_out.se = se;
f_out.st = st;
f_out.xfinal = xfinal;

% Display the runtime information for the task
disp(task_name + " Runtime: " + string(datetime - time_begin) +...
    "  All " + nSamples + " samples executed")
end

% Function to track progress of the GSA
function progress_track_GSA(arg)
persistent current_sample
persistent last_time

% Initialize or update the current sample counter
if isempty(current_sample) || current_sample == arg{4}
    current_sample = arg{2};
end

% Retrieve other required arguments
task_name = arg{1};
start_time = arg{3};
num_samples = arg{4};
par_n = arg{5};
current_sample = current_sample + 1;

% Print progress information at each step
if mod(current_sample, ceil(num_samples / 10)) == 0 &&...
        current_sample ~= num_samples
    % 0
    % num_samples
    % current_sample
    % ((num_samples-current_sample)/num_samples)*10
    % ((num_samples-(ceil(num_samples/10)))/num_samples)*10
    if ((num_samples - current_sample) / num_samples) * 10 <...
            ((num_samples - (ceil(num_samples / 10))) / num_samples) * 10
        % Calculate the remaining time
        % datetime
        % last_time
        dt = (datetime-last_time);
       % 1
        remaining_time = seconds(dt);
% 2
        remaining_time = ...
            remaining_time * ceil((num_samples - current_sample) / ...
            num_samples * 10);
% 3
        remaining_time = seconds(remaining_time);
% 4
        remaining_time.Format = 'hh:mm:ss';
     % 5
        % Print the progress and remaining time
        fprintf('%s Runtime: %s  Time to finish: %s  Samples: %d/%d\n', ...
            task_name, string(datetime - start_time), string(remaining_time), ...
            current_sample, num_samples);
        % 6
    else
% 7
        % Print the progress without remaining time
        fprintf('%s Runtime: %s  Samples: %d/%d\n', ...
            task_name, string(datetime - start_time), ...
            current_sample, num_samples);
        % 8
    end
% 9
    last_time = datetime;
end
end