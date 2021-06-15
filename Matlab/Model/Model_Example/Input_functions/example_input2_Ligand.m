function thisAmp = example_input2_Ligand(times)
persistent LigandX
persistent LigandT
persistent Ligandh1
persistent Ligandh2
if isempty(LigandX)
Data = coder.load('C:/Users/Santos/Documents/GitHub/Subcellular_workflow/Matlab//Model/Model_Example/Data/Input_example.mat','exp2_Ligand');
LigandX = Data.exp2_Ligand(:,2);
LigandT = Data.exp2_Ligand(:,1);
Ligandh1 = 1;
end
thisAmp = LigandX(end);
if times ~= 10
if times == 0
Ligandh1 = 1;
thisAmp = LigandX(1);
else
while times > LigandT(Ligandh1)
Ligandh1 = Ligandh1 + 1;
end
while times < LigandT(Ligandh1 -1)
Ligandh1 = Ligandh1 - 1;
end
Ligandh2 = (LigandT(Ligandh1)-times)*1/(LigandT(Ligandh1)-LigandT(Ligandh1-1));
thisAmp = (LigandX(Ligandh1-1)*Ligandh2 + LigandX(Ligandh1)*(1-Ligandh2));
end
end
end