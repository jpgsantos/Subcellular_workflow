function rst = f_analysis(stg,analysis,mmf,analysis_options,rst)

% n = find(contains(analysis_options,analysis) == 1);

switch find(contains(analysis_options,analysis) == 1)
    case 1
        disp("Starting " + analysis_options(1))
        rst.diag = f_diagnostics(stg,mmf);
        disp(analysis_options(1) + " completed successfully")
    case 2
        disp("Starting " + analysis_options(2))
        rst.opt = f_opt(stg,mmf);
        disp(analysis_options(2) + " completed successfully")
    case 3
        disp("Starting " + analysis_options(3))
        rst.lsa = f_lsa(stg,mmf);
        disp(analysis_options(3) + " completed successfully")
    case 4
        disp("Starting " + analysis_options(4))
        rst.gsa = f_gsa(stg,mmf);
        disp(analysis_options(4) + " completed successfully")
    case 5
        disp("Starting " + analysis_options(5))
        rst.PLA = f_PL_m(stg,mmf);
        disp(analysis_options(5) + " completed successfully")
end
end