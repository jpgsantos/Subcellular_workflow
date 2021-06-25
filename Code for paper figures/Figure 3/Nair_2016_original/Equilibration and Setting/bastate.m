function bastate(obj,spec)
% -------------------------------------------------------------------------
% bastate(obj,spec)
% -------------------------------------------------------------------------
% 'bastate' brings the model to the basal state after most of the perturbations programed in this script
%

    act = checkrules(obj,[],0);                       % Detect rules running transient inputs
    checkrules(obj,act,0);                            % Disable rules running transient inputs

    for i = 1:length(obj.variants)
        variants{i} = obj.variants(i).name;
    end

    varv = zeros(1,length(variants));

    [totam vobj robj cmpn miss] = FFmodobj(obj,{},variants,{},{},'bastate',0);

    for i = 1:length(variants)
        if ~isempty(vobj{i})
            vobj{i}.active = varv(i);
        end
    end

    if ~isempty(spec)
        setotalX(obj,spec)
        relaxsys(obj,[],0);                            % Relax the system
    else
        relaxsys(obj,[],1);                            % Relax the system
    end

    logsp(obj,1,[1,2,6,10,12,13],{});                          % Log just a handful of relevant species.
end