function rst = f_lsa(stg,mmf)
% Performs a local sensitivity analysis (LSA) on a given model by
% perturbing its parameters within a specified range and computing the
% impact of these perturbations on the model's output. The LSA is performed
% by generating a set of perturbed parameter sets (B_star) and evaluating
% the model's score for each set. The results include various statistics
% related to the sensitivity of each parameter, such as mean and standard
% deviation.
% 
% Inputs:
% - stg: A structure containing settings for the LSA, including:
%         - lsa_samples: number of LSA samples
%         - lsa_range_from_best: range of perturbations around the best
%           parameter
%         - parnum: number of model parameters
%         - ub: upper bounds for parameters
%         - lb: lower bounds for parameters
%         - bestpa: the best parameter set found so far
% - mmf: A structure containing the model and model-related functions
%
% Outputs:
% - rst: A structure containing the results of the LSA, including:
%         - B_star: the perturbed parameter sets
%         - score_B_star: scores for each perturbed parameter set
%         - x1, x11, x22: intermediate variables from the B_star
%           calculation
%         - P_matrix: permutation matrices used in the B_star calculation
%         - parameter_score: differences in scores for perturbed parameters
%         - parameter_score_delta: parameter_score scaled by delta
%         - sum_parameter_score, sum_parameter_score_delta: sum of absolute
%           parameter_score(_delta) values
%         - mean_parameter_score, mean_parameter_score_delta: mean of
%           absolute parameter_score(_delta) values
%         - sigma_parameter_score, sigma_parameter_score_delta: standard
%           deviation of parameter_score(_delta) values
%         - average_deviation: average deviation of sensitivity for each
%           parameter
%         - sigma_deviation: standard deviation of sensitivity for each
%           parameter
%
% Functions called:
% - f_sim_score: Computes the score for a given parameter set
%
% Variables:
% Initialized:
% - number_samples: Number of LSA samples
% - range_from_best: Range of perturbations around the best parameter
% - parameter_n: Number of model parameters
% - par_n_plus_1: One plus the number of model parameters
% - B_star: Perturbed parameter sets
% - B_matrix: Lower triangular matrix used in LSA calculations
% - J_matrix: Matrix of ones used in LSA calculations
% - P_matrix: Permutation matrix used in LSA calculations
% - x_pool: Set of possible x_star values
% - x_star: Random value from x_pool for each parameter
% - d: Random direction vector for perturbation
% - D_matrix: Diagonal matrix with elements of d
% - x11, x22: Indices for randomly permuting P_matrix
% - x1: Linear indices from x11 and x22 for assigning elements in P_matrix
% - score_B_star: Scores for each perturbed parameter set
% - parameter_score: Differences in scores for perturbed parameters
% - parameter_score_delta: Parameter_score scaled by delta

% Initialize variables and matrices for LSA
number_samples = stg.lsa_samples;
range_from_best = stg.lsa_range_from_best;

% Define parameters for the LSA
p = 21;
p_1 = 1;% integer between 1 and p-1
delta = p_1/(p-1);

parameter_n = stg.parnum;
par_n_plus_1 = parameter_n+1;
B_star = [];

% Define B_matrix and J_matrix for LSA calculations
B_matrix = tril(ones(par_n_plus_1, parameter_n), -1);
J_matrix = ones(par_n_plus_1,parameter_n);

% Main loop for generating B_star matrix
for i = 1:number_samples

    % Generate random direction vector
    d = sign(rand(1, parameter_n) - 0.5);

    D_matrix= diag(d);

    % Calculate x_star, a random value from x_pool
    x_pool = (1:p - p_1) / (p - 1) - 1 / (p - 1);
    x_star = x_pool(randi(length(x_pool), 1, parameter_n));

    % Initialize and fill P_matrix with permutation matrix
    P_matrix = zeros(parameter_n,parameter_n);

    x11 = randperm(parameter_n);
    x22 = randperm(parameter_n);

    x1 = sub2ind([parameter_n,parameter_n], x11, x22);
    P_matrix(x1) = 1;

    % Store intermediate values for later use
    x11_1(i,:) = x11;
    x22_1(i,:) = x22;
    x1_1(i,:) = x1;
    P_matrix_1((i-1)*parameter_n+1:i*parameter_n,:) = P_matrix;

