function rst = f_score(rst,stg)

persistent sbtab
persistent Data

% Import the data on the first run
if isempty(Data)
    load("Model/" +stg.folder_model + "/Data/data_"+stg.name+".mat",'Data','sbtab')
end

% Iterate over the number of experiments
for n = stg.ms.exprun
    
    % Iterate over the number of datasets per experiment
    for j = 1:size(sbtab.datasets(n).output,2)
        
        % Calculate score per dataset if there are no errors
        if rst.simd{n} ~= 0
            
            rst.x{n,1}(:,j) = rst.simd{n}.Data(:,end-size(sbtab.datasets(n).output,2)+j);
            rst.xfinal{n,1}(j) = rst.simd{n}.Data(end,end-size(sbtab.datasets(n).output,2)+j);
            
            % Calculate score using formula that accounts for normalization
            % with the starting point of the result
            if sbtab.datasets(n).normstart == 1
                rst.sd{n,1}(j) = sum(((Data(n).Experiment.x(:,j)-...
                    (rst.simd{n}.Data(:,end-size(sbtab.datasets(n).output,2)+j)./...
                    rst.simd{n}.Data(1,end-size(sbtab.datasets(n).output,2)+j)))./...
                    (Data(n).Experiment.x_SD(:,j))).^2)/...
                    (size(Data(n).Experiment.x(:,j),1)-2);
                
                % Calulate score using normal scorring formula
            else
                rst.sd{n,1}(j) = sum(((Data(n).Experiment.x(:,j)-...
                    rst.simd{n}.Data(:,end-size(sbtab.datasets(n).output,2)+j))./...
                    (Data(n).Experiment.x_SD(:,j))).^2)/...
                    (size(Data(n).Experiment.x(:,j),1)-2);
            end
            
            % If there are errors output a very high score value (10^10)
        elseif rst.simd{n} == 0 || rst.sd{n,1}(j) == inf
            rst.sd{n,1}(j) = 10^10;
            rst.xfinal{n,1}(j) = 0;
        end
        
        % Calculate the log10 of dataset score if option selected
        if stg.useLog == 1
            rst.sd{n,1}(j) = max(0,log10(rst.sd{n,1}(j)));
        end
    end
    
    % Calculate score per experiment
    rst.se(n,1) = sum(rst.sd{n,1});
    
    % Calculate the log10 of experiment score if option selected
    if stg.useLog == 2
        rst.se(n,1) = log10(rst.se(n,1));
    end
end

% Calculate score per experiment
rst.st = sum(rst.se);

% Calculate the log10 of total score if option selected
if stg.useLog == 3
    rst.st = log10(rst.st);
end
end