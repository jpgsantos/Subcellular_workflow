function rst = f_gsa(stg,mmf)

rst = f_make_par_samples(stg);

rst = f_make_output_sample(rst,stg,mmf);

rst = f_calc_sensitivities(rst,stg);
end