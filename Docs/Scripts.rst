.. _scripts:

Scripts
=======

In this workflow we use three MATLAB\ |TM| scripts:

- Run_main - Runs the analysis predetermined in the settings file
- Reproduce_analysis - Reruns the analysis saved in a results file
- Reproduce_analysis_plots - Reproduces the plots from the analysis saved in a results file

We have provided an example diagnostics run and an example global sensitivity analysis run, the results of which can be found on the following folders: 

- Diagnostics - MATLAB/Model/D1_LTP_time_window/Results/Analysis_diagnostics_example
- Global Sensitivity analysis - MATLAB/Model/D1_LTP_time_window/Results/Analysis_GSA_example

To run these scripts MATLAB\ |TM| should be opened with the folder called MATLAB\ |TM| as the main folder

Run_main
--------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Run_main.m
        :language: matlab
        :linenos:
		
This is the main script from the MATLAB\ |TM| portion of the workflow. 
Depending on the configurations on the :ref:`settings file<f_settings>` it can call functions to:

  * :ref:`Perform conversions of the SBtab:<functions_import>`

    * SBtab(.xlsx) to SBtab(.tsv)
    * SBtab(.xlsx) to MATLAB\ |TM| SimBiology(.m, .sbproj)
    * MATLAB\ |TM| SimBiology to SBML(.xml)
	
  * :ref:`Perform analysis on the model:<functions_analysis>`
  
    * Diagnostics
    * Parameter estimation
    * Global sensitivity analysis
  
  * :ref:`Saving results from analysis<f_save_analysis>`
  * :ref:`Ploting relevant results<f_plot>`
  * :ref:`Saving plots<f_save_plots>`

Reproduce_analysis
------------------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Reproduce_analysis.m
        :language: matlab
        :linenos:

This script can be used to re-do an analysis that has previously been run.
This is useful for reproducibility and in the case of the code getting updated with extra funcionalities.
The user should specify the analysis file that they want to use, two examples are provided in the code.


Reproduce_analysis_plots
------------------------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Reproduce_analysis_plots.m
        :language: matlab
        :linenos:

Similar to the previous script but here only the plots are re-done.
