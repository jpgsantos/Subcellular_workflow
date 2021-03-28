function [LawText]=get_thermodynamic_constraints(N,varargin)
%% Andrei Kramer <andreikr@kth.se>
%%
%% Usage: get_thermodynamic_constraints(N,['key',value,...])
%%
%% Arguments
%%
%%        N: stoichiometric matrix of reaction network with
%%           mass action kinetics
%%
%% Optional Arguments
%%     either key/value pairs
%%         or a single scalar struct with keys as fieldnames
%%
%%  Keys
%% names: cell array of strings. Contains the names of the
%%        equilibrium parameters; one for each reaction (Ka)
%% style: either plain, c, octave, or latex (a string value)
%%
%% transform: logical, controls whether the output should be adjusted a bit.
%%
%% fractions: the names are fractions of 'kf's and 'kr's.
%%
%% Result: this function just assumes that all reactions in N
%%         are reversible and of type Mass Action. So, each
%%         reaction is assumed to have a forward kinetic rate
%%         coefficient k_f and a backward reaction rate
%%         coefficiant k_r (sometimes also named k_b).
%%         These define a dissociation constant Kd=k_r/k_f and Ka (k_f/k_r).
%%         The script then finds relationships between all Ka(i)
%%         and prints them on screen. By default, it uses the name
%%         Ka(i) for the equilibrium constant of the reaction
%%         decribed by column i of the stoichiometry N.
%%
%% implementation of algorithm described in
%%  [1] Vlad, Marcel O., and John Ross. 'Thermodynamically based constraints for rate coefficients of large biochemical networks.'
%%   Wiley Interdisciplinary Reviews: Systems Biology and Medicine 1.3 (2009): 348-358.

[n,R]=size(N); % number of state variables and Reactions
k=rank(N);
opt=parse_varargin(varargin);

if isfield(opt,'names')
    knames=opt.names;
    assert(R==length(knames));
else
    knames=make_new_names(R,opt);
end%if
%% reorder stoichiometry, put linearly independent vectors upfront
%% using the rank function.
l=false(1,R);
A=[];
for i=1:R
    B=cat(2,A,N(:,i));
    if rank(B)==min(size(B))
        A=B;
        l(i)=true;
    end%if
end%for
j_K=find(l);
j_Z=find(not(l));
%% continue reordering with row vectors
r=false(n,1);
C=[];
for i=1:n
    B=cat(1,C,A(i,:));
    if rank(B)==min(size(B))
        C=B;
        r(i)=true;
    end%if
end%for

