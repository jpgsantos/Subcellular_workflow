function results = f_calc_sensitivities(results,settings)
% Computes the first-order (Si) and total-order (SiT) sensitivity indices
% for each score type present in the input data using the bootstrap method.
% This function takes in the raw data and various settings for the
% calculation process, and returns the results structure with calculated Si
% and SiT for each score type.
%
% Inputs:
% - results: a structure containing raw data (fM1, fM2, and fN) for
% different score types
% - settings: a structure containing settings for the calculation, such as
% bootstrap size, random seed, and error score
%
% Outputs:
% - results: a modified version of the input results structure containing
% the computed Si and SiT for each score type
%
% Functions called:
% - remove_sim_error: removes simulation errors from the input data
% - bootstrap: calculates Si and SiT using the bootstrap method
% - bootstrap_q: creates bootstrapped samples and calculates Si and SiT for
% the bootstrapped samples
% - calcSobolSaltelli: calculates Si and SiT using the Sobol-Saltelli
% method
% 
% Loaded variables:
% - None
%
% Initialized variables:
% - fM1: a structure containing the first-order score data for each score type
% - fM2: a structure containing the total-order score data for each score type
% - fN: a structure containing the score data for each score type and parameter
% - settings: a structure containing settings for the calculation
%
% Persistent variables:
% - None

% Remove simulation errors from the input data
results = remove_sim_error(results,settings);

% Calculate Si and SiT using the bootstrap method and store them in the results
% structure
[results.SiQ,results.SiTQ,results.Si,results.SiT] = bootstrap(results,settings);
end

function [SiQ,SiTQ,Si,SiT]=bootstrap(results,settings)
% calculates confidence intervals for the sensitivity indices using the
% bootstrap method.

% Initialize variables
fM1 = results.fM1;
fM2 = results.fM2;
fN = results.fN;

% Set the number of resamples for bootstrapping if not provided
if (isempty(settings.gsabootstrapsize))
    settings.gsabootstrapsize=ceil(sqrt(size(fM1.sd,2)));
end%if

% Define the list of scores to be used in the calculation
scores_list = ["sd","se","st","xfinal"];

% Generate random indices for bootstrapping
for j=1:settings.gsabootstrapsize
    rng(j*settings.rseed)
    I(j,:)=ceil(rand(size(fM1.sd,1),1)*size(fM1.sd,1));
end

% Calculate Si and SiT for each score type and perform bootstrapping
for n = 1:size(scores_list,2)
    fM1h = fM1.(scores_list(n));
    fM2h = fM2.(scores_list(n));
    fNh = fN.(scores_list(n));

    % Calculate Si and SiT without bootstrapping
    [Sih,SiTh] = calcSobolSaltelli(fM1h,fM2h,fNh,settings);
    Si.(scores_list(n)) = Sih;
    SiT.(scores_list(n)) = SiTh;

    % Initialize variables for bootstrapped Si and SiT
    SiQh = cell(1, settings.gsabootstrapsize);
    SiTQh = cell(1, settings.gsabootstrapsize);

    % Perform bootstrapping for the current score type
    parfor j=1:settings.gsabootstrapsize
        [SiQh{j},SiTQh{j}] = bootstrap_q(fM1h,fM2h,fNh,settings,j,I);
    end%parfor

    % Store bootstrapped Si and SiT values in the output structures
    for j=1:settings.gsabootstrapsize
        SiQ.(scores_list(n))(j,:,:) = SiQh{j};
        SiTQ.(scores_list(n))(j,:,:) = SiTQh{j};
    end
end
end%function

function [Si,SiT] = bootstrap_q(fM1,fM2,fN,settings,j,I)
    % Create bootstrapped samples using the generated indices
    fM1q = fM1(I(j,:),:);
    fM2q = fM2(I(j,:),:);
    fNq = fN(I(j,:),:,:);

    % Calculate Si and SiT for the bootstrapped samples
    [Si,SiT] = calcSobolSaltelli(fM1q,fM2q,fNq,settings);
end

function [Si,SiT] = calcSobolSaltelli(fM1,fM2,fN,settings)
% Calculates Si and SiT using the Sobol-Saltelli method.
% Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J.
% comp. neuroscience 27.3 (2009): 471.)

% Get the dimensions of the input data
[Nsamples,Nvars,Npars]=size(fN);

% Optionally subtract the mean to stabilize the model
if(settings.sasubmean)
    fM1 = fM1 - mean(fM1,1);
    fM2 = fM2 - mean(fM2,1);
    for i=1:Npars
        fN(:,:,i) =  fN(:,:,i) - mean(fN(:,:,i),1);
    end
end

% Calculate EY2 and variances
EY2 = mean(fM1.*fM2); % Valid definition (see Halnes et. al. Appendix)
VY = sum(fM1.^2)/(Nsamples-1) - EY2;
VYT = sum(fM2.^2)/(Nsamples-1) - EY2;

% Initialize Si and SiT arrays
Si = zeros(Nvars,Npars);
SiT= zeros(Nvars,Npars);

% Calculate Si and SiT for each parameter
for i=1:Npars
    Si(:,i) = (sum(fM1.*fN(:,:,i))/(Nsamples-1) - EY2)./VY;
    SiT(:,i) = 1 - (sum(fM2.*fN(:,:,i))/(Nsamples-1) - EY2)./VYT;
end
end

function results = remove_sim_error(results,settings)
% Removes any simulation errors present in the input data.
error_indices = any(results.fM1.sd >= settings.errorscore, 2) | ...
                any(results.fM2.sd >= settings.errorscore, 2) | ...
                any(any(results.fN.sd >= settings.errorscore, 3), 2);

% Remove error rows from all fields of the input data
fields = fieldnames(results.fM1);
for i = 1:numel(fields)
    results.fM1.(fields{i})(error_indices, :) = [];
    results.fM2.(fields{i})(error_indices, :) = [];
    results.fN.(fields{i})(error_indices, :, :) = [];
end
end