.. _diag:

Diagnostics
===========

The specifications of the diagnostics operations require user input in the `settings file <https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html#import>`_. The toolkit imports the model in an `SBtab format <https://subcellular-workflow.readthedocs.io/en/master/SBtab.html>`_ (with the name specified by stg.sbtab_excel_name variable in a folder specified by stg.folder_model) to a .sbproj file, and saves it in the subfolder called Results along with the imported data. Once the model has been imported, the import function can be disabled in the `import section of the settings file <https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html#import>`_ for further procedures. 

The parameter sets that are specified in the `diagnostics section of the settings file <https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html#diagnostics>`_ are then used in model simulations with the input specifications (e.g. time series data for relevant input species) in the Experiment Input (EI) tables in the SBtab file, calculate the error between the simulation results and the experimental data, and plot the error scores as well as the comparative traces of the simulation results and the experimental data. At least one parameter set is currently required in the settings file. Experiments of interest can be specified by the stg.run variable in the `analysis section of the settings file <https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html#diagnostics>`_.
