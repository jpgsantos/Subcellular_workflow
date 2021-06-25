function output = runCaDACombination(obj, daStart, caStart, burstNum, burstFreq, daAmp, runTime, tstep, spec, effectors, variantsToKeep)

% This function runs the simulations for Ca and DA inputs with specified 
% signal start time.
% The input to the function are the following:
%   1. obj: simbiology model obj
%   2. daStart: t start for DA input. No input signal if empty.
%   3. caStart: t start for Ca input. No input signal if empty.
%   4. tstep: This is the timestep used in the simulation.
%   5. spec: This is the spec structure to set the total amount of a
%       species to value other than specified in "Total Amount" variant.
%   6. The cell array of effectors which should be logged. 
%   7. The cell array of variants which should be on.
% The output of the function is a structure with following fields:
%   1. Time: This is the timepoints for which the simulation ouput is
%       logged.
%   2. Data: This is a cell array of one elements which contains a mxn 
%       matrix where m is the number of effector and n is
%       the number of timepoints for output logging. Each row in the matrix
%       represents the concentration of the effector for the timepoint. The
%       order of the effectors is same as the order in 'effectors'.


    bastate(obj,spec);
    
    variants = {};
    % Adding additional variant to the existing ones
    if ~isempty(variantsToKeep)
        for i = 1:length(variantsToKeep)
            variants{end + 1} = variantsToKeep{i};
        end
    end
    
    rules = {'0 DA spike';...
             '0 Ca spikes with 3 AP'};
    
    rstate = [1 1];
    if isempty(daStart) 
        rstate(1) = 0;
    end
    if isempty(caStart) 
        rstate(2) = 0;
    end
    
    compartments = {'Neuron'};
    logTimePoints = 0:0.01:runTime;
    output.Time = logTimePoints;
    
    [totam vobj robj cmpn miss] = FFmodobj(obj,[],variants,rules,compartments,'',0);
    
    % Setting up the input parameter values
    parnamDA = {'nDA_peakfirst', 'nDA_burstn', 'nDA_burstfreq', 'nDA_ampmax'};
    parvalDA = [        daStart,     burstNum,       burstFreq,        daAmp];
    paroriginalvalDA = zeros(1,length(parnamDA));
    
    if ~isempty(daStart)
        for i = 1:length(parnamDA)
            pobj = sbioselect(obj,'Name', parnamDA{i});
            paroriginalvalDA(i) = pobj.Value;
            set(pobj,'Value',parvalDA(i));
        end
    end
    
    parnamCa = {'nCa_peakfirst', 'nCa_burstn', 'nCa_burstfreq'};
    parvalCa = [        caStart,     burstNum,       burstFreq];
    paroriginalvalCa = zeros(1,length(parnamCa));
    
    if ~isempty(caStart)
        for i = 1:length(parnamCa)
            pobj = sbioselect(obj,'Name', parnamCa{i});
            paroriginalvalCa(i) = pobj.Value;
            set(pobj,'Value',parvalCa(i));
        end
    end
    
    % Switching on the variants provided by user and equilibriating the
    % system
    if ~isempty(variants)
        for i = 1:length(variants)
            vobj{i}.active = 1;
        end
    end
    relaxsys(obj,[],0);
    
    % Running simulation with transient inputs
    robj{1}.active = rstate(1);
    robj{2}.active = rstate(2);
    [t,x,names, data] = confANDrun(obj,runTime,tstep,logTimePoints,'ode15s');
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},names(:),'exact');
        if ~isempty(varit)
            res(k,:) = x(:,varit)';
        end
    end
    output.Data{1} = res;
    
    
    % Reverting to the initial state of the model
    for i = 1:length(parnamDA)
        pobj = sbioselect(obj,'Name', parnamDA{i});
        set(pobj,'Value',paroriginalvalDA(i));
    end
    for i = 1:length(parnamCa)
        pobj = sbioselect(obj,'Name', parnamCa{i});
        set(pobj,'Value',paroriginalvalCa(i));
    end
    
    bastate(obj,[]);
end