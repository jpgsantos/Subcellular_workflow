function rst = f_lsa(stg,mmf)

number_samples = stg.lsa_samples;
range_from_best = stg.lsa_range_from_best;

pa = [];

p = 21;% needs to go to settings file
p_1 = 1;% an integer between 1 and p-1 // needs to go to settings file
delta = p_1/(p-1);

k = stg.parnum;
m = k+1;
r = number_samples;% needs to go to settings file
B_star = [];

P_matrix_1 = [];
x1_1 = [];
x11_1 = [];
x22_1 = [];
for l = 1:r
    B_matrix = zeros(m,k);

    for j = 2:m
        for n = 1:j-1
            B_matrix(j,n) = 1;
        end
    end

    for n = 1:k
        d(n) = (floor(rand+0.5)*2)-1;
    end

    D_matrix= diag(d);

    J_matrix = ones(m,k);

    x_star = zeros (1,k);

    for n = 1:p-p_1
        x_pool(n) = n/(p-1)-1/(p-1);
    end

    for n = 1:k
        x_star(n) = x_pool(randi(length(x_pool)));
    end

    P_matrix = zeros(k,k);

    x11 = randperm(k);
    x22 = randperm(k);

    x1 = sub2ind(size(P_matrix), x11, x22); % Create Linear Indices For ‘1’
    P_matrix(x1) = 1;
    x11_1 = [x11_1;x11];
    x22_1 = [x22_1;x22];
    x1_1 = [x1_1;x1];
    P_matrix_1 = [P_matrix_1;P_matrix];

    B_star = [B_star;((J_matrix(m,1)*x_star)+(delta/2)*((((2*B_matrix)-J_matrix)*D_matrix)+J_matrix))*P_matrix];

end

% B_star = B_star.*(stg.ub-stg.lb)+stg.lb;
% delta_scaled = delta * (stg.ub-stg.lb);

B_star = stg.bestpa(1:k) + B_star.*(range_from_best*2)-range_from_best;
for n = 1:k
delta_scaled(n) = delta * (range_from_best*2);
end
progress = 1;
time_begin = datetime;
D = parallel.pool.DataQueue;
afterEach(D, @progress_track);

parfor n = 1:r*m
    [~,~,score_B_star(n)] = f_sim_score(B_star(n,:),stg,mmf);
    send(D, "LSA ");
end

rst.B_star = B_star;
rst.score_B_star = score_B_star;
rst.x1 = x1_1;
rst.x11 = x11_1;
rst.x22 = x22_1;
rst.P_matrix = P_matrix_1;
for n = 1:r
    for m = 1:k
        parameter_score(n,x22_1(n,m)) = score_B_star(x11_1(n,m)+(n-1)*(k+1)).st -...
            score_B_star(x11_1(n,m)+1+(n-1)*(k+1)).st;
    end
end

rst.parameter_score = parameter_score;
for n = 1:k
    parameter_score_delta(:,n) = parameter_score(:,n)/delta_scaled(n);
end
rst.parameter_score_delta = parameter_score_delta;
rst.sum_parameter_score = sum(abs(parameter_score));
rst.sum_parameter_score_delta = sum(abs(parameter_score_delta));
rst.mean_parameter_score = sum(abs(parameter_score))/r;
rst.mean_parameter_score_delta = sum(abs(parameter_score_delta))/r;
rst.sigma_parameter_score = sqrt((1/(r-1))*sum((parameter_score-sum(parameter_score)/r).^2));
rst.sigma_parameter_score_delta = sqrt((1/(r-1))*sum((parameter_score_delta-sum(parameter_score_delta)/r).^2));

for m = 1:stg.parnum

    rst.average_deviation(m) = rst.mean_parameter_score_delta(1,m);
    rst.sigma_deviation(m) = rst.sigma_parameter_score_delta(m);
end


    function progress_track(name)
        progress = progress + 1;
        if mod(progress,ceil(r*m/m)) == 0 && progress ~= r*m
            disp(name + "Runtime: " + string(datetime - time_begin) +...
                "  Samples:" + progress + "/" + r*m)
        end
    end

end