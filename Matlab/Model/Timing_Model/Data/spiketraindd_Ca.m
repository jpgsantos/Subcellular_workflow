function thisAmp = spiketraindd11(t, tStart, frequency, maxSpikeNum, ...
                            basalAmp, maxAmp, k1, k2, spikelengthLowerThresh, spikeAmpMaxThresh, burstFrequency, maxBurstNum, burstMinInter, regorand)
                       

    t = t * 1000;
    cv = 0.1;
    persistent thisHistory;
                  %(1) maxAmp for the current spike
                  %(2) k1 for the current spike
                  %(3) k2 for the current spike
                  %(4) previousAmp: value of amplitude returned by the
                  %function in last call of the function.
                  %(5) spikeStartTime. start time of the latest spike
                  %(6) spikeCounter. Number of spike till now.
                  %(7) trainNotStarted: 1 if the spike train didnot begin
                  %(8) nextSpikeStartTime: calculated start time of the next spike
                  %(9) thisSpikeStartLevel: the starting amplitude for the
                  %current spike
                  %(10) nextBurstStartTime: calculated start time for the
                  %next burst. This is calculated while discharging the the
                  %last spike in the current burst
                  %(11) burstCounter: Number of bursts till now.
                  %(12) isBurstStarted: 1 if started otherwise 0
    
    thisAmp = basalAmp;
    
    if t == 0
        thisHistory(1) = maxAmp;
        thisHistory(2) = k1;
        thisHistory(3) = k2;
        thisHistory(4) = basalAmp;
        thisHistory(5) = tStart * 1000;
        thisHistory(6) = 0;
        thisHistory(7) = 1;
        thisHistory(8) = 0;
        thisHistory(9) = basalAmp;
        thisHistory(10) = tStart * 1000;
        thisHistory(11) = 0;
        thisHistory(12) = 0;
    else
        if t >= tStart * 1000
            dt = t - thisHistory(5);
            if t >= thisHistory(10) && thisHistory(11) <= maxBurstNum 
                
                if ~thisHistory(12)
                    thisHistory(12) = 1;
                    thisHistory(5) = thisHistory(10);
                    thisHistory(6) = 0;
                    thisHistory(4) = basalAmp;
                    thisHistory(9) = basalAmp;
                    thisHistory(11) = thisHistory(11) + 1;
                end
                
                if thisHistory(7) || ((t > thisHistory(8)) && (dt > spikelengthLowerThresh * 1000) && ...
                        (thisHistory(6) < maxSpikeNum))

                    thisHistory(7) = 0;
                    thisHistory(5) = t;
                    dt = t - thisHistory(5);

                    if regorand
                        thisHistory(1) = maxAmp;
                        thisHistory(2) = k1;
                        thisHistory(3) = k2;
                        thisHistory(8) = thisHistory(5) + (1000 / frequency);
                    else
                        thisHistory(1) = normrnd(maxAmp,cv*maxAmp);
                        thisHistory(2) = normrnd(k1,cv*k1);
                        thisHistory(3) = normrnd(k2,cv*k2);
                        thisHistory(8) = thisHistory(5) + exprnd(1000 / frequency);
                    end

                    thisHistory(9) = thisHistory(4);
                    thisHistory(6) = thisHistory(6) + 1;
                    
                    risingOffset = thisHistory(4) - basalAmp;
                else
                    risingOffset = thisHistory(9) - basalAmp;
                end
                
                if (thisHistory(6) == maxSpikeNum) && (dt > burstMinInter * 1000)
                    if regorand
                        thisHistory(10) = thisHistory(10) + (1000 / burstFrequency);
                    else
                        thisHistory(10) = thisHistory(10) + exprnd(1000 / burstFrequency);
                    end
                    thisHistory(12) = 0;
                end
                
                jumpAmp = thisHistory(1) - basalAmp;
                if ~isempty(spikeAmpMaxThresh) && (spikeAmpMaxThresh > basalAmp)
                    jumpAmp = spikeAmpMaxThresh - risingOffset;
                end
                thisAmp = spike(dt / 1000, basalAmp, jumpAmp, risingOffset, k1, k2);
                if(thisAmp < basalAmp)
                    thisAmp = basalAmp;
                end
                thisHistory(4) = thisAmp;
            end
        end
    end
end