function rst = f_calcSobolSaltelli(rst,stg)
%Code modified from Geir Halnes et al. (Halnes, Geir, et al. J. comp.
%neuroscience 27.3 (2009): 471.)
rst = rst.SA;

rst = remove_sim_error(rst,stg);

rst = calcSS(rst,stg,"sd");
rst = calcSS(rst,stg,"se");
rst = calcSS(rst,stg,"st");
rst = calcSS(rst,stg,"xfinal");
end

function rst = calcSS(rst,stg,test)

eval("fM1=rst.fM1." + test + ";");
eval("fM2=rst.fM2." + test + ";");
eval("fN=rst.fN." + test + ";");
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

SI = zeros(Nvars,Npars);
SIT= zeros(Nvars,Npars);

for i=1:Npars
    SI(:,i) = (sum(fM1.*fN(:,:,i))/(Nsamples-1) - EY2)./VY;
    SIT(:,i) = 1 - (sum(fM2.*fN(:,:,i))/(Nsamples-1) - EY2)./VYT;
end

eval("rst.SI." + test + "=SI;");
eval("rst.SIT." + test + "=SIT;");
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
    for m = 1:6
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