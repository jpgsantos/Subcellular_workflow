function neutrm = spiketraindd0(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,scale,regorand)
% -----------------------------------------------------------------------------------------------------
%                 spiketraindd0(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,scale,regorand)
% -----------------------------------------------------------------------------------------------------
     
                      t = t*1000;                       % Converting to milliseconds    
                 kdesen = 0.02;
                     cv = 0.1;
     
%% Declaring global variables     
global tlength0 t00 stat0 ntr0 mxampr k1r k2r
neutrm = bsamp;
%% For time 0: Declare and initialize global variables
%     stat0: The state of the fire. 0 no spike, 1 spike.
%  tlength0: The spike duration set one it just begins or the time length to the next spike set just after the previous is finished.
%       t00: Event time. The time from the start to the last spike. If the present time minus t00 is less than the interspike time, no spike is generated.
%      ntr1: The number of fired spikes.
if t == 0 
                  stat0 = 0;
               tlength0 = 0;                            % 1000*trainlgth;   %lambda;%       
                 mxampr = mxamp;
                    k1r = k1;
                    k2r = k2;
                    t00 = tstart*1000;
                   ntr0 = 0;
                 neutrm = bsamp;
%% For time > 0.                    
else
    if t <= tstart*1000;                                % Set to basal if it is too early for the first spike        
                 neutrm = bsamp;
    else
        if ntr0 <= ntrains;
                    dt0 = t-t00;
            if(dt0 > tlength0)
                  stat0 = abs(stat0-1);
                    t00 = t;
                if stat0                                % Begin new spike
               tlength0 = 1000*trainlgth;
               
                    if regorand
                 mxampr = mxamp;
                    k1r = k1;
                    k2r = k2;
                    else
                 mxampr = normrnd(mxamp,cv*mxamp);
                    k1r = normrnd(k1,cv*k1);
                    k2r = normrnd(k2,cv*k2);                        
                    end
                    
                   ntr0 = ntr0 + 1; 
                else                                    % Begin new interval
                    if regorand
               tlength0 = 1000*lambda;       
                    else
               tlength0 = 1000*exprnd(lambda)+100;
                    end
                end
                 neutrm = bsamp; 
            elseif dt0 > 0
                if stat0                    
             scaledesen = (scale-1)*exp(-kdesen*(dt0/1000)) + 1;
                 neutrm = scaledesen*ddpeak(dt0/1000,bsamp,mxampr,k1r,k2r);
                else
                 neutrm = bsamp;
                end
            elseif dt0 < 0
                 neutrm = bsamp;
            end                                    
        else        
                 neutrm = bsamp;
        end
    end                
end

end