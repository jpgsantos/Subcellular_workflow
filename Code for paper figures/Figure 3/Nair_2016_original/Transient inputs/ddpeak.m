function da = ddpeak(tvect,bsamp,mxamp,k1,k2)
% -------------------------------------------------------------------------
%             ddpeak(tvect,bsamp,mxamp,k1,k2)
% -------------------------------------------------------------------------
% 'ddpeak' computes a sum of exponentials describing the 
% pharmacodynamics of an species in a compartment with a source and a sink. 
% It was taken from measurements of cocaine and dopamine in the rat striatum 
% upon i.p. administration of cocaine and is used to simulate the dopamine 
% high resulting from single administration of dopaminemimetic drugs. It has 
% three parameters, the amplitude, the rate constant for the rise and the 
% rise constant for the decay.
% The arguments of the function are,
% -   bsamp: The basal level.
% -   mxamp: The amplitude of the pulse.
% -      k1: The rate constant for the ascending exponential. In minutes.
% -      k2: The rate constant for the descending exponential. In minutes.
% The time is converted to minutes to match the units of the rate constant.

% K = k1/(k2-k1);

   tx = log(k1/k2)/(k1-k2);
    K = (exp(-k1*tx) - exp(-k2*tx));
    K = 1/K;
mxamp = mxamp - bsamp;
   da = bsamp + mxamp*K*(exp(-k1*(tvect)/60)-exp(-k2*(tvect)/60));

end