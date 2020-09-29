function [x,fval] = f_PL_s(m,start_n,stg)

%Set the parameter for which we are going to perform the profile Likelihood
%calculations to the correct one
stg.PLind = m;

% Initialize variables
if stg.plsa
    x{1} = cell(stg.plres+1,1);
    fval{1} = zeros(stg.plres+1,1);
end
if stg.plfm
    x{2} = cell(stg.plres+1,1);
    fval{2} = zeros(stg.plres+1,1);
end

% Set the starting point of PL to the best solution found so far
if stg.plsa
    x{1}{start_n} = stg.bestpa;
end
if stg.plfm
    x{2}{start_n} = stg.bestpa;
end

%  Iterate over the values for which PL is going to be calculated starting
%  at the best value going up until the upper bound is reached, going back
%  to the best and going down until the lower bound is reached
for n = [start_n:stg.plres+1,start_n-1:-1:1]
    
    % Set the value of the parameter that is being worked on
    stg.PLval = stg.lb(m)+(stg.ub(m)-stg.lb(m))/...
        stg.plres*n-(stg.ub(m)-stg.lb(m))/stg.plres;
    
    % Set offset so each optimization allways starts from with the
    % appropriate parameter array
    if n == start_n
        offset = 0;
    elseif n > start_n
        offset = -1;
    elseif n < start_n
        offset = 1;
    end
    
    % Run simulated annealing if chosen in settings
    if stg.plsa
    
        % Get the optimization options from settings
        options = stg.plsao;
        
        % Optimize the model
        [x{1}{n},fval{1}(n)] = simulannealbnd(@(x)f_sim_score(x,stg),...
            x{1}{n+offset},stg.lb,stg.ub,options);
        
        % Display console messages if chosen in settings
        if stg.placsl
            disp("m: " + m + "  n: " + n +...
                "  PLval: " + stg.PLval + "  fval: " + fval{1}(n))
        end
    end
    
    % Run fmincon if chosen in settings
    if stg.plfm
        
        % Get the optimization options from settings 
        options = stg.plfmo;

        % Optimize the model
        [x{2}{n},fval{2}(n)] = fmincon(@(x)f_sim_score(x,stg),...
            x{2}{n+offset},[],[],[],[],stg.lb,stg.ub,[],options);
                
        % Display console messages if chosen in settings
        if stg.placsl
            disp("m: " + m + "  n: " + n +...
                "  PLval: " + stg.PLval + "  fval: " + fval{2}(n))
        end
    end
end
end