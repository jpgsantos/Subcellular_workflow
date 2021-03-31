.. _files:

Model files and folders 
=======================

Extra model-specific files that should be provided by the user or are generated after the setup and import functions have been run.

|

`SBtab <https://www.sbtab.net/>`_
---------------------------------

  .. _sbtab.xlsx:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\sbtab\_\ :ref:`name<stg.name>`.xlsx
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains the SBtab in .xlsx format. 
It needs to be provided for the MATLAB\ |Reg| part of the workflow to work.

  .. _sbtab.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\sbtab\_\ :ref:`name<stg.name>`.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains the SBtab in .mat format.
It is generated after the run of the MATLAB\ |Reg| part of the workflow if :ref:`import<stg.import>` is chosen in settings.

  .. _sbtab.tsv:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\tsv
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This folder contains the SBtab in .tsv format.
It is generated after the run of the MATLAB\ |Reg| part of the workflow if :ref:`import<stg.import>` is chosen in settings.

|

Model
-----

  .. _model.sbproj:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\model\_\ :ref:`name<stg.name>`.sbproj
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains the model derived from the SBtab in .sbproj (MATLAB\ |Reg| SimBiology\ |Reg|) format.
It is generated after the run of the MATLAB\ |Reg| part of the workflow if :ref:`import<stg.import>` is chosen in settings.

  .. _model.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\model\_\ :ref:`name<stg.name>`.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains the model derived from the SBtab in .mat format.
It is generated after the run of the MATLAB\ |Reg| part of the workflow if :ref:`import<stg.import>` is chosen in settings.

  .. _model.xml:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\model\_\ :ref:`name<stg.name>`.xml
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains the model derived from the SBtab in .xml (SBML) format.
It is generated after the run of the MATLAB\ |Reg| part of the workflow if :ref:`import<stg.import>` is chosen in settings.

|

Data
----

  .. _data.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\data\_\ :ref:`name<stg.name>`.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains data derived from the SBtab in a .mat format.
This data is used to run the model taking into account all the inputs and outputs of the model.

  .. _input.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\Input\_\ :ref:`name<stg.name>`.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file contains input data derived from the SBtab in a .mat format for all the experimental inputs.

|

  .. _rr_model:

Ready to run model
------------------

  .. _rr_model.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\Exp\\Model\_\ :ref:`name<stg.name>`\_i.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These files contain a version of the model for each experiment contained in the SBtab.
They include all the neccessary inputs and outputs to simulate the supplied experimental conditions.

  .. _rr_model_eq.mat:

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Data\\Exp\\Model_eq\_\ :ref:`name<stg.name>`\_i.mat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Same as previously but tailor made for the equilibration step of the simulation.

|

  .. _files_functions:

Functions
---------

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Formulas\\ :ref:`name<stg.name>`\_input_i\_\ :ref:`input_name<input_name>`.m
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These functions interpolate the input that is supposed to be given to the model at run time.

Model\\ :ref:`model_folder_name<stg.folder_model>`\\Formulas\\ :ref:`name<stg.name>`\_input_creator.m
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Creates the previous functions for all experimental inputs.

|

Settings
--------

:ref:`Model\\model_folder_name\\Settings\\<stg>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A place for the user to define all the relevant properties of model simulation that are not stored in SBtab.
These are usually things that need to change during optimizations or model development.
