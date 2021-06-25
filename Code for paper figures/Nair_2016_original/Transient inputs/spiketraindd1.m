function neutrm = spiketraindd1(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,scale,regorand)
% -------------------------------------------------------------------------
%                 spiketraindd1(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,scale,regorand)
% -------------------------------------------------------------------------
     
                      t = t*1000;                       % Converting to milliseconds     
     
%% Declaring global variables     
global tlength1 t01 stat1 ntr1
neutrm = bsamp;
%% For time 0: Declare and initialize global variables
%     stat1: The state of the fire. 0 no spike, 1 spike.
%  tlength1: The spike duration set one it just begins or the time length to the next spike set just after the previous is finished.
%       t01: Event time. The time from the start to the last spike. If the present time minus t01 is less than the interspike time, no spike is generated.
%      ntr1: The number of fired spikes.
if t == 0 
                  stat1 = 0;
               tlength1 = 0;                            % 1000*trainlgth;   %lambda;%                
                    t01 = tstart*1000;
                   ntr1 = 0;
                 neutrm = bsamp;
%% For time > 0.                    
else
     if t <= tstart*1000;                                % Set to basal if it is too early for the first spike        
                 neutrm = bsamp;
    else
        if ntr1 <= ntrains;
                    dt0 = t-t01;
            if(dt0 > tlength1)
                  stat1 = abs(stat1-1);
                    t01 = t;
                if stat1                                % Begin new spike
               tlength1 = 1000*trainlgth;         
                   ntr1 = ntr1 + 1;  
                else                                    % Begin new interval
                    if regorand
               tlength1 = 1000*lambda;                       
                    else
               tlength1 = 1000*exprnd(lambda)+100;
                    end
                end
                 neutrm = bsamp; 
            elseif dt0 > 0
                if stat1                  
                 neutrm = scale*ddpeak(dt0/1000,bsamp,mxamp,k1,k2); 
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