function rst = f_calc_sensitivities(rst,stg)

rst = remove_sim_error(rst,stg);

[rst.SiQ,rst.SiTQ,rst.Si,rst.SiT] = bootstrap(rst,stg);
end

function [SiQ,SiTQ,Si,SiT]=bootstrap(rst,stg)
% calculates confidence intervals.

fM1 = rst.fM1;
fM2 = rst.fM2;
fN = rst.fN;

%Set the amount of resamples of the bootstraping
if (isempty(stg.gsabootstrapsize))
    stg.gsabootstrapsize=ceil(sqrt(size(fM1.sd)));
end%if

scores_list = ["sd","se","st","xfinal"];

for j=1:stg.gsabootstrapsize
    rng(j*stg.rseed)
    I(j,:)=ceil(rand(size(fM1.sd,1),1)*size(fM1.sd,1));
end

for n = 1:size(scores_list,2)
    eval("fM1h=fM1." + scores_list(n) + ";");
    eval("fM2h=fM2." + scores_list(n) + ";");
    eval("fNh=fN." + scores_list(n) + ";");

    %Get the values of Si and SiT without bootstraping
    [Sih,SiTh] = calcSobolSaltelli(fM1h,fM2h,fNh,stg);

    eval("Si." + scores_list(n) + "=Sih;");
    eval("SiT." + scores_list(n) + "=SiTh;");

    %needed so the parallel workers can see these variables
    fM1h = fM1h;
    fM2h = fM2h;
    fNh = fNh;

    parfor j=1:stg.gsabootstrapsize
        [SiQh{j},SiTQh{j}] = bootstrap_q(fM1h,fM2h,fNh,stg,j,I);
    end%parfor

    for j=1:stg.gsabootstrapsize
        eval("SiQ." + scores_list(n) + "(j,:,:) = SiQh{j};")
        eval("SiTQ." + scores_list(n) + "(j,:,:) = SiTQh{j};")
    end
end
end%function

function [Si,SiT] = bootstrap_q(fM1,fM2,fN,stg,j,I)
    fM1q = fM1(I(j,:),:);
    fM2q = fM2(I(j,:),:);
    fNq = fN(I(j,:),:,:);
    [Si,SiT] = calcSobolSaltelli(fM1q,fM2q,fNq,stg);
end

function [Si,SiT] = calcSobolSaltelli(fM1,fM2,fN,stg)
%Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J.
%comp. neuroscience 27.3 (2009): 471.)

[Nsamples,Nvars,Npars]=size(fN);

if(stg.sasubmean) % Makes the model more stable
    fM1 = fM1 - mean(fM1,1);
    fM2 = fM2 - mean(fM2,1);
    for i=1:Npars
        fN(:,:,i) =  fN(:,:,i) - mean(fN(:,:,i),1);
    end
end

EY2 = mean(fM1.*fM2); % Valid definition (see Halnes et. al. Appendix)
VY = sum(fM1.^2)/(Nsamples-1) - EY2;
VYT = sum(fM2.^2)/(Nsamples-1) - EY2;

Si = zeros(Nvars,Npars);
SiT= zeros(Nvars,Npars);

for i=1:Npars
    Si(:,i) = (sum(fM1.*fN(:,:,i))/(Nsamples-1) - EY2)./VY;
    SiT(:,i) = 1 - (sum(fM2.*fN(:,:,i))/(Nsamples-1) - EY2)./VYT;
end
end

function rst = remove_sim_error(rst,stg)
error=[];
error_helper=[];

for n = 1:size(rst.fM1.sd,1)
    if max(rst.fM1.sd(n,:)) == stg.errorscore
        error = [error,n];
    end
    if max(rst.fM2.sd(n,:)) == stg.errorscore
        error = [error,n];
    end
    for m = 1:stg.parnum
        if max(rst.fN.sd(n,:,m)) == stg.errorscore
            error_helper = 1;
        end
    end
    if error_helper == 1
        error = [error,n];
    end
    error_helper = 0;
end

error = unique(error);

if ~isempty(error)
    for n = size(error,2):-1:1
        rst.fM1.sd(error(n),:) = [];
        rst.fM2.sd(error(n),:) = [];
        rst.fN.sd(error(n),:,:) = [];
        
        rst.fM1.se(error(n),:) = [];
        rst.fM2.se(error(n),:) = [];
        rst.fN.se(error(n),:,:) = [];
        
        rst.fM1.st(error(n),:) = [];
        rst.fM2.st(error(n),:) = [];
        rst.fN.st(error(n),:,:) = [];
        
        rst.fM1.xfinal(error(n),:) = [];
        rst.fM2.xfinal(error(n),:) = [];
        rst.fN.xfinal(error(n),:,:) = [];
    end
end
end