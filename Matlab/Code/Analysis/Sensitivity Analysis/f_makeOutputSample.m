function rst = f_makeOutputSample(rst,stg)
% Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J.
% comp. neuroscience 27.3 (2009): 471.)

nSamples = stg.sansamples;
[nOutputs,~] = f_get_outputs(stg);
nPars = stg.parnum;
parameter_array = zeros(nSamples,nPars);

for i=1:nSamples
    parameter_array(i,:) = rst.M1(i,:);
end

parfor i=1:nSamples
    disp("M1 " + i + "/" + nSamples)
    [~,~,RM1(i)] = f_sim_score(parameter_array(i,:),stg);
end

for i=1:nSamples
    fM1.sd(i,:) = [RM1(i).sd{:}];
    fM1.se(i,:) = RM1(i).se(:);
    fM1.st(i,:) = RM1(i).st;
    fM1.xfinal(i,:) = [RM1(i).xfinal{:}];
end

rst.fM1 = fM1;
clear a FM1

for  i=1:nSamples
    parameter_array(i,:)= rst.M2(i,:);
end

parfor i=1:nSamples
    disp("M2 " + i + "/" + nSamples)
    [~,~,RM2(i)] = f_sim_score(parameter_array(i,:),stg);
end

for i=1:nSamples
    fM2.sd(i,:) = [RM2(i).sd{:}];
    fM2.se(i,:) = RM2(i).se(:);
    fM2.st(i,:) = RM2(i).st;
    fM2.xfinal(i,:) = [RM2(i).xfinal{:}];
end

rst.fM2 = fM2;
clear b FM2

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
        [~,~,RN{i,j}] = f_sim_score(parameter_array(i,:,j),stg);
    end
end

for i=1:nSamples
    for j=1:nPars
        fN.sd(i,:,j) = [RN{i,j}.sd{:}];
        fN.se(i,:,j) = RN{i,j}.se(:);
        fN.st(i,:,j) = RN{i,j}.st;
        fN.xfinal(i,:,j) = [RN{i,j}.xfinal{:}];
    end
end

rst.fN = fN;
clear c FN
end