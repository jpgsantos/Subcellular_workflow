function rst = f_SA(stg)

rst = makeParSamplesFromRanges(stg);

rst = makeOutputSample(rst,stg);

rst = calcSobolSaltelli(rst,stg);
end