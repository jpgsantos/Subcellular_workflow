.. _sbtab:

SBtab
=====

This is an overview of the SBtab syntax that is used in our workflow.
This contains a list of the tab names and subfields that are read by the software.
The second column in the first row of each tab must include "TableName='tab name'".
Fields that are not mentioned here are not used in the latest workflow and are not imported but might be added to future releases.
Note that our code currently only recognizes reactions represented by mass action.
Additional information on how to use SBtab can be found in https://www.sbtab.net/sbtab/default/documentation.html.


.. _compartment:

Compartment
--------

.. _compartment_id:

- **!ID** - must start with letter V and is followed by an index, starting with 1 for the first compartment.

.. _compartment_name:

- **!Name** - name of the compartment.

.. _compartment_unit:

- **!Unit** - compartment volume unit, usually liter.

.. _compartment_size:

- **!Size** - size of the compartment in units defined in the unit column.

.. _compound:

Compound
--------

.. _compound_id:

- **!ID** - must start with letter S and is followed by an index, starting with 0 for the first species.

.. _compound_name:

- **!Name** - must start with a letter. We advise to use recognizable species names and separate complexes of multiple species with '_' (e.g. A_B).

.. _compound_unit:

- **!Unit** - should be the same as the default unit used in MATLAB\ |Reg| SimBiology\ |TM|, usually nanomole or nanomole/liter. 

.. _compound_initialvalue:

- **!InitialValue** - should include the total amounts of the conserved species and have 0 for the rest of the reactants in units specified previously. These are the initial amounts before the equilibration step.

.. _compound_isconstant:

- **!IsConstant** - assigns a binary value, either TRUE or FALSE, depending on whether the value of a particular species should stay constant throughout the simulations. Note that the input species should remain constant.

.. _compound_assignment:

- **!Assignment** - assigns a binary value, either TRUE or FALSE

.. _compound_interpolation:

- **!Interpolation** -

.. _compound_type:

- **!Type** - type of the reaction

.. _compound_location:

- **!Location** - compartment in which a particular species is present.

.. _reaction:

Reaction
--------

.. _reaction_id:

- **!ID** - must start with letter R and is followed by an index, starting with 0 for the first reaction.

.. _reaction_name:

- **!Name** - must start with a letter and it is advisable to include the reaction index, e.g. ReactionFlux0.

.. _reaction_kineticLaw:

- **!KineticLaw** - needs to include the precise mass action kinetic law with species and parameter names from corresponding SBtab table. For a reaction 'A + B <=> A_B' with a forward reaction rate of kf_R0 and backward reaction rate of kr_R0 the formula would look like 'kf_R0*A*B-kr_R0*A_B'.

.. _reaction_isReversible:

- **!IsReversible** - TRUE for reversible and FALSE for irreversible reactions.

.. _reaction_location:

- **!Location** - compartment in which a particular reaction is taking place.

.. _reaction_kineticLawType:

- **!KineticLawType** - currently the workflow supports only mass action reactions which needs to be specified as 'MassAction'.

.. _reaction_reactionformula:

- **!ReactionFormula** - should be written in the form 'A + B <= > A_B'.

.. _parameter:

Parameter
---------

.. _parameter_id:

- **!ID** - must start with letter K and is followed by an index, starting with 0 for the first parameter.

.. _parameter_name:

- **!Name** - must start with 'kf' for forward reactions rates and 'kr' for reverese rates, and is followed by the R and the reaction index, e.g. 'kf_R0'.

.. _parameter_unit:

- **!Unit** - represents the units of the parameters and are generally '1/(nanomole*second)' for forward rates and '1/second' for backward rates.

.. _parameter_value:log2:

- **!Value:log2** - parameter value in log base 2. Usage is optional.

.. _parameter_value_lin:

- **!Value:linspace** or **!DefaultValue** - represents the parameter value in linear space.

.. _parameter_value:log10:

- **!Value:log10** - parameter value in log base 10.

.. _parameter_location:

- **!Location** - compartment in which a particular parameter is governing a reaction.

.. _parameter_comment:

- **!Comment** - a handy way of determining which reaction the parameter is involved in. We advise to use the following syntax for forward rates 'kf_AXB__A_B' and 'kr_AXB__A_B' for backward rates for a reaction 'A + B <= > A_B'.

