function thisAmp = Ca_input_fig6(times,n)
persistent CaX
persistent CaT
persistent Cah1
persistent Cah2
if isempty(CaX)
    Data = coder.load('../Subcellular_workflow/Code for paper figures/Figure 6/Nair_2016_calcium.mat','calcium','time');
    CaX = Data.calcium{n};
    CaT = Data.time{n};
    Cah1 = 1;
end
thisAmp = CaX(end);
if times ~= 30
    if times == 0
        Cah1 = 1;
        thisAmp = CaX(1);
    else
        while times > CaT(Cah1)
            Cah1 = Cah1 + 1;
        end
        while times < CaT(Cah1 -1)
            Cah1 = Cah1 - 1;
        end
        Cah2 = (CaT(Cah1)-times)*1/(CaT(Cah1)-CaT(Cah1-1));
        thisAmp = (CaX(Cah1-1)*Cah2 + CaX(Cah1)*(1-Cah2));
    end
end
end