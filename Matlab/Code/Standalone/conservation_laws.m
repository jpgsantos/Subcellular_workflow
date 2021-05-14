function [n,N]=conservation_laws(Model,varargin)
%% Andrei Kramer <andreikr@kth.se>
%%
%% Usage 1: N=conservation_laws(Model,['test'])
%%
%% Model.flux(x,t,p): reaction fluxes, needed for testing, with lsode (pass the optional 'test' argument)
%% Model.f(flux): function that converts fluxes to ODE right-hand-side
%% Model.x_names: names of state variables
%% Model.ns: number of state variables
%% Model.nr: number of reactions
%% Model.np: number of parameters
%%
%% returns stoichiometry matrix N
%%
%% Usage 2: conservation_laws(N,[substances],[initial conditions])
%% where
%%           N: known stoichiometry matrix
%%  substances: cell array of strings (substance names)

if not(isstruct(Model)) && isnumeric(Model)
    N=Model;
    ns=size(N,1);
    if nargin>1 && length(varargin{1})==ns
        substances=varargin{1};
    else
        s=strsplit(sprintf('x_%i,',[1:ns]),',');
        substances=s(1:ns);
    end%if
    if nargin>2
        user_x0=varargin{2};
        assert(length(user_x0)==ns);
        assert(isfinite(user_x0));
    else
        user_x0=NA(ns,1);
    end%if
elseif isstruct(Model) && isfield(Model,'f')
    
    %% get stoichiometry from fluxes
    N=get_stoichiometry(Model);
    ns=Model.ns
    substances=Model.x_names;
    if isfield(Model,'x0')
        user_x0=Model.x0;
    else
        user_x0=NA(ns,1);
    end%if
    assert(size(N,1)==Model.ns);
end%if

n=get_laws(N,substances,user_x0);
if (nargin>1 && length(varargin{1})==1 && strcmp(varargin{1},'test'))
    p=rand(Model.np,1);
    x0=rand(Model.ns,1);
    t=linspace(0,1,64);
    ode=@(x,t) Model.f(Model.flux(x,t,p));
    X=lsode(ode,x0,t);
    show_conservation(t,X,Model.x_names,n);
end%if

end%function

function n_rref=get_laws(N,substances,x0)
%% Given a cell array of substance names and stoichimetric matrix N
%% this function finds conservation laws in the reaction system
%% Usage:
%%         C=conservation_laws(N,substances)
%% C is a matrix of coefficients, the columns span the space of
%% conservation laws
%% Example: given state variables X(1:3) and C=[1;1;2],
%% then X(1) + X(2) + 2*X(3) = cons.

n=null(N');
n_rref=rref(n')';
n_r=n_rref;
count=0;
while (norm(n_r-round(n_r)) > 1e-6 && count<3)
    count = count +1;
    warning('nullspace is not represented by integers. \nTo make the mass conservation more readable, we multiply them by 10 and round.');
    n_r= n_r*10;
end%while
n_rref=round(n_r);
c=size(n_rref,2);
Y=cell(c,2);
s='+-';
for i=c:-1:1
    Y{i,1}=[sign(n_rref(:,i))>0];
    Y{i,2}=[sign(n_rref(:,i))<0];
    for j=1:2
        I=find(Y{i,j});
        for k=1:length(I)
            an_r=abs(n_rref(I(k),i));
            fprintf('%s %s%s ',merge(j==1 && k==1,'',s(j)),...
                merge(an_r>1,sprintf('%i·',an_r),''),...
                substances{I(k)});
        end%for
    end%for
    if isfinite(x0)
        C=x0'*n_rref(:,i);
        fprintf('= %f\n',C);
    else
        fprintf('= const.\n');
    end%if
end%for
fprintf('the constants can be determined from the initial conditions of the system.\n');
end%function

function N=get_stoichiometry(M)
%% Usage N=get_stoichiometry(M)
%%
%%  M: ode model structure. contains
%%     M.ns number of substances
%%     M.nr number of reactions
%%     M.f(flux) ODE right hand side function; the vector field of fluxes,
%%         the flux is a column vector which contains every reaction's flux
%%                                      (derived from the reaction kinetic)
%%         This is only needed to check which flux influences which state
%%         variable.
N=zeros(M.ns,M.nr);
r=M.nr;
for j=1:r
    N(:,j)=sign(M.f([1:r]==j));
end%for
end%function

function show_conservation(t,X,substances,n)
%%
%% Usage: show_conservation_law(X,substances,n)
%%
%%  X, lsode output, the solution of the initial value problem. Each
%%  state variable is represented by a column; the row index
%%  corresponds to the time index.
%%
%%  substances is a cell array of strings with substance names.
%%
%% n represents the conservation law, is returned by the function:
%% n=conservation_laws(N,substances)
%%
nt=length(t);
s='+-';

for i=size(n,2):-1:1
    T='';
    Y{i,1}=[sign(n(:,i))>0];
    Y{i,2}=[sign(n(:,i))<0];
    for j=1:2
        I=find(Y{i,j});
        for k=1:length(I)
            T=cat(2,T,sprintf('%s %s%s ',merge(j==1 && k==1,'',s(j)),...
                merge(abs(n(I(k),i))>1,sprintf('%i·',abs(n(I(k),i))),''),...
                substances{I(k)}));
        end%for
    end%for
    Z=X*n(:,i);
    figure(); clf;
    plot(t,Z,sprintf('-;conservation law %i;',i));
    title(T,'interpreter','none');
    xlabel('t');
    ylabel('concentration');
end%for
figure(); clf;
plot(t,X,';;');
title('model trajectories');
xlabel('t');
ylabel('X_i');
legend(substances{:},'location','southoutside');
end%function

