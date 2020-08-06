.. _sbtab:

SBtab
=====

This is an overview of the SBtab syntax that is used in our workflow.
This contains a list of the tab names and subfields that are read by the software.
The second column in the first row of each tab must include "TableName='tab name'".
Fields that are not mentioned here are not used in the latest workflow and are not imported but might be added to future releases.
Note that our code currently only recognizes reactions represented by mass action.
Additional information on how to use SBtab can be found in https://www.sbtab.net/sbtab/default/documentation.html.

.. _compound:

Compound
--------

.. _compound_id:

- **!ID** - must start with letter S and is followed by an index, starting with 0 for the first species.

.. _compound_name:

- **!Name** - must start with a letter. We advise to use recognizable species names and separate complexes of multiple species with '_' (e.g. A_B).

.. _compound_unit:

- **!Unit** - should be the same as the default unit used in MATLAB SimBiology, usually nanomole. 

.. _compound_initialvalue:

- **!InitialValue** - should include the total amounts of the conserved species and have 0 for the rest of the reactants in nM. 

.. _compound_isconstant:

- **!IsConstant** - assigns a binary value, either TRUE or FALSE, depending on whether the value of a particular species should stay constant throughout the simulations. Note that the input species should remain constant.

.. _reaction:

Reaction
--------

.. _reaction_isReversible:

- **!IsReversible** - TRUE for reversible and FALSE for irreversible reactions.

.. _reaction_reactionformula:

- **!ReactionFormula** - should be written in the form 'A + B <= > A_B'.

.. _parameter:

Parameter
---------

.. _parameter_comment:

- **!Comment** - refers to the name of parameter and has to start with either 'kf' for the forward reactions rates or 'kr' for the backward reactions rates. We advise to name the parameters after the corresponding reactions, e.g. 'kf_AXB__A_B' and 'kr_AXB__A_B' for the reaction 'A + B <= > A_B'.

.. _parameter_value_lin:

- **!Value:linspace** or **!DefaultValue** - represents the parameter value in linear space.

.. _parameter_unit:

- **!Unit** - represents the units of the parameters and are generally 1/(nanomole*second) for forward rates and 1/second for backward rates.

.. _input:

Input
-----

Species used as inputs in experimental data.

.. _id:

- **!ID** - must start with 'CLU' followed by the index starting with 1.

.. _input_name:

- **!Name** - has to correspond to the species name used in the Compound table.

.. _output:

Output
------

Species used as outputs in experimental data.

.. _output_id:

- **!ID** - should start with 'Y' followed by an index starting with 0. 

.. _output_name:

- **!Name** - has to correspond to the species name used in the Compound table.

.. _output_formula:

- **!Formula** - has to include the species itself and in case of model rearrangements be followed by newly added species for which new conservation laws must apply, e.g. if species B is added to the model and forms a complex A_B with A, then the formula for output A should be 'A + A_B'.

.. _experiments:

Experiments
-----------

Each column corresponds to one experiment for which there is a separate tab.

.. _experiments_outputs:

- **>Output** - should list all the output ID's, i.e. Y's followed by their indices and separated by commas.

.. _experiments_clu:

- **>CLU**\ :sub:`i`\ - followed by the input species index from the input table should have the input concentrations for each experiment. If not specified then does it take it from the input tab (perhaps it should)?

.. _e:

E\ :sub:`i`\
------------

Corresponds to individual experiments and has to be followed by experiment index starting with 0.

.. _e_time:

- **!Time** - for time series data represents a list of all the time points for all the output data points.

.. _e_y:

- **`>Y**\ :sub:`i`\ - followed by an index refers to the species ID in the output table and should include the concentration data points.

.. _e_sd_y:

- **`SD_Y**\ :sub:`i`\ - followed by an index represents the standard deviation for each data point.

.. _ei

E\ :sub:`i`\I
-------------

.. _ei_imput_time:

- **!Input\_Time\_S**\ :sub:`i`\ - for time series data represent a list of all the time points for the input data points. In case of events only the specific event time point can be written. Not that a column for 

.. _ei_s:

- **`>S**\ :sub:`i`\ - followed by an index refers to the input species ID in the Compound table. This column should represent the concentration data points.
