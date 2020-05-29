function rst = calcSobolSaltelli(rst,stg)
%implementation partly by Geir Halnes et al. (Halnes, Geir, et al. J. comp. neuroscience 27.3 (2009): 471.)

fM1=rst.fM1;
fM2=rst.fM2;
fN=rst.fN;
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

rst.SI = zeros(Nvars,Npars);
rst.SIT= zeros(Nvars,Npars);

for i=1:Npars
    rst.SI(:,i) = (sum(fM1.*fN(:,:,i))/(Nsamples-1) - EY2)./VY;
    rst.SIT(:,i) = 1 - (sum(fM2.*fN(:,:,i))/(Nsamples-1) - EY2)./VYT;
end
end