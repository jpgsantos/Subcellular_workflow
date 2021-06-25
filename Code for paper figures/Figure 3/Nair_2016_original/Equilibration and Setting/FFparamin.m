function FFparamin(obj,parm,prsp)
% -------------------------------------------------------------------------
%        FFparamin(obj,parm,prsp)
% -------------------------------------------------------------------------
% 'FFparamin' is an early function in the fitting flow of signaling models
% to phenotypic data. It wraps the substitution of model parameters for
% each new round of simulations. The arguments are,
%       parm: A structure for model parameters with two fields
%              parm.names, a cell array with parameters names
%              parm.values, a vector with parameter values
%       prsp: A structure for model parameters which are declared as 
%             species in the model. It has two fields,
%              prsp.names, a cell array with parameters names
%              prsp.values, a vector with parameter values


if ~isempty(parm)
    if length(parm.names) == length(parm.values)
        for i = 1:length(parm.names)
        pobj = sbioselect(obj,'Name', parm.names{i});
            set(pobj,'Value',parm.values(i))
        end   
    else
['The number of parameters names (',num2str(length(parm.names)),') and parameter values (',num2str(length(parinput)),') don''t match']       
    end
end

if ~isempty(prsp)
    if length(prsp.names) == length(prsp.values)
        for i = 1:length(prsp.names)
        sobj = sbioselect(obj,'Name', prsp.names{i});
            set(sobj,'InitialAmount',prsp.values(i))
        end   
    else
['The number of parameters names (',num2str(length(prsp.names)),') and parameter values (',num2str(length(prsp.values)),') don''t match']       
    end
end

end