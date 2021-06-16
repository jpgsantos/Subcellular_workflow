function Example_input_creator(~)
load('C:/Users/Santos/Documents/GitHub/Subcellular_workflow/Matlab/Model/Model_Example/Data/data_Example.mat','sbtab');
exp2_Ligand(:,1) =sbtab.datasets(2).input_time{1};
exp2_Ligand(:,2) =sbtab.datasets(2).input_value{1};
save('C:/Users/Santos/Documents/GitHub/Subcellular_workflow/Matlab/Model/Model_Example/Data/Input_Example.mat','exp2_Ligand');
end
