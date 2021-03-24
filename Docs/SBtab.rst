.. _sbtab:

SBtab
=====

This is an overview of the SBtab syntax that is used in our workflow.
This contains a list of the sheet names and subfields that are read by our software.
The second column in the first row of each sheet must include "TableName='sheet name'".
Fields that are not mentioned here are not used in the latest workflow and are not imported but might be added to future releases.
Additional information on how to use SBtab can be found in https://www.sbtab.net/sbtab/default/documentation.html.



.. _defaults:

Defaults
-----------

.. _defaults_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "D" followed by an integer, should start at 1.

.. _defaults_name:

- **!Name** - Name of the default variable being defined, we have used time, volume, substance, lenght, and area in our files.

.. _defaults_unit:

- **!Unit** - Unit of the default variable, eg. time - second.


.. _compartment:

Compartment
-----------

.. _compartment_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "V" followed by an integer, should start at 1.

.. _compartment_name:

- **!Name** - Name of the compartment.

.. _compartment_unit:

- **!Unit** - Compartment volume unit, usually liter.

.. _compartment_size:

- **!Size** - Size of the compartment in units defined in the unit column.

.. _compound:

Compound
--------

.. _compound_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "S" followed by an integer, should start at 0.

.. _compound_name:

- **!Name** - Name of the compound. We advise to use recognizable compound names and separate complexes of multiple compounds with '_' (e.g. A_B). Must start with a letter. 

.. _compound_unit:

- **!Unit** - Unit for the compound, usually nanomole or nanomole/liter. If it is not a default MATLAB \|Reg| unit it should be added to it before trying to run the scripts.

.. _compound_initialvalue:

- **!InitialValue** - Default initial values for the compounds before the equilibration step. These are usually overriden by the values :ref:`Si in the experiments sheet<experiments_Si>`

.. _compound_isconstant:

- **!IsConstant** - assigns a binary value, either TRUE or FALSE, depending on whether the value of a particular compound should stay constant throughout the simulations. Note that the input compound should remain constant.

.. _compound_assignment:

- **!Assignment** - assigns a binary value, either TRUE or FALSE.

.. _compound_interpolation:

- **!Interpolation** -

.. _compound_type:

- **!Type** - Type of the reaction, e.g. "kinetic".

.. _compound_location:

- **!Location** - Compartment in which a particular compound is present.

.. _reaction:

Reaction
--------

.. _reaction_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "R" followed by an integer, should start at 0.

.. _reaction_name:

- **!Name** - Reaction name. Must start with a letter and it is advisable to include the reaction index, e.g. ReactionFlux0.

.. _reaction_kineticLaw:

- **!KineticLaw** - Reaction kinectic law. Needs to include the precise mass action kinetic law with compound and parameter names from corresponding SBtab table. For a reaction 'A + B <=> A_B' with a forward reaction rate of kf_R0 and backward reaction rate of kr_R0 the formula would look like 'kf_R0*A*B-kr_R0*A_B'.

.. _reaction_isReversible:

- **!IsReversible** - Bollean identifying the reversibility of the reaction, it is TRUE for reversible and FALSE for irreversible reactions.

.. _reaction_location:

- **!Location** - Compartment in which a particular reaction is taking place.

.. _reaction_reactionformula:

- **!ReactionFormula** - Chemical formula of the reaction, should be written in the form 'A + B <= > A_B'.

.. _parameter:

Parameter
---------

.. _parameter_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "K" followed by an integer, should start at 0.

.. _parameter_name:

- **!Name** - Name of the parameter. We followed the convention of using 'kf' for forward reactions rates and 'kr' for reverese rates, followed by the :ref:`\reaction !ID<reaction_id>`, e.g. 'kf_R0'. These names can be arbitrary but they need to coincide with whatever is defined in the :ref:`Reaction kinectic law<reaction_kineticLaw>`

.. _parameter_unit:

- **!Unit** - The units of the parameter.

.. _parameter_value_default:

- **!DefaultValue** - Parameter value in linear space.

.. _parameter_value_lin:

- **!Value:linspace** - Parameter value in linear space.

.. _parameter_value:log2:

- **!Value:log2** - Parameter value in log base 2.

.. _parameter_value:log10:

- **!Value:log10** - Parameter value in log base 10.

.. _parameter_location:

- **!Location** - Compartment in which a particular parameter is governing a reaction.

.. _parameter_comment:

- **!Comment** - Could be any plain text , we used it as a handy way of determining which reaction the parameter is involved in. We advise to use the following syntax  'kf_AXB__A_B' and 'kr_AXB__A_B' for respectively forward and backward rates of a reaction 'A + B <= > A_B'.

.. _expression:

Expression
----------

Compounds which are defined by expressions.

.. _expression_id:

- **!ID** - Identifier code for the entries, it should consist of the letters "Ex" followed by an integer, should start at 0.

.. _expression_name:

