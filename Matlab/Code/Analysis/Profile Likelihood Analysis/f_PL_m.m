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
        rst.sa.x(n) = x{n}(1);
        rst.sa.fval(n) = fval{n}(1);
    end
    if stg.plfm
        rst.fm.x(n) = x{n}(2);
        rst.fm.fval(n) = fval{n}(2);
    end
end
end




