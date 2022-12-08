function rst = f_score(rst, stg, mmf)

persistent sbtab
persistent Data

data_model = mmf.model.data.data_model;

% Import the data on the first run
if isempty(Data)
    load(data_model,'Data','sbtab')
end

% Iterate over the number of experiments
for n = stg.exprun

    % Iterate over the number of datasets per experiment
    for j = 1:size(sbtab.datasets(n).output,2)

        % Calculate score per dataset if there are no errors
        if rst.simd{n} ~= 0

            data = Data(n).Experiment.x(:,j);
            data_sd = Data(n).Experiment.x_SD(:,j);
            number_points = size(Data(n).Experiment.x(:,j),1);
            sim_results = f_normalize(rst,stg,n,j,mmf);
            rst.xfinal{n,1}(j) = sim_results(end);

            % Calculate score using formula that accounts for normalization
            % with the starting point of the result
            switch stg.useLog
                case 0
                    rst.sd(j,n) = sum(((data - sim_results) ./ (data_sd)).^2) / number_points;
                case 1
                    rst.sd(j,n) = max(0, log10(sum(((data - sim_results) ./ (data_sd)).^2) / number_points));
                case 2
                    rst.sd(j,n) = sum(((data - sim_results) ./ (data_sd)).^2) / number_points;
                case 3
                    rst.sd(j,n) = sum(((data - sim_results) ./ (data_sd)).^2) / number_points;
                case 4
                    rst.sd(j,n) = sum(((data - sim_results) ./ (data_sd * sqrt(number_points))).^2);
                otherwise
                    error('Invalid value for stage.useLog: %d', stg.useLog);
            end

            % If there are errors output a very high score value (10^10)
        elseif rst.simd{n} == 0 || rst.sd(n,j) == inf
            rst.sd(j,n) = stg.errorscore;
            rst.xfinal{n,1}(j) = 0;
        end
    end

    % Calculate score per experiment
    rst.se(n, 1) = sum(rst.sd(:,n));

    % Calculate the log10 of experiment score if option selected
    switch stg.useLog
        case 2
            rst.se(n,1) = log10(rst.se(n,1));
        otherwise
            % Do nothing
    end
end

% Calculate score per experiment
rst.st = sum(rst.se);

% Calculate the log10 of total score if option selected
switch stg.useLog
    case 3
        rst.st = log10(rst.st);
    otherwise
        % Do nothing
end
end