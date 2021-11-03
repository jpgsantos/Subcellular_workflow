function rst = f_lsa(stg,mmf)

number_samples = stg.lsa_samples;
range_from_best = stg.lsa_range_from_best;

pa = [];
for m = 1:stg.parnum
    for n = 1:number_samples
        pa(n,:) = stg.bestpa;
        pa(n,m) = stg.bestpa(m)-range_from_best+range_from_best*2/(number_samples-1)*(n-1);
    end
    parfor n = 1:number_samples
        [~,~,parameter(n)] = f_sim_score(pa(n,:),stg,mmf);
        score_total(n) = parameter(n).st;
    end
    rst(m).lsa = parameter(:);
    rst(m).score_total = score_total;
    rst(m).average_deviation = mean(score_total);
    rst(m).sigma_deviation = sqrt(sum((score_total-mean(score_total)).^2)/(number_samples-1));
end
end