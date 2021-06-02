function rst = f_calcSensitivities(rst,stg)

rst = remove_sim_error(rst,stg);

[rst.SiQ,rst.SiTQ,rst.Si,rst.SiT] = bootstrap(rst,stg.SAbootstrapsize,stg);
end

function [SiQ,SiTQ,Si,SiT]=bootstrap(rst,m,stg)
% calculates confidence intervals.
fM1 = rst.fM1;
fM2 = rst.fM2;
fN = rst.fN;

scores_names_list = ["sd","se","st","xfinal"];

[Si,SiT] = bootstrap_h(fM1,fM2,fN,stg,scores_names_list);

if (isempty(m))
    m=ceil(sqrt(size(fM1.sd)));
end%if

fM1q = cell(m,1);
fM2q = cell(m,1);
fNq = cell(m,1);

parfor j=1:m
    [SiQh{j},SiTQh{j}] = bootstrap_hq(fM1,fM2,fN,stg,scores_names_list,j);
end%parfor

for n = 1:size(scores_names_list,2)
    for j=1:m
        eval("SiQ." + scores_names_list(n) + "(j,:,:) = SiQh{j}." + scores_names_list(n) + ";")
        eval("SiTQ." + scores_names_list(n) + "(j,:,:) = SiTQh{j}." + scores_names_list(n) + ";")
    end
end

end%function


function [Si,SiT] = bootstrap_h(fM1,fM2,fN,stg,scores_names)

for n = 1:size(scores_names,2)
    eval("fM1h=fM1." + scores_names(n) + ";");
    eval("fM2h=fM2." + scores_names(n) + ";");
    eval("fNh=fN." + scores_names(n) + ";");
    
    [Sih,SiTh] = calcSobolSaltelli(fM1h,fM2h,fNh,stg);
    
    eval("Si." + scores_names(n) + "=Sih;");
    eval("SiT." + scores_names(n) + "=SiTh;");
end
end

function [Si,SiT] = bootstrap_hq(fM1,fM2,fN,stg,scores_names,j)
for n = 1:size(scores_names,2)
    eval("fM1h=fM1." + scores_names(n) + ";");
    eval("fM2h=fM2." + scores_names(n) + ";");
    eval("fNh=fN." + scores_names(n) + ";");
    
    rng(j*stg.rseed)
    I=ceil(rand(size(fM1h,1),1)*size(fM1h,1));
    fM1q = fM1h(I,:);
    fM2q = fM2h(I,:);
    fNq = fNh(I,:,:);
    
    [Sih,SiTh] = calcSobolSaltelli(fM1q,fM2q,fNq,stg);
    eval("Si." + scores_names(n) + "=Sih;");
    eval("SiT." + scores_names(n) + "=SiTh;");
end
end

function [Si,SiT] = calcSobolSaltelli(fM1,fM2,fN,stg)
%Code inspired by Geir Halnes et al. 2009 paper. (Halnes, Geir, et al. J. comp. neuroscience 27.3 (2009): 471.)

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