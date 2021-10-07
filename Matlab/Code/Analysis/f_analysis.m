function rst = f_analysis(stg,analysis,mmf,analysis_options)
if contains(analysis,analysis_options(1))
    disp("Starting " + analysis_options(1))
    rst.diag = f_diagnostics(stg,mmf);
    disp(analysis_options(1) + " completed successfully")
end

if contains(analysis,analysis_options(2))
    disp("Starting " + analysis_options(2))
    rst.opt = f_opt(stg,mmf);
    disp(analysis_options(2) + " completed successfully")
end

if contains(analysis,analysis_options(3))
    disp("Starting " + analysis_options(3))
    rst.gsa = f_gsa(stg,mmf);
    disp(analysis_options(3) + " completed successfully")
end

if contains(analysis,analysis_options(4))
    disp("Starting " + analysis_options(4))
    rst.PLA = f_PL_m(stg,mmf);
    disp(analysis_options(4) + " completed successfully")
end
% if contains(analysis,"Profile Likelihood Analysis")
% % if Analysis_n == 4
%     rst.PL = f_PL_m(stg);
% end

end