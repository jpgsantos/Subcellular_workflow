function rst = f_SA(stg)

rst = makeParSamplesFromRanges(stg);

rst = makeOutputSample(rst,stg);

rst = calcSobolSaltelli(rst,stg);

% save('sampMatrices_1500_2018_2_16.mat','sampMatrices')
end