B_star((i-1)*(par_n_plus_1)+1:i*par_n_plus_1,:) =...
       ((J_matrix(par_n_plus_1,1)*x_star)+(delta/2)*...
       ((((2*B_matrix)-J_matrix)*D_matrix)+J_matrix))*P_matrix;
end

% B_star = B_star.*(stg.ub-stg.lb)+stg.lb; 
% delta_scaled = delta * (stg.ub-stg.lb);

% Update B_star with the scaled range from the best parameter
B_star = ...
    stg.bestpa(1:parameter_n) + B_star.*(range_from_best*2)-range_from_best;

% Scale delta by the range from the best parameter
delta_scaled = delta * (range_from_best * 2) * ones(1, parameter_n);

% Initialize progress tracking variables
progress = 1;
time_begin = datetime;
D = parallel.pool.DataQueue;
afterEach(D, @progress_track);

% Parallel loop for calculating score_B_star
parfor n = 1:number_samples*par_n_plus_1
    [~,~,score_B_star(n)] = f_sim_score(B_star(n,:),stg,mmf);
    send(D, {"LSA",progress,time_begin,number_samples,par_n_plus_1});
end

% Store results in the output structure
rst.B_star = B_star;
rst.score_B_star = score_B_star;
rst.x1 = x1_1;
rst.x11 = x11_1;
rst.x22 = x22_1;
rst.P_matrix = P_matrix_1;

% Calculate and store parameter_score
for n = 1:number_samples
    for i = 1:parameter_n
        parameter_score(n,x22_1(n,i)) =...
            score_B_star(x11_1(n,i)+(n-1)*(parameter_n+1)).st -...
            score_B_star(x11_1(n,i)+1+(n-1)*(parameter_n+1)).st;
    end
end

% Store parameter_score and related statistics in the output structure
rst.parameter_score = parameter_score;
for n = 1:parameter_n
    parameter_score_delta(:,n) = parameter_score(:,n)/delta_scaled(n);
end
rst.parameter_score_delta = parameter_score_delta;
rst.sum_parameter_score = sum(abs(parameter_score));
rst.sum_parameter_score_delta = sum(abs(parameter_score_delta));
rst.mean_parameter_score = sum(abs(parameter_score))/number_samples;
rst.mean_parameter_score_delta = 
sum(abs(parameter_score_delta))/number_samples;
rst.sigma_parameter_score =...
    sqrt((1/(number_samples-1))*...
    sum((parameter_score-sum(parameter_score)/number_samples).^2));
rst.sigma_parameter_score_delta =...
    sqrt((1/(number_samples-1))*...
    sum((parameter_score_delta-sum(parameter_score_delta)/number_samples).^2));

% Store average and sigma deviations for each parameter
rst.average_deviation = rst.mean_parameter_score_delta(1,:);
rst.sigma_deviation = rst.sigma_parameter_score_delta;
end

% Function to track progress of the LSA
function progress_track(arg)
persistent current_sample
persistent last_time
task_name = arg{1};

if isempty(current_sample)
    current_sample = arg{2};
end

start_time = arg{3};
num_samples = arg{4};
par_n_plus_1 = arg{5};
current_sample = current_sample + 1;

% Print progress information at each step
if mod(current_sample,ceil(num_samples*par_n_plus_1/par_n_plus_1)) == 0 &&...
        current_sample ~= num_samples*par_n_plus_1
    if (num_samples*par_n_plus_1-current_sample)/num_samples <=...
            par_n_plus_1-2

        dt = (datetime-last_time);
        remaining_time = seconds(dt);
        remaining_time =...
            remaining_time*(num_samples*par_n_plus_1-current_sample)/
        num_samples;
        remaining_time = seconds(remaining_time);
        remaining_time.Format = 'hh:mm:ss';
        
        fprintf('%s Runtime: %s  Time to finish: %s  Samples: %d/%d\n', ...
                    task_name, string(datetime - start_time), ...
                    string(remaining_time), ...
                    current_sample, num_samples * par_n_plus_1);
    else
        
        fprintf('%s Runtime: %s  Samples: %d/%d\n', ...
                    task_name, string(datetime - start_time), ...
                    current_sample, num_samples * par_n_plus_1);
    end
    last_time = datetime;
end
end