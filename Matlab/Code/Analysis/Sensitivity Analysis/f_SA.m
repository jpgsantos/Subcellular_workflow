function rst = f_SA(stg,script_folder)

rst = f_makeParSamples(stg);

rst = f_makeOutputSample(rst,stg,script_folder);

rst = f_calcSobolSaltelli(rst,stg);
end