.. _expression:

Expression
-----

Species which are defined by expressions.

.. _expression_id:

- **!ID** - must start with 'Ex' followed by the index starting with 0.

.. _expression_name:

- **!Name** - has to correspond to the species name used in the Compound table.

.. _expression_formula:

- **!Formula** - the formula representing the expression using the species names used in the compound table and, if needed, constants in the constant table.

.. _expression_unit:

- **!Unit** - concentration unit for the particular species corresponding the the species unit in the Compound table.

.. _expression_location:

- **!Location** - compartment in which a particular species is located.

.. _output:

Output
------

Species used as outputs in experimental data.

.. _output_id:

- **!ID** - should start with 'Y' followed by an index starting with 0. 

.. _output_name:

- **!Name** - has to correspond to the species name used in the Compound table.

.. _output_errorName:

- **!ErrorName** - Should start with 'SD' (referring to standard deviation) followed by the output ID, e.g. SD_Y0.

.. _output_errorType:

- **!ErrorType** - 'abs+rel random noise (std)'.

.. _output_unit:

- **!Unit** - concentration unit for the particular output species corresponding the the species unit in the Compound table.

.. _output_probDist:

- **!ProbDist** - probability distribution type, e.g. 'normal'.

.. _output_location:

- **!Location** - compartment in which a particular output species is located.

.. _output_formula:

- **!Formula** - has to include the species itself and, in case of model rearrangements, be followed by newly added species for which new conservation laws must apply, e.g. if species B is added to the model and forms a complex A_B with A, then the formula for output A should be 'A + A_B'.

.. _experiments:

Experiments
-----------

Each column corresponds to one experiment for which there is a separate tab.

.. _experiments_id:

- **!ID** - should start with 'E' followed by the experiment index starting with 1.

.. _experiments_name:

- **!Name** - we advise using the the word 'Experiment' followed by the experiment index.

.. _experiments_relativeTolerance:

- **!RelativeTo** - relative tolerance value for simulations. Optional.

.. _experiments_type:

- **!Type** - type of the experimental data set, e.g. time series, dose response.

.. _experiments_output:

- **>Output** - should list all the output ID's, i.e. Y's followed by their indices and separated by commas.

.. _experiments_event:

- **!Event** -

.. _experiments_clu:

- **>S**\ :sub:`i`\ - followed by the input species index from the Compound table should have the input concentrations/total amounts for species that have initial amount values other than 0 for each experiment. 

.. _experiments_likelihood:

- **!Likelihood** -

.. _experiments_simTime:

- **!SimTime** - simulation time for a particular experiment.

.. _experiments_normalize:

- **!Normalize** - if the output is normalized to a certain value, this can be specified here.

.. _e:

E\ :sub:`i`\
------------

Corresponds to individual experiments and has to be followed by experiment index starting with 0.

.. _e_id:

- **!ID** - ID's for specific output sampling time points. Should start with the experiment name (e.g E0) followed by 'T' and the time point index, e.g. E0T0, E0T1, etc.

.. _e_time:

- **!Time** - for time series data, this should include a list of all the time points for all the time points during which the corresponding output data points were sampled.

.. _e_y:

- **`>Y**\ :sub:`i`\ - followed by an index refers to the species ID in the output table and should include the sampled concentration data points.

.. _e_sd_y:

- **`SD_Y**\ :sub:`i`\ - followed by an index represents the standard deviation for each data point.

.. _ei:

E\ :sub:`i`\I
-------------

Corresponds to individual experiments and has to be followed by experiment index starting with 0 and the letter 'I', e.g. E0I.

.. _ei_id:

- **!ID** - ID's for specific input sampling time points. Should start with the experiment input name (e.g E0I) followed by 'T' and the time point index, e.g. E0IT0, E0IT1, etc. 

.. _ei_imput_time:

- **!Input\_Time\_S**\ :sub:`i`\ - for time series data, this should include a list of all the time points during which the corresponding input data points were sampled. To produce simple step inputs, only the time points during which a change in concentration is happening can be included. To produce more complicated input curves, more time points are needed to represent the shape of the curve.
.. _ei_s:

- **`>S**\ :sub:`i`\ - followed by an index refers to the input species ID in the Compound table. This column should represent the sampled concentration data points corresponding to each time point.
