function rst = f_analysis(stg,analysis,script_folder)

if contains(analysis,"Diagnostics")
    rst.diag = f_diagnostics(stg,script_folder);
end
if contains(analysis,"Optimization")
    rst.opt = f_opt(stg,script_folder);
end
if contains(analysis,"Sensitivity Analysis")
    rst.SA = f_SA(stg,script_folder);
end
end