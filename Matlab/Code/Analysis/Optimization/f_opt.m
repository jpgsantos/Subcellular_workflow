function rst = f_opt(stg,mmf)
% Call function to run fmincon optimization algorithm if chosen in settings

if stg.fmincon
    rst(1) = f_opt_fmincon(stg,mmf);
end

% Call function to run simulated annealing optimization algorithm if chosen
% in settings
if stg.sa
    rst(2) = f_opt_sa(stg,mmf);
end

% Call function to run pattern search optimization algorithm if chosen in
% settings
if stg.psearch
    rst(3) = f_opt_psearch(stg,mmf);
end

% Call function to run genetic algorithm optimization if chosen in settings
if stg.ga
    rst(4) = f_opt_ga(stg,mmf);
end

% Call function to run Particle swarm optimization algorithm if chosen in
% settings
if stg.pswarm
    rst(5) = f_opt_pswarm(stg,mmf);
end

% Call function to run Surrogate optimization algorithm if chosen in
% settings
if stg.sopt
    rst(6) = f_opt_sopt(stg,mmf);
end
end