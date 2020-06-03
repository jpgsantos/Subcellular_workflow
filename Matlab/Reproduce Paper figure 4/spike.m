function thisAmp = spike(timePoint, basalAmp, jumpAmp, risingOffset, k1, k2)
    
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