- **!Name** - Name of the compound defined by the expresion.

.. _expression_formula:

- **!Formula** - Formula assigned to the compound, it should use the compound names used in the compound sheet and, if needed, constant names from the constant sheet.

.. _expression_unit:

- **!Unit** - Concentration unit for the Compound.

.. _expression_location:

- **!Location** - Compartment in which a particular compound is located.

.. _output:

Output
------

Compounds used as outputs in experimental data.

.. _output_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "Y" followed by an integer, should start at 0.

.. _output_name:

- **!Name** - Name used to identify the output compound, when an existing compound needs to be measured we usually use "compound_name"_out.

.. _output_errorName:

- **!ErrorName** - Name of the error of the output compound. It should start with 'SD' (referring to standard deviation) followed by the output ID, e.g. SD_Y0.

.. _output_errorType:

- **!ErrorType** - Type of error for the output compound, we have used 'abs+rel random noise (std)'.

.. _output_unit:

- **!Unit** - Concentration unit for the output compound.

.. _output_probDist:

- **!ProbDist** - Probability distribution type of the measured output in an experimental setting, e.g. 'normal'.

.. _output_location:

- **!Location** - Compartment in which a particular output compound is located.

.. _output_formula:

- **!Formula** - Formula that links the experimental measured output to the compounds in the model. Usually the experimental measurement corresponds to a sum of compounds existing in the model but ratios are also common.

.. _experiments:

Experiments
-----------

Each column corresponds to one experiment for which there is a separate sheet.

.. _experiments_id:

- **!ID** - Identifier code for the entries, it should consist of the letter "E" followed by an integer, should start at 0.

.. _experiments_name:

- **!Name** - Name used to identify the experiment, we advise using the the word 'Experiment' followed by the experiment index.

.. _experiments_output:

- **>Output** - Should list all the output :ref:`\!ID's<output_id>`, i.e. Y's followed by their indices and separated by commas.

.. _experiments_Si:

- **>S**\ :sub:`i`\ - List of the various compounds of the model that have starting amounts other than 0, the same :ref:`\!ID<compound_id>` as in the coumpound table should be used. 

In a model with 2 experiments and 5 compounds A,B,C,D,E with IDs S0,S1,S2,S3,S4 respectively

  - Experiment1 with compounds starting amounts  A=0,B=1,C=2,D=0,E=3
  - Experiment2 with compounds starting amounts  A=1,B=0,C=1,D=0,E=4

Four entries should be included as exemplified bellow:

    +-------------+-----+-----+-----+-----+
    |             | >S0 | >S1 | >S2 | >S4 |
    +-------------+-----+-----+-----+-----+
    | Experiment1 |  0  |  1  |  2  |  3  |
    +-------------+-----+-----+-----+-----+
    | Experiment2 |  1  |  0  |  1  |  4  |
    +-------------+-----+-----+-----+-----+
	
	Note that D/S3 is omitted because the starting value is 0 in all experiments.

.. _experiments_simTime:

- **!SimTime** - Simulation time for a particular experiment.

.. _experiments_normalize:

- **!Normalize** - Normalizations to be performed to the outputs are defined here.

.. _e:

E\ :sub:`i`\
------------

Corresponds to individual experiments. It should have the name of the experiment IDs used in the experiments sheet.

.. _e_id:

- **!ID** - Identifier code for the entries, it should consist of the letters "E\ :sub:`i`\T" followed by an integer, should start at 0.

.. _e_time:

- **!Time** - Time series data, this should include a list of all the time points during which the corresponding output data points were sampled.

.. _e_y:

- **`>Y**\ :sub:`i`\ - Compound to be measured, corresponds to the :ref:`\!ID<output_id>` of the output sheet. It should have the experimental (or simulated from another model) data.

.. _e_sd_y:

- **`SD_Y**\ :sub:`i`\ - Error of the compound to be measured, corresponds to the :ref:`\!ErrorName<output_errorName>` of the output sheet. It should have the experimental (or simulated from another model) data.

.. _ei:

E\ :sub:`i`\I
-------------

Corresponds to individual experiments. It should have the name of the experiment IDs used in the experiments sheet, with an i in between E and the experiment number.

.. _ei_id:

- **!ID** - Identifier code for the entries, it should consist of the letters "E\ :sub:`i`\IT" followed by an integer, should start at 0.

.. _ei_imput_time:

- **!Input\_Time\_S**\ :sub:`i`\ - Time series of the inputs to the model, this should include a list of all the time points during which the corresponding input data points were sampled. To produce simple step inputs, only the time points during which a change in concentration is happening can be included. To produce more complicated input curves, more time points are needed to represent the shape of the curve.

.. _ei_s:

- **`>S**\ :sub:`i`\ - Compound that is being changed as input to the model, corresponds to the :ref:`\!ID<compound_id>` in the compound table. This column should represent the sampled concentration data points corresponding to each time point.
