function rst = f_make_output_sample(rst,stg,mmf)
% Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J.
% comp. neuroscience 27.3 (2009): 471.)

nSamples = stg.sansamples;
nPars = stg.parnum;
parameter_array = zeros(nSamples,nPars);
progress = 1;
time_begin = datetime;
D = parallel.pool.DataQueue;

afterEach(D, @progress_track);

for i=1:nSamples
    parameter_array(i,:) = rst.M1(i,:);
end

parfor i=1:nSamples
    [~,~,RM1(i)] = f_sim_score(parameter_array(i,:),stg,mmf);
    send(D, "GSA M1 ");
end
disp("GSA M1 Runtime: " + string(datetime - time_begin) +...
                "  All " + nSamples + " samples executed")

% [RM1(i).sd{:}]
% RM1(i).sdtest(:,:)
% reshape(RM1(i).sd(:,:),1,[])

for i=1:nSamples
    fM1.sd(i,:) = reshape(RM1(i).sd(:,:),1,[]);
    fM1.se(i,:) = RM1(i).se(:);
    fM1.st(i,:) = RM1(i).st;
    fM1.xfinal(i,:) = [RM1(i).xfinal{:}];
end

rst.fM1 = fM1;
clear a FM1

for  i=1:nSamples
    parameter_array(i,:)= rst.M2(i,:);
end

progress = 1;
parfor i=1:nSamples
    [~,~,RM2(i)] = f_sim_score(parameter_array(i,:),stg,mmf);
    send(D, "GSA M2 ");
end
disp("GSA M2 Runtime: " + string(datetime - time_begin) +...
                "  All " + nSamples + " samples executed")

for i=1:nSamples
    fM2.sd(i,:) = reshape(RM2(i).sd(:,:),1,[]);
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

progress = 1;
parfor i=1:nSamples
    for j=1:nPars
        [~,~,RN{i,j}] = f_sim_score(parameter_array(i,:,j),stg,mmf);
    end
    send(D, "GSA N  ");
end
disp("GSA N  Runtime: " + string(datetime - time_begin) +...
                "  All " + nSamples + " samples executed")

for i=1:nSamples
    for j=1:nPars
        fN.sd(i,:,j) = reshape(RN{i,j}.sd(:,:),1,[]);
        fN.se(i,:,j) = RN{i,j}.se(:);
        fN.st(i,:,j) = RN{i,j}.st;
        fN.xfinal(i,:,j) = [RN{i,j}.xfinal{:}];
    end
end

rst.fN = fN;
clear c FN

    function progress_track(name)
        progress = progress + 1;
        if mod(progress,ceil(nSamples/10)) == 0 && progress ~= nSamples
            disp(name + "Runtime: " + string(datetime - time_begin) +...
                "  Samples:" + progress + "/" + nSamples)
        end
    end
end