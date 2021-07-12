.. _diag:

Diagnostics
===========

The specifications of the diagnostics operations require user input in the :ref:`settings file<stg>`. The toolkit imports the model stored in :ref:`SBtab format<sbtab>` (with the name specified by :ref:`stg.sbtab_excel_name<stg.sbtab_excel_name>` variable from a folder chosen by the user terminal prompts) to a .sbproj file, and saves it in the subfolder called Data along with the imported data and inputs in a .mat format. Once the model has been imported, the import function can be disabled in the :ref:`import section of the settings file<stg.imp>` for further procedures. 

The parameter sets that are specified in the :ref:`diagnostics section of the settings file<stg.diag>` are then used in model simulations with the input specifications (e.g. time series data for relevant input species) in the Experiment Input (EI) tables in the SBtab file, calculate the error between the simulation results and the experimental data, and plot the error scores as well as the comparative traces of the simulation results and the experimental data. At least one parameter set is currently required in the settings file. Experiments of interest can be specified by the :ref:`stg.exprun<stg.exprun>` variable in the :ref:`analysis section of the settings file<stg.analysis>`.