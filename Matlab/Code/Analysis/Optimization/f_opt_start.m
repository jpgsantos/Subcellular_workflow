function [spoint,spop] = f_opt_start(stg)

% Set the randomm seed for reproducibility
rng(stg.rseed);

% Optimization Start method 1
if stg.osm == 1
    
    % Get a random starting point or group of starting points, if using
    % multistart, inside the bounds
    spoint = lhsdesign(stg.msts,stg.parnum).*(stg.ub-stg.lb)+stg.lb;
    
    % Get a group of ramdom starting points inside the bounds
    spop = lhsdesign(stg.popsize,stg.parnum).*(stg.ub-stg.lb)+stg.lb;
    
    % Optimization Start method 2
elseif stg.osm == 2
    
    % Get a random starting point or group of starting points, if using
    % multistart, near the best point
    spoint = stg.bestpa - stg.dbpa +...
        (stg.dbpa*2*lhsdesign(stg.msts,stg.parnum));
    
    % Get a group of ramdom starting points near the best point
    spop = stg.bestpa - stg.dbpa +...
        (stg.dbpa*2*lhsdesign(stg.popsize,stg.parnum));
end
end