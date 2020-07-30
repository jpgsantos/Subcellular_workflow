SBtab
=====

This is an overview of the SBtab syntax that is necessary for our workflow to run smoothly. This contains a list of the tab names and subfields that are read by the software. The second column in the first row of each tab must include "TableName='tab name'". Fields that are not mentioned here are not used in the latest workflow and are not imported but might be added to future releases. Note that our code currently only recognizes reactions represented by mass action. Additional information on how to use SBtab can be found in https://www.sbtab.net/sbtab/default/documentation.html.

Compound
--------

- **!ID** - must start with letter S and is followed by an index, starting with 0 for the first species.

- **!Name** - must start with a letter. We advise to use recognizable species names and separate complexes of multiple species with '_' (e.g. A_B).

- **!Unit** - should be the same as the default unit used in MATLAB SimBiology, usually nanomole. 

- **!InitialValue** - should include the total amounts of the conserved species and have 0 for the rest of the reactants in nM. 

- **!IsConstant** - assigns a binary value, either TRUE or FALSE, depending on whether the value of a particular species should stay constant throughout the simulations. Note that the input species should remain constant.

Reaction
--------

- **!IsReversible** - TRUE for reversible and FALSE for irreversible reactions.

- **!ReactionFormula** - should be written in the form 'A + B <= > A_B'.

Parameter
---------

- **!Comment** - refers to the name of parameter and has to start with either 'kf' for the forward reactions rates or 'kr' for the backward reactions rates. We advise to name the parameters after the corresponding reactions, e.g. 'kf_AXB__A_B' and 'kr_AXB__A_B' for the reaction 'A + B <= > A_B'.

- **!Value:linspace** or **!DefaultValue** - represents the parameter value in linear space.

- **!Unit** - represents the units of the parameters and are generally 1/(nanomole*second) for forward rates and 1/second for backward rates.

Input
-----

Species used as inputs in experimental data.

- **!ID** - must start with 'CLU' followed by the index starting with 1.

- **!Name** - has to correspond to the species name used in the Compound table.

Output
------

Species used as outputs in experimental data.

- **!ID** - should start with 'Y' followed by an index starting with 0. 

- **!Name** - has to correspond to the species name used in the Compound table.

- **!Formula** - has to include the species itself and in case of model rearrangements be followed by newly added species for which new conservation laws must apply, e.g. if species B is added to the model and forms a complex A_B with A, then the formula for output A should be 'A + A_B'.

Experiments
-----------

Each column corresponds to one experiment for which there is a separate tab.

- **>Output** - should list all the output ID's, i.e. Y's followed by their indices and separated by commas.

- **>CLU1** - followed by the input species index from the input table should have the input concentrations for each experiment. If not specified then does it take it from the input tab (perhaps it should)?

- **!Normstart** - ?

E
-

Corresponds to individual experiments and has to be followed by experiment index starting with 0.

- **!Time** - for time series data represents a list of all the time points for all the output data points.

- **>Y0** - followed by an index refers to the species ID in the output table and should include the concentration data points.

- **SD_Y0** - followed by an index represents the standard deviation for each data point.

- **!InputTime** - for time series data represent a list of all the time points for the input data points. In case of events only the specific event time point can be written. Not that a column for 

- **>S0** - followed by an index refers to the input species ID in the Compound table. This column should represent the concentration data points.

- **!Sim_Time** - should have the total simulation time for the particular experiment.

- **Max** - ?