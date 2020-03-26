function rst = f_analysis(stg,analysis)

% % Uncomment the analysis to be run

if contains(analysis,"RS")
    rst.RS = f_RS(stg,10);
end
if contains(analysis,"diag")
    rst.diag = f_diagnostics(stg);
end
if contains(analysis,"optlocal")
    rst.opt = f_opt(stg);
end
if contains(analysis,"optcluster")
    f_opt_cluster(stg);
end
if contains(analysis,"PLlocal")
    rst.PL = f_PL_m(stg);
end
if contains(analysis,"PLcluster")
    f_PL_cluster(stg);
end
if contains(analysis,"SAlocal")
    rst.SA = f_SA(stg);
end
if contains(analysis,"SAcluster")
    f_SA_cluster(stg);
end

if stg.plot
    f_plot(rst,stg)
end

end

