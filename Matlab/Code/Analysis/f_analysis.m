function rst = f_analysis(stg,analysis)

if contains(analysis,"diag")
    rst.diag = f_diagnostics(stg);
end
if contains(analysis,"opt")
    rst.opt = f_opt(stg);
end
if contains(analysis,"SA")
    rst.SA = f_SA(stg);
end
end

