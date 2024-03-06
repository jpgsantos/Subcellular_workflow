function results= f_make_par_samples(settings)
% This function creates sample matrices of model parameters according to
% specified distributions and settings, based on Geir Halnes et al.'s 2009
% paper (J. comp. neuroscience 27.3 (2009): 471). It generates two sample
% matrices M1 and M2, and a 3D matrix N, where N(:,:,i) is M2 with its i:th
% column replaced by M1(:,i).
%
% Inputs:
% - settings: A structure containing fields for generating samples,
% including sansamples, parnum, rseed, sasamplemode, lb, ub, bestpa, and
% sasamplesigma.
%
% Outputs:
% - results: A structure containing the following fields:
% - M1: Sample matrix 1.
% - M2: Sample matrix 2.
% - N: A 3D matrix where N(:,:,i) is M2 with its i:th column replaced by
% M1(:,i).
%
% Functions called:
% - makedist: Create a probability distribution object.
% - truncate: Truncate a probability distribution.
% - random: Generate random numbers from a probability distribution.
%
% Variables:
% Initialized:
% - M1: Sample matrix 1.
% - M2: Sample matrix 2.
% - N: A 3D matrix where N(:,:,i) is M2 with its i:th column replaced by
% M1(:,i).
% - pd: An array of probability distribution objects for each parameter.
%
% Loaded (from settings structure):
% - sansamples: Number of samples to generate for each parameter.
% - parnum: Number of model parameters.
% - rseed: Seed for the random number generator.
% - sasamplemode: Sampling mode.
% - lb: Vector containing lower bounds for each parameter.
% - ub: Vector containing upper bounds for each parameter.
% - bestpa: Vector containing the best parameter values.
% - sasamplesigma: Standard deviation for normal distribution-based
% sampling modes.

% Pre-allocate memory for sample matrices
M1 = zeros(settings.sansamples, settings.parnum);
M2 = zeros(settings.sansamples, settings.parnum);
N = zeros(settings.sansamples, settings.parnum, settings.parnum);
rng(settings.rseed)

% Loop through each parameter and create a distribution based on the
% specified settings(Note that the sampling is being performed in log space
% as the parameters and its bounds are in log space)
for i = 1:settings.parnum
    % Initialize distribution parameters depending on the sample mode
    switch settings.sasamplemode
        case 0
            % Uniform distribution with bounds defined by parameter limits
            lb = settings.lb(i);
            ub = settings.ub(i);
        case {1, 2}
            % Normal distribution centered at the best parameter value with
            % specified standard deviation
            mu = settings.bestpa(i);
            sigma = settings.sasamplesigma;
        case {3, 4}
            % Normal distribution centered at the mean of parameter bounds
            % with specified standard deviation
            mu = settings.lb(i) + (settings.ub(i) - settings.lb(i)) / 2;
            sigma = settings.sasamplesigma;
    end
    % Generate samples based on the distribution parameters
    if settings.sasamplemode == 0
        % Uniform distribution
        M1(:, i) = lb + (ub - lb) .* rand(1, settings.sansamples);
        M2(:, i) = lb + (ub - lb) .* rand(1, settings.sansamples);
    else
        % Normal distribution
        pd(i) = makedist('Normal', 'mu', mu, 'sigma', sigma);

        % Truncate the distribution if specified
        if ismember(settings.sasamplemode, [1, 3])
            pd(i) = truncate(pd(i), settings.lb(i), settings.ub(i));
        end
        M1(:, i) = random(pd(i), settings.sansamples, 1);
        M2(:, i) = random(pd(i), settings.sansamples, 1);
    end
end
% Replace the i:th column in M2 by the i:th column from M1 to create N
% matrices
for i=1:settings.parnum
    N(:,:,i) = M2;
    N(:,i,i) = M1(:,i);
end

% Store resulting matrices in the output structure
results.M1=M1;
results.M2=M2;
results.N=N;
end