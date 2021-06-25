function actrepinga = checkrules(obj,act,stat)
% -------------------------------------------------------------------------
%        actres = checkrules(obj,act,stat)
% -------------------------------------------------------------------------
% 'checkrules' find the active rules of the type 'dopadrug', 'diptrain' and 
% 'spiketrain' in the model "obj" and depending on the user defined argument 
% "act",
% -  []: Identify the rules
% - ~[]: for the rules previously identified, it turns them on if stat = 1,
%           or off if stat = 0;
% This is used by 'relaxsys' to avoid equilibrations with rules that slow
% down the process. Besides, the model in the basal state has all these
% ruled turn off (e.g. FFbastate).

          ct = 0;
     actrepinga = [];
        nrul = length(obj.rules);
    for i = 1:nrul
        if isempty(act)
        actT = obj.rule(i).active;
            if actT
        kin1 = regexp(obj.rule(i).Rule,'dopadrugs','once');
        kin2 = regexp(obj.rule(i).Rule,'spiketrain','once');
        kin3 = regexp(obj.rule(i).Rule,'diptrain','once');
        kin4 = regexp(obj.rule(i).Rule,'stepinp','once');
                if (~isempty(kin1))||(~isempty(kin2))||(~isempty(kin3))||(~isempty(kin4))
          ct = ct + 1;
  actrepinga(ct) = i; 
                end
            end
        else       
            for i = 1:length(act) 
        actT = act(i);
    obj.rule(actT).active = stat;
            end
        end
    end
end