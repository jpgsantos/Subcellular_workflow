function rst= f_makeParSamples(stg)
% Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J.
% comp. neuroscience 27.3 (2009): 471.)

% MAKE SAMPLE MATRICES
M1 = zeros(stg.sansamples, stg.parnum); % Pre-allocate memory for data
M2 = zeros(stg.sansamples, stg.parnum);
N = zeros(stg.sansamples, stg.parnum, stg.parnum);
rng(stg.rseed)

% Create a distribution for each parameter acording to settings(Note that
% the sampling is being performed in log space as the parameters and its
% bounds are in log space)
for i=1:stg.parnum
    % Uniform distribution truncated at the parameter bounds
    if stg.sasamplemode == 0
        M1(:,i) = stg.lb(i) +...
            (stg.ub(i)-stg.lb(i)).*rand(1,stg.sansamples);
        M2(:,i) = stg.lb(i) +...
            (stg.ub(i)-stg.lb(i)).*rand(1,stg.sansamples);
        % Normal distribution with mu as the best value for a parameter and
        % sigma as stg.sasamplesigma truncated at the parameter bounds
    elseif stg.sasamplemode == 1
        pd(i) = makedist('Normal','mu',stg.bestpa(i),...
            'sigma',stg.sasamplesigma);
        t(i) = truncate(pd(i),stg.lb(i),stg.ub(i));
        r{i} = random(t(i),stg.sansamples,1);
        r2{i} = random(t(i),stg.sansamples,1);
        M1(:,i) = r{i};
        M2(:,i) = r2{i};
        % Same as 1 without truncation
    elseif stg.sasamplemode == 2
        pd(i) = makedist('Normal','mu',stg.bestpa(i),...
            'sigma',stg.sasamplesigma);
        r{i} = random(pd(i),stg.sansamples,1);
        r2{i} = random(pd(i),stg.sansamples,1);
        M1(:,i) = r{i};
        M2(:,i) = r2{i};
        % Normal distribution centered at the mean of the parameter bounds
        % and sigma as stg.sasamplesigma truncated at the parameter bounds
    elseif stg.sasamplemode == 3
        pd(i) = makedist('Normal','mu',...
            stg.lb(i) + (stg.ub(i)-stg.lb(i))/2,'sigma',stg.sasamplesigma);
        t(i) = truncate(pd(i),stg.lb(i),stg.ub(i));
        r{i} = random(t(i),stg.sansamples,1);
        r2{i} = random(t(i),stg.sansamples,1);
        M1(:,i) = r{i};
        M2(:,i) = r2{i};
        % Same as 3 without truncation.
    elseif stg.sasamplemode == 4
        pd(i) = makedist('Normal','mu',...
            stg.lb(i) + (stg.ub(i)-stg.lb(i))/2,'sigma',stg.sasamplesigma);
        r{i} = random(pd(i),stg.sansamples,1);
        r2{i} = random(pd(i),stg.sansamples,1);
        M1(:,i) = r{i};
        M2(:,i) = r2{i};
    end
end

for i=1:stg.parnum
    % Replace the i:th column in M2 by the i:th column from M1 to obtain Ni
    N(:,:,i) = M2;
    N(:,i,i) = M1(:,i);
end

rst.M1=M1;
rst.M2=M2;
rst.N=N;