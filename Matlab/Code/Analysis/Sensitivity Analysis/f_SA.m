function rst = f_SA(stg)

rst = f_makeParSamples(stg);

rst = f_makeOutputSample(rst,stg);

rst = f_calcSobolSaltelli(rst,stg);
end