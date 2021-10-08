function rst = f_PL_m(stg,mmf)

% Iterate over the parameters for which PL is going to be calculated
for m = stg.pltest
    
    % Find the index of the starting point for PL taking into consideration
    % the lower bound and upper bound of the parameter and number of points
    % to be calculated
    [~,start_n{m}] = min(abs(stg.bestpa(m) -...
        (stg.lb(m):(stg.ub(m) - stg.lb(m))/stg.plres:stg.ub(m))));
end

% Iterate over the parameters for which PL is going to be calculated
parfor m = stg.pltest
    
    % Calculate Profile Likelihood
    [x{m},fval{m}] = f_PL_s(m,start_n{m},stg,mmf);
end

% Assign the values of x and fval to the correct struct entries, this needs
% to be done because struct assignemnts don't work inside parfor loop
for n = stg.pltest
    
    if stg.plsa
        rst.sa.xt(n) = x{n}(1);
        rst.sa.fvalt(n) = fval{n}(1);
    end
    if stg.plfm
        rst.fm.xt(n) = x{n}(2);
        rst.fm.fvalt(n) = fval{n}(2);
    end
end

for j = stg.exprun
exprun = stg.exprun;
% useLog = stg.useLog;
stg.exprun = j;
% stg.useLog = 5;
parfor m = stg.pltest
    % Calculate Profile Likelihood
    [x{m},fval{m}] = f_PL_s(m,start_n{m},stg,mmf);
end
% Assign the values of x and fval to the correct struct entries, this needs
% to be done because struct assignemnts don't work inside parfor loop
for n = stg.pltest
    
    if stg.plsa
        rst.sa.x{j}(n) = x{n}(1);
        rst.sa.fval{j}(n) = fval{n}(1);
    end
    if stg.plfm
        rst.fm.x{j}(n) = x{n}(2);
        rst.fm.fval{j}(n) = fval{n}(2);
    end
end
stg.exprun = exprun;  
% stg.useLog = useLog;
end
end




