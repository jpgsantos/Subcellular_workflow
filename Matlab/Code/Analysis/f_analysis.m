function rst = f_analysis(stg,analysis)

if contains(analysis,"Diagnostics")
    rst.diag = f_diagnostics(stg);
end
if contains(analysis,"Optimization")
    rst.opt = f_opt(stg);
end
if contains(analysis,"Sensitivity Analysis")
    rst.SA = f_SA(stg);
end
if contains(analysis,"Profile Likelihood Analysis")
    rst.PL = f_PL_m(stg);
end
end