function thisAmp = spiketraindd10(t, tStart, frequency, maxSpikeNum, ...
                            basalAmp, maxAmp, k1, k2, spikelengthLowerThresh, spikeAmpMaxThresh, regorand)
                        
                        %spiketraindd10(time,0,frequency,10,60,700,39.4,9.3,0.05,1)
   
    t = t * 1000;
    cv = 0.1;
    persistent thisHistory;
    %thisHistory = [0, 0, 0, 0, 0, 0, 0, 0, 0];
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
    
    thisAmp = basalAmp;
    
    if t == 0
        thisHistory(1) = maxAmp;
        thisHistory(2) = k1;
        thisHistory(3) = k2;
        thisHistory(4) = basalAmp;
        thisHistory(5) = 0;
        thisHistory(6) = 0;
        thisHistory(7) = 1;
        thisHistory(8) = 0;
        thisHistory(9) = basalAmp;
    else
        if t >= tStart * 1000
            
            dt = t - thisHistory(5);
            if ((t >= thisHistory(8)) && (dt > spikelengthLowerThresh * 1000) && ...
                    (thisHistory(6) < maxSpikeNum)) || thisHistory(7)
                
                thisHistory(7) = 0;
                thisHistory(5) = t;
                dt = t - thisHistory(5);
                %calculate the nextSpikeStartTime and set.
                
                if regorand
                    thisHistory(1) = maxAmp;
                    thisHistory(2) = k1;
                    thisHistory(3) = k2;
                    thisHistory(8) = thisHistory(5) + (1000 / frequency);
                else
                    thisHistory(1) = normrnd(mxamp,cv*mxamp);
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