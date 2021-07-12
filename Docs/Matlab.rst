MATLAB\ |Reg|
=============

The MATLAB\ |Reg| section of this workflow has been developed to facilitate model building and 
rapid iteration between different versions of a model.
In this workflow we use one main script, "Run_main.m", that calls all the relevant functions to be used.
To run the MATLAB\ |Reg| code the Subcellular Workflow repository should be added to the MATLAB\ |Reg| path.
Running the script "Run_main.m" generates prompts in the MATLAB\ |Reg| terminal window with a request to the user, to choose between a number of different options. These prompts allow the user to choose:

  - The model to use (from all the models that are in the "Matlab/model" folder). 
	
	| Note that the very first time you run a model you have to add the folder for that specific model from its home repository into the “Matlab/model” folder(e.g. copy the folder "Model_nair_2016" from its repository to "Matlab/model/" ).
	| For implemented models so far go to the following links:
	
	- `Fujita_2010 model <https://github.com/jpgsantos/Model_Fujita_2010/>`_
	- `Nair_2016 model <https://github.com/jpgsantos/Model_Nair_2016/>`_
	- `Viswan_2018 model <https://github.com/jpgsantos/Model_Viswan_2018/>`_
	
  - The analysis to be performed, with the following options:

    1. :ref:`Diagnostics<diag>`
  
    2. :ref:`Parameter Estimation<param_ext>`
  
    3. :ref:`Global Sensitivity Analysis<gsa>`
  
    4. Reproduction of a previous analysis
  
      This option can be used to re-do an analysis that has previously been performed.
      This is useful for reproducibility and in the case of the code getting updated with extra funcionalities.
      The user should specify the analysis file that they want to use, examples are provided in the each model repository.
  
    5. Reproduction of the plots of a previous analyis
  
      Similar to the previous option but here only the plots are re-done.
	  
    6. Import model files

      Creation of the model files and folder that are needed to run the model in Matlab, the creation of a folder with the model in .tsv format (one tsv file for each excel sheet of the original SBtab), as well as the conversion of the model to the SBML format (.xml).

  - | The :ref:`settings file<stg>` to use on the model.
    | These settings files can be found either in the respective model repository in the directory "Matlab/Settings", or in the example model from our main repository in the directory "Matlab/model/Model_Example/Matlab/Settings", or by following these links:
	
    - `Example model settings files <https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab/Model/Model_Example/Matlab/Settings>`_
    - `Fujita_2010 model settings files <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Settings>`_
    - `Nair_2016 model settings files  <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Settings>`_
    - `Viswan_2018 model settings files  <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Settings>`_
	
Examples of the output recieved when the different models are run through the workflow can be found on the respective model repository in the directory "Matlab/Results/Results/Examples", or by following these links:

  - `Fujita_2010 model example results <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Results/Examples>`_
  - `Nair_2016 model example results <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Results/Examples>`_
  - `Viswan_2018 model example results <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Results/Examples>`_

In order to gain a better understanding on how the code works, there are detailed pages for the following:

  - :ref:`Scripts<scripts>` - The script that we use;
  - :ref:`Functions<functions>` - All the custom functions we have built; this is directed 
    to anyone that wants to develop or iterate the code;
  - :ref:`Settings file<stg>` - The master configuration file, where we describe everything
    that can be modified by the user without changing any code;
  - :ref:`Results<rst>` - Explanation of all the files containing relevant results that are
    generated after running the built-in analysis of the code;
  - :ref:`Model files and folders<files>` - Description of all the files and folders that are
    generated when the model is imported from SBtab into relevant files,
    used by the rest of the MATLAB\ |Reg| code.

.. toctree::
   :hidden:
   :maxdepth: 2

   Analysis
   Scripts
   Functions
   Settings_file
   Results
   Files