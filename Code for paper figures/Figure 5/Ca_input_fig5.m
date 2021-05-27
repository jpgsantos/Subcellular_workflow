function thisAmp = Ca_input_fig5(times)
persistent CaX
persistent CaT
persistent Cah1
persistent Cah2
if isempty(CaX)
Data = coder.load('../Subcellular_workflow/Code for paper figures/Figure 5/inputs.mat','x','t');
CaX = Data.x;
CaT = Data.t;
Cah1 = 1;
end
thisAmp = CaX(end);
if times ~= 20
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