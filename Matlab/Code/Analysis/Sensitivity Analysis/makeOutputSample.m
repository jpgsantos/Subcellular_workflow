function rst = makeOutputSample(rst,stg)
% Code partly by Geir Halnes et al. (Halnes, Geir, et al. J. comp. neuroscience 27.3 (2009): 471.)

nSamples = stg.sansamples;
[nOutputs,~] = f_get_outputs(stg);
nPars = stg.ms.parnum;
fM1 = NaN(nSamples,nOutputs);
fM2 = NaN(nSamples,nOutputs);
fN = NaN(nSamples,nOutputs,nPars);
parameter_array = zeros(nSamples,nPars);

for i=1:nSamples
    parameter_array(i,:) = rst.M1(i,:);
end

parfor i=1:nSamples
    disp("M1 " + i + "/" + nSamples)
    [~,a(i)] = f_sim_score(parameter_array(i,:),stg);
end

for i=1:nSamples
    if stg.samode == 0
        fM1(i,:) = [a(i).sd{:}];
    else
        fM1(i,:) = [a(i).xfinal{:}];
    end
end

clear a

for  i=1:nSamples
    parameter_array(i,:)= rst.M2(i,:);
end

parfor i=1:nSamples
    disp("M2 " + i + "/" + nSamples)
    [~,a(i)] = f_sim_score(parameter_array(i,:),stg);
end

for  i=1:nSamples
     if stg.samode == 0
        fM2(i,:) = [a(i).sd{:}];
     else
        fM2(i,:) = [a(i).xfinal{:}];
     end
end


for i=1:nSamples
    for j=1:nPars
        parameter_array(i,:,j)= rst.N(i,:,j);
    end
end

parfor i=1:nSamples
    disp("N " + i + "/" + nSamples)
    for j=1:nPars
        if ~mod(j,35)
            disp("N " + i + "/" + nSamples + " Par " + j + "/" + nPars)
        end
        [~,b{i,j}] = f_sim_score(parameter_array(i,:,j),stg);
    end
end

for i=1:nSamples
    for j=1:nPars
         if stg.samode == 0
            fN(i,:,j) = [b{i,j}.sd{:}];
         else
            fN(i,:,j) = [b{i,j}.xfinal{:}];
         end
    end
end

rst.fM1=fM1;
rst.fM2=fM2;
rst.fN=fN;
end

