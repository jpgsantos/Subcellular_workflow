function neutrm = diptraindd(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,dipdep,regorand)
% -------------------------------------------------------------------------
%                 diptraindd(t,tstart,lambda,ntrains,bsamp,mxamp,k1,k2,trainlgth,regorand,dipdep)
% -------------------------------------------------------------------------

                                    t = t*1000;
                                    
if mxamp > bsamp
   mxamp = bsamp-eps; 
end
  neutrm = bsamp;

global tlengthd0 t0d0 statd0 ntrd0
%% For time 0: Declare and initialize global variables
%      statd0: The state of the fire. 0 no spike, 1 spike.
%   tlengthd0: The spike duration set one it just begins or the time length to the next spike set just after the previous is finished.
%        t0d0: Event time. The time from the start to the last spike. If the present time minus t01 is less than the interspike time, no spike is generated.
%       ntrd0: The number of fired spikes.

if t == 0 
                 statd0 = 0;
              tlengthd0 = 0;
                   t0d0 = tstart*1000;
                  ntrd0 = 0;
                 neutrm = bsamp;
else       
    if t <= tstart*1000;
                 neutrm = bsamp;
    else
        if ntrd0 <= ntrains
                    dt0 = t-t0d0;
            if(dt0 > tlengthd0)                                            % An spike or an interspike interval has just finished.
                 statd0 = abs(statd0-1);
                   t0d0 = t;
                if statd0                                                  % Begin new spike.
              tlengthd0 = 1000*trainlgth;         
                  ntrd0 = ntrd0 + 1;
                else                                                       % Begin new interval.
                    if regorand
              tlengthd0 = 1000*lambda;    
                    else
              tlengthd0 = 1000*exprnd(lambda)+100;
                    end
                end
                 neutrm = bsamp;
                 
            elseif dt0 > 0                                                 % There is an ongoing spike or interspike.
                if statd0                  
%                 neutrm = dipdep*(bsamp - ddpeak(dt0/1000,bsamp,mxamp,k1,k2)); 
                    if neutrm > bsamp
                 neutrm = bsamp;
                    end
%                     if neutrm < mxamp
%                         neutrm = mxamp;
%                     end
                    neutrm = dipdep;
                else
                 neutrm = bsamp;
                end
                
            elseif dt0 < 0                                                 % The solver moved back and left an spike or interspike interval. Basal amplitude is delivered.
                 neutrm = bsamp;
            end
        else
                 neutrm = bsamp;
        end
    end                
end

end