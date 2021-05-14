.. _scripts:

Scripts
=======

This is the entry point for our code, it calls all other relevant functions. 

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
    * SBtab (.xlsx) to MATLAB\ |Reg| SimBiology\ |Reg| (.m, .sbproj)
    * MATLAB\ |Reg| SimBiology\ |Reg| to SBML (.xml)
	
  * :ref:`Perform analysis on the model:<functions_analysis>`
  
    * Diagnostics
    * Parameter Estimation
    * Global Sensitivity Analysis
	
  * :ref:`Saving results from analysis<f_save_analysis>`
  * :ref:`Plotting relevant results<f_plot>`
  * :ref:`Saving plots<f_save_plots>`
  
  It can also reproduce a the calculations of a previous analysis or just its plots.