i_K=find(r,k);
fr=find(r');
lfr=length(fr);
i_Y=cat(2,fr(k+1:lfr),find(not(r')));
%% split the matrix N so that GKK is square and has full rank.
GKK=N(i_K,j_K); % [1] eq. (13)
GKZ=N(i_K,j_Z);
GYK=N(i_Y,j_K);
GYZ=N(i_Y,j_Z);

T=GKK\GKZ;
display(size(T))
%% the assumption is that if a reaction i does not have a simple kf
%% and kb, then the K of that reaction K(i) does not exist in that
%% simple form. Then K(i) may not participate in any relation
%% printed below, those lines should be discarded.
fprintf('Ka(i)=kf(i)/kr(i)\n'); % [1] eq. (4)
fprintf('Kd(i)=kr(i)/kf(i) [etc.]\n');
fprintf('untransformed result: \n');
%% the following block is an interpretation of [1] eq. (45)
L=length(j_Z);
LawText=cell(L,1);
fmt=get_fmt(opt.style);
for i=1:L
    a=j_Z(i);
    S=sprintf('%s=',knames{a});
    sep='';
    for j=1:k
        b=j_K(j);
        t=T(j,i);
        if abs(t)>1e-7 % so, not 0
            if (t==1)
                Term=knames{b};
            else
                Term=sprintf(fmt,knames{b},t); %knames{b},merge(not(t==1),Et,''))
            end%if
            S=strcat(S,sprintf('%s%s',sep,Term));
            sep='*';
        end%if
    end%for
    S=strcat(S,sprintf(';\n'));
    fprintf(S);
    LawText{i}=S;
end%for
if isfield(opt,'transform') && opt.transform
    fprintf('The return value will be transformed bu regular expression substitution. Please check the result. This will not work in every case, it highly depends on the chosen parameter names.\n');
    LawText=transform(LawText,opt);
end%if
end%function

function [opt]=parse_varargin(ArgCell)
N=length(ArgCell);
opt.transform=false;
opt.fractions=false;
opt.style='plain';
if ~isempty(ArgCell) && iscell(ArgCell)
    if ischar(ArgCell{1}) && mod(length(ArgCell),2)==0
        %% we have a key/value pair kind of argument list
        % make an opt struct
        for i=1:2:N
            switch (ArgCell{i})
                case 'transform'
                    opt.transform=logical(ArgCell{i+1});
                case 'fractions'
                    opt.fractions=logical(ArgCell{i+1});
                case 'style'
                    assert(ischar(value==ArgCell{i+1}));
                    opt.style=normalise_style(value);
                case {'names','Names','name','Name'}
                    assert(iscellstr(ArgCell{i+1}));
                    opt.names=ArgCell{i+1};
            end%switch
        end%for
    elseif isstruct(ArgCell{1})
        o=ArgCell{1};
        if isfield(o,'transform')
            opt.transform=logical(o.transform);
        end%if
        if isfield(o,'fractions')
            opt.fractions=logical(o.fractions);
        end%if
        if isfield(o,'style')
            value=o.style;
            opt.style=normalise_style(o.style);
        end%if
        if isfield(o,'names')
            assert(iscellstr(o.names));
            opt.names=o.names;
        end%if
    else
        error('optional argument list not understood.');
    end%if
end%if
end%function

function [knames]=make_new_names(R,opt)
if isfield(opt,'fractions') && opt.fractions
    switch (opt.style)
        case 'c'
            fmt='(kf[%i]/kr[%i])';
        case 'latex'
            fmt='\frac{k_{\text{f},%i}}{k_{\text{r},%i}}';
        case 'octave'
            fmt='(kf(%i)/kr(%i))';
        case 'plain'
            fmt='(kf%i/kr%i)'
    end%switch
    for i=1:R
        knames{i}=sprintf(fmt,i,i);
    end%for
else
    switch (opt.style)
        case 'c'
            fmt='Ka[%i]';
        case 'latex'
            fmt='K_{\\text{a},%i}';
        case 'octave'
            fmt='Ka(%i)';
        case 'plain'
            fmt='Ka%i'
    end%switch
    for i=1:R
        knames{i}=sprintf(fmt,i-1);
    end%for
end%if
end%function

function [style]=normalise_style(value)
switch(value)
    case {'LaTeX','latex','tex'}
        style='latex';
    case {'C','c','c++'}
        style='c';
    case {'matlab','octave','GNU Octave'}
        style='octave';
    otherwise
        style='plain';
end%switch
end%function

function fmt=get_fmt(style)
switch (style)
    case 'c'
        fmt='pow(%s,%i)';
    case 'octave'
        fmt='%s^(%i)';
    case 'latex'
        fmt='%s^{%i}';
    case 'gnuplot'
        fmt='%s**(%i)'
    otherwise
        fmt='%s^(%i)';
end%switch
end%function

function [LawText]=transform(LawText,opt)
L=length(LawText);
for i=1:L
    S=LawText{i};
    if isfield(opt,'fractions') && opt.fractions
        S=regexprep(S,'\((\w+([([]?\d*[])]?))/(\w+([([]?\d*[])]?))\)\s*=\s*(.*);','$1=($5)*($3)');
        S=regexprep(S,'\((\w+([([]?\d*[])]?))/(\w+([([]?\d*[])]?))\)\^[{(]-1[})]','($3/$1)'); % in case of normal parnetheses
        S=regexprep(S,'\((\w+([([]?\d*[])]?))/(\w+([([]?\d*[])]?))\)\^[{(]-(\d+)[})]','($3/$1)^($5)'); % in case of normal parnetheses
        if isfield(opt,'style') && strcmp(opt.style,'c')
            S=regexprep(S,'pow\(\((\w+([([]?\d*[])]?))/(\w+([([]?\d*[])]?))\),-1\)','($3/$1)');
            S=regexprep(S,'pow\(\((\w+([([]?\d*[])]?))/(\w+([([]?\d*[])]?))\),-(\d+)\)','pow($3/$1,$5)');
        end%if
    else
        S=regexprep(S,'Ka([[(]?\d*[])]?)\^[({]-1[)}]','Kd$1');
        if isfield(opt,'style') && strcmp(opt.style,'c')
            S=regexprep(S,'pow\(Ka\[(\d+)\],-1\)','Kd[$1]');
            S=regexprep(S,'pow\(Ka\[(\d+)\],-(\d+)\)','pow(Kd[$1],$2)');
        end%if
    end%if
    LawText{i}=S;
end%for
end%function
