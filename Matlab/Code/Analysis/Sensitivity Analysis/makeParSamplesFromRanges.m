function rst=makeParSamplesFromRanges(stg)
% Code partly by Geir Halnes et al. (Halnes, Geir, et al. J. comp. neuroscience 27.3 (2009): 471.)
%
%Input from stg:
%
% stg.sansamples -> number of samples
% stg.ms.parnum -> number of parameters on wich to run SA
% stg.ub -> upper bound for all relevant parameters
% stg.lb -> lower bound for all relevant parameters
%
%Output:
% M1 and M2 matrices with (Nsamples X Npars) random numbers with
%within the ranges set for each parameter.
% N matris of size  (Nsamples X Npars x Npars) with columns exchanged
%between M1 and M2 (see publication).
%i.e. in total 2*Nsamples + Nsamples*Npars samples.
        
% MAKE SAMPLE MATRICES
M1 = zeros(stg.sansamples, stg.ms.parnum); % Pre-allocate memory for data
M2 = zeros(stg.sansamples, stg.ms.parnum);
N = zeros(stg.sansamples, stg.ms.parnum, stg.ms.parnum);
rng(stg.rseed)

for i=1:stg.ms.parnum
    if stg.sasamplemode == 0
        M1(:,i) = stg.lb(i) + (stg.ub(i)-stg.lb(i)).*rand(1,stg.sansamples);
        M2(:,i) = stg.lb(i) + (stg.ub(i)-stg.lb(i)).*rand(1,stg.sansamples);
    elseif stg.sasamplemode == 1
        pd(i) = makedist('Normal','mu',stg.bestx(i),'sigma',stg.sasamplesigma);
        t(i) = truncate(pd(i),stg.lb(i),stg.ub(i));
        r{i} = random(t(i),stg.sansamples,1);
        r2{i} = random(t(i),stg.sansamples,1);
        M1(:,i) = r{i};
        M2(:,i) = r2{i};
    end
end

for i=1:stg.ms.parnum
    % Replace the i:th column in M2 by the i:th column from M1 to obtain Ni
    N(:,:,i) = M2;
    N(:,i,i) = M1(:,i);
end

rst.M1=M1;
rst.M2=M2;
rst.N=N;