Scripts
=======

In this workflow we use three matlab scripts:

- Run_main - Runs the analysis predetermined in the settings file
- Reproduce_analysis - Re-runs the analysis saved in a results file
- Reproduce_analysis_plots - Re-runs the plots of an analysis saved in a results file

We have provided an example diagnostics run and an example Global Sensitivity analysis run, the results of which can be found on the following folders: 

- Diagnostics - Matlab/Model/D1_LTP_time_window/Results/Analysis_diagnostics_example
- Global Sensitivity analysis - Matlab/Model/D1_LTP_time_window/Results/Analysis_GSA_example

To run these scripts Matlab should be open with the folder called Matlab as the main folder

Run_main
--------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Run_main.m
        :language: matlab
        :linenos:
		
This is the main script from the matlab portion of the workflow, 
depending on the configurations on the :ref:`settings file<f_settings>` it can call functions to:

  * :ref:`Perform the conversions of the SBtab to:<f_import>`

    * SBtab(.xlsx) to SBtab(.tsv)
    * SBtab(.xlsx) to MATLAB SimBiology(.m, .sbproj)
    * MATLAB SimBiology to SBML(.xml)
	
  * :ref:`Perform analysis on the model:<f_analysis>`
  
    * Diagnostics
    * Parameter estimation
    * Global sensitivity analysis
  
  * :ref:`Saving results from analysis<f_save_analysis>`
  * :ref:`Ploting relevant results<f_plot>`
  * :ref:`Saving plots<f_save_plots>`
  
- **Loads**
- **Saves**

Reproduce_analysis
------------------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Reproduce_analysis.m
        :language: matlab
        :linenos:

- **Calls**
- **Loads**
- **Saves**

Reproduce_analysis_plots
------------------------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Reproduce_analysis_plots.m
        :language: matlab
        :linenos:
		
- **Calls**
- **Loads**
- **Saves**