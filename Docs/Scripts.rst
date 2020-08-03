Scripts
=======

In this workflow we use three matlab scripts:

- Run_main - Runs the analysis predetermined in the settings file
- Reproduce_analysis - Re-runs the analysis saved in a results file
- Reproduce_analysis_plots - Re-runs the plots of an analysis saved in a results file

To run these scripts Matlab should be open with the folder called Matlab as the main folder

Run_main
--------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Run_main.m
        :language: matlab
        :linenos:
		
Main functions called from here

- **Calls** - :ref:`f_settings<f_settings>`, :ref:`f_diagnostics<f_diagnostics>`, :ref:`f_opt<f_opt>`,
  :ref:`f_SA<f_SA>`
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