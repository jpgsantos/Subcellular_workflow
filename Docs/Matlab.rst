MATLAB\ |Reg| code
==================

The MATLAB\ |Reg| section of this workflow has been developed to facilitate model building and 
rapid iteration between different versions of a model.
In this workflow we use one main script that calls all the relevant functions to be used.
To run this script MATLAB\ |Reg| should be opened with the folder "Matlab" from our repository as the main folder.
When running the script a user facing prompt should be generated that allows the user to choose;

- The model to use (from all the models that are in the "Matlab/model" folder)

- The settings file to use on the model (From the settings files present in "Matlab/model/Model_name/settings")

- The analysis to be performed, with the following options:

  - Diagnostics
  
  
  - Parameter Estimation
  
  
  - Global Sensitivity Analysis
  
  
  - Repruduction of a previous Analysis
  
      This option can be used to re-do an analysis that has previously been performed.
      This is useful for reproducibility and in the case of the code getting updated with extra funcionalities.
      The user should specify the analysis file that they want to use, examples are provided in the each model repository.
  
  - Reproduction of the plots of a previous analyis
  
      Similar to the previous option but here only the plots are re-done.
  
Examples for each of the model run through teh workflow can be find on 

- `Fujita_2010 examples <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Results/Examples>`_
- `Nair_2016 examples <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Results/Examples>`_
- `Viswan_2018 examples <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Results/Examples>`_

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

   Scripts
   Functions
   Settings_file
   Results
   Files