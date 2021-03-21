.. _scripts:

Scripts
=======

In this workflow we use one main script that calls all the relevant functions top be used.
To run this script MATLAB\ |Reg| should be opened with the folder called Matlab as the main folder.
When running the script a user facing prompt should be generated that allows the user to choose;

- The model to use (from all the models that are in the Matlab/model folder)

- The settings file to use on the model

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


Examples for each of the model run through our workflow can be find on 

- `Fujita_2010 examples <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Results/Examples>`_
- `Nair_2016 examples <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Results/Examples>`_
- `Viswan_2018 examples <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Results/Examples>`_


Run_main
--------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Run_main.m
        :language: matlab
        :linenos:
		
This is the main script from the MATLAB\ |Reg| portion of the workflow. 
Depending on the configurations on the :ref:`settings file<f_settings>` and choices on the user facing prompts it can call functions to:

  * :ref:`Perform conversions of the SBtab:<functions_import>`

    * SBtab( .xlsx) to SBtab (.tsv)
    * SBtab (.xlsx) to MATLAB\ |Reg| SimBiology\ |TM| (.m, .sbproj)
    * MATLAB\ |Reg| SimBiology\ |TM| to SBML (.xml)
	
  * :ref:`Perform analysis on the model:<functions_analysis>`
  
    * Diagnostics
    * Parameter Estimation
    * Global Sensitivity Analysis
	
  * :ref:`Saving results from analysis<f_save_analysis>`
  * :ref:`Ploting relevant results<f_plot>`
  * :ref:`Saving plots<f_save_plots>`
  
  It can also reproduce a the calcualtions of a previous analysis or just its plots.