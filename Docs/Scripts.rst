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
		
Main functions called from here

- **Calls**

  - :ref:`f_load_settings<f_load_settings>`
  - :ref:`f_import<f_import>`
  - :ref:`f_generate_sbtab_struct<f_generate_sbtab_struct>`
  - :ref:`f_analysis<f_analysis>`
  - :ref:`f_save_analysis<f_save_analysis>`
  - :ref:`f_plot<f_plot>`
  - :ref:`f_save_plots<f_save_plots>`

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