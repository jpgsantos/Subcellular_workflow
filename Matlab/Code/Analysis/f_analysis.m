function [rst,stg] = f_analysis(stg,analysis,mmf,analysis_options,rst)

% n = find(contains(analysis_options,analysis) == 1);

switch find(contains(analysis_options,analysis) == 1)
    case 1
        disp("Starting " + analysis_options(1))
        rst.diag = f_diagnostics(stg,mmf);
        disp(analysis_options(1) + " completed successfully")
    case 2
        disp("Starting " + analysis_options(2))
        [rst.opt,pa] = f_opt(stg,mmf);
%         rst.diag = f_diagnostics(stg,mmf);
%         pa(1,:) = rst.opt(4).x;
%         pa
        stg.pat = 4;
        for n=4
            [~,rst_1(n),~] = f_sim_score(pa(n,:),stg,mmf);
        end
        rst.diag = rst_1;
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