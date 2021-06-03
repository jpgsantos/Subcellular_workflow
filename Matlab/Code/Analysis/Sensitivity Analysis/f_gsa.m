function rst = f_gsa(stg,script_folder)

rst = f_make_par_samples(stg);

rst = f_make_output_sample(rst,stg,script_folder);

rst = f_calc_sensitivities(rst,stg);
end