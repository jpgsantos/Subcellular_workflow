MATLAB&reg; code
===============

The MATLAB&reg; section of this workflow has been developed to facilitate model building and 
rapid iteration between different versions of a model.
In this workflow we use one main script, "Run_main.m", that calls all the relevant functions to be used.
To run the MATLAB&reg; code the Subcellular Workflow repository should be added to the MATLAB&reg; path.
Running the script "Run_main.m" generates a prompt in the MATLAB&reg; terminal, this requires user input to choose between the numbered options. These prompts allow the user to choose:

  - The model to use (from all the models that are in the "Matlab/model" folder). 
	
	The first time you run a model you have to add the folder for a specific model from its home repository (e.g. copy the folder "Model_nair_2016" from its repository to "Matlab/model/" ).
	
	For implemented models so far go to the following links:
	
	- [Fujita_2010 model](https://github.com/jpgsantos/Model_Fujita_2010/)
	- [Nair_2016 model](https://github.com/jpgsantos/Model_Nair_2016/)
	- [Viswan_2018 model](https://github.com/jpgsantos/Model_Viswan_2018/)
	
  - The analysis to be performed, with the following options:

    1 - [Diagnostics](https://subcellular-workflow.readthedocs.io/en/development/Diagnostics.html)
  
    2 - [Parameter Estimation](https://subcellular-workflow.readthedocs.io/en/development/param_ext.html)
  
    3 - [Global Sensitivity Analysis](https://subcellular-workflow.readthedocs.io/en/development/gsa.html)
	
    4 - Repruduction of a previous Analysis
  
         This option can be used to re-do an analysis that has previously been performed.
         This is useful for reproducibility and in the case of the code getting updated with extra funcionalities.
         The user should specify the analysis file that they want to use, examples are provided in the each model repository.
  
    5 - Reproduction of the plots of a previous analyis
 
         Similar to the previous option but here only the plots are re-done.

  - The [settings file](https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html) to use on the model.
    
	These settings files can be found can be found on the respective model repository in the directory "Matlab/Settings", in the example model from our main repository in the directory "Matlab/model/Model_Example/Matlab/Settings", or by following these links:
	
    - [Example model settings files](https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab/Model/Model_Example/Matlab/Settings)
    - [Fujita_2010 model settings files](https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Settings)
    - [Nair_2016 model settings files](https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Settings)
    - [Viswan_2018 model settings files](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Settings)
	
Examples of the output recieved when the different models are run through the workflow can be found on the respective model repository in the directory "Matlab/Results/Results/Examples", or by following these links:

  - [Fujita_2010 model example results](https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Results/Examples)
  - [Nair_2016 model example results](https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Results/Examples)
  - [Viswan_2018 model example results](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Results/Examples)

In order to gain a better understanding on how the code works, please look at our [online documentation](https://subcellular-workflow.readthedocs.io/).