function rst = f_analysis(stg,analysis,mmf)

if contains(analysis,"Diagnostics")
    rst.diag = f_diagnostics(stg,mmf);
end

if contains(analysis,"Optimization")%broken
    rst.opt = f_opt(stg,mmf);
end
if contains(analysis,"Sensitivity Analysis")%broken
    rst.gsa = f_gsa(stg,mmf);
end
end