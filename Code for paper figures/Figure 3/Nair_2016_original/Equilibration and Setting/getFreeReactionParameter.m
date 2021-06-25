function freeParams = getFreeReactionParameter(obj)
    parObjects = obj.Parameters;
    allParNames = {};
    for i = 1:length(parObjects)
        if strncmpi(parObjects(i).Name,'k',1)
            allParNames{end+1} = parObjects(i).Name;
        end
    end
    ruleObjects = obj.Rules;
    constrainedParams = {};
    delimiter = '=';
    for i = 1:length(ruleObjects)
        if strcmp(ruleObjects(i).RuleType,'initialAssignment')
            thisRule = ruleObjects(i).Rule;
            thisRuleparam = regexp(thisRule,delimiter,'split');
            thisRuleparam = thisRuleparam{1};
            thisRuleparam = strrep(thisRuleparam, ' ', '');
            thisRuleparam = strrep(thisRuleparam, '[', '');
            thisRuleparam = strrep(thisRuleparam, ']', '');
            constrainedParams{end+1} = thisRuleparam;
        end
    end
    toBeRemoved = ismember(allParNames,constrainedParams);
    freeParams = {};
    for i = 1:length(toBeRemoved)
        if ~toBeRemoved(i)
            freeParams{end+1} = allParNames{i};
        end
    end
end