function thisAmp = spike(timePoint, basalAmp, jumpAmp, risingOffset, k1, k2)
% Script provided by Anu G. Nair to reproduce the calcium spike present in
% his 2016 paper (https://doi.org/10.1371/journal.pcbi.1005080)
    
    tForMax = log(k1/k2)/(k1-k2);
    maxAmpForThisRate = (exp(-k1*tForMax) - exp(-k2*tForMax));
    
    if timePoint <= tForMax
        thisAmp = basalAmp + risingOffset + (jumpAmp / maxAmpForThisRate) ...
                    * (exp(-k1 * timePoint) - exp(-k2 * timePoint));
    else
        thisAmp = basalAmp + ((jumpAmp + risingOffset) / maxAmpForThisRate) ...
                    * (exp(-k1 * timePoint) - exp(-k2 * timePoint));
    end
end