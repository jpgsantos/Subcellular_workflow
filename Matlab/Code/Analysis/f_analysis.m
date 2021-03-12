function rst = f_analysis(stg,analysis)

if contains(analysis,"Diagnostics")
% if Analysis_n == 1
    rst.diag = f_diagnostics(stg);
end
if contains(analysis,"Optimization")
% if Analysis_n == 2
    rst.opt = f_opt(stg);
end
if contains(analysis,"Sensitivity Analysis")
% if Analysis_n == 3
    rst.SA = f_SA(stg);
end
if contains(analysis,"Profile Likelihood Analysis")
% if Analysis_n == 4
    rst.PL = f_PL_m(stg);
end
end