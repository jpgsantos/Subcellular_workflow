function rst = f_analysis(stg,analysis,mmf,analysis_options)

if contains(analysis,analysis_options(1))
    rst.diag = f_diagnostics(stg,mmf);
end
if contains(analysis,analysis_options(2))
    rst.opt = f_opt(stg,mmf);
end
if contains(analysis,analysis_options(3))
    rst.gsa = f_gsa(stg,mmf);
end
end