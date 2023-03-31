.. _functions_import:

Setup and Import 
----------------

.. _f_user_input:

f_user_input
^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_user_input.m
		:linenos:
		:language: matlab

In this code, the main function ``f_user_input`` is responsible for processing user inputs related to model folder, analysis options, and settings file. Based on these inputs, the function returns the necessary settings, results, and SBtab data.

**Inputs**:

- mmf: a struct containing the main folder path.
- analysis_options: an array containing the available analysis options.
- user_choices: a cell array containing user inputs for the model folder, analysis option, and settings file.

**Outputs**:

- settings: a struct containing the necessary settings for the chosen analysis.
- results: a struct containing the results (if any) of the chosen analysis.
- sbTab: a struct containing the SBtab data (if any) associated with the chosen analysis.

The main function relies on several helper functions to process the user input, update settings, and handle user choices.

1. ``apply_settings``: This function updates the settings based on the chosen settings file, and checks if any changes have been made to the settings file or SBtab since the last analysis.

   **Inputs**: settings, settings_folder, settings_file_text, last_settings_file_date, last_settings_file_text, analysis_options, analysis_text, specific_model_folder, functions_cleared

   **Outputs**: settings, last_settings_file_text, last_settings_file_date

2. ``getValidInput``: This function validates the user input for the model folder, settings file, and analysis option, and returns the valid input.

   **Inputs**: options, user_choice, input_type

   **Outputs**: valid_input

3. ``choose_options``: This function helps the user to choose valid options from available choices in a folder.

   **Inputs**: folder, prompt, last_choice

   **Outputs**: choice, last_choice

4. ``parse_choices``: This function presents a list of choices to the user, validates their input, and returns the chosen option.

   **Inputs**: prompt, options, last_choice

   **Outputs**: choice, last_choice

5. ``compare_and_update``: This function compares the current and previous values, and clears functions if necessary.

   **Inputs**: current, previous, is_cleared

   **Outputs**: previous, is_cleared

The main function starts by initializing the results, settings, and sbTab variables, and setting the model folder paths. It then calls the ``getValidInput`` function to obtain valid user input for the model folder and analysis option. Depending on the user's chosen analysis option, the code proceeds differently. For analysis options 1-5 and 8, the ``apply_settings`` function is called to update the settings. For analysis options 6-7, the function loads the settings file and SBtab struct from a previous analysis, and processes the user input accordingly. Finally, the chosen model folder is set in the settings struct, and the function returns the updated settings, results, and sbTab data.

.. _f_import:

f_import
^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_import.m
		:linenos:
		:language: matlab

Creates the necessary folders inside the model folder. Calls subfunctions that convert the SBtab from an Excel into MATLAB\ |Reg| files useful for the workflow, TSVs and a SBML.

.. _f_excel_sbtab_importer:

f_excel_sbtab_importer
^^^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_excel_sbtab_importer.m
		:linenos:
		:language: matlab

Loads the information in the SBtab and creates a :ref:`. mat file<sbtab.mat>` that contains the sbtab and :ref:`TSVs<sbtab.tsv>` corresponding to all the SBtab tabs.

- **Inputs** - :ref:`stg<stg>`
- **Saves**

  - :ref:`.mat file containing the SBtab<sbtab.mat>` in the "Model/Data" folder
  - :ref:`TSVs containing the SBtab<sbtab.tsv>` in the "Model/tsv" folder

.. _f_generate_sbtab_struct:

f_generate_sbtab_struct
^^^^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_generate_sbtab_struct.m
		:linenos:
		:language: matlab

Loads the SBtab saved in the :ref:`.mat file<sbtab.mat>` and creates a MATLAB\ |Reg| struct that can be more easily parsed.

- **Inputs** - :ref:`stg<stg>`
- **Outputs** - sb, :ref:`stg.expn<stg.expn>`, :ref:`stg.outn<stg.outn>`.

.. _f_sbtab_to_model:

f_sbtab_to_model
^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_sbtab_to_model.m
 	   :linenos:
	   :language: matlab

This function, f_sbtab_to_model, converts an SBtab data structure into a model format that can be used for simulations and analysis. It then saves the model in .mat, .sbproj, and .xml formats for future use. The function also processes experimental settings defined in the SBtab data structure, adding compartments, species, parameters, reactions, expressions, inputs, constants, and boundary conditions to the model.

**Inputs**

- :ref:`stg<stg>`: A structure containing the settings for the model conversion.
- **sb**: An SBtab data structure containing the model data.
- **mmf**: A structure containing the file names for saving the model in different formats.

**Outputs**

The function saves the generated model in :ref:`.mat<model.mat>`, :ref:`.sbproj<model.sbproj>`, and SBML(:ref:`.xml<model.xml>`) formats.

**Functions called:**

- **addcompartment**: Adds a compartment to the SimBiology model object.
- **addspecies**: Adds a species to a specific compartment within the model.
- **addparameter**: Adds a parameter to the model, including its value, unit, and associated notes.
- **find_compartment_number**: Locates the index of the compartment based on its name within the compobj cell array.
- **add_reactions_to_model**: Adds reactions to the model by processing the reaction-related data in the SBtab data structure.
- **set_boundary_Condition**: Sets the boundary conditions for the model using the information provided in the SBtab data structure.
- **add_expressions_to_model**: Adds algebraic expressions to the model using the information provided in the SBtab data structure.
- **add_inputs_to_model**: Adds input variables to the model using the information provided in the SBtab data structure.
- **add_constants_to_model**: Adds constant variables to the model using the information provided in the SBtab data structure.
- **process_experiments**: Processes experimental data from the SBtab data structure and returns the updated SBtab and a Data structure containing the processed experimental data.
- **sbiosaveproject**: Saves the SimBiology model object as an .sbproj file.
- **save:** Saves the SimBiology model object as a .mat file, and the experimental data as a separate .mat file.
- **sbmlexport**: Exports the SimBiology model object as an .xml file in the Systems Biology Markup Language (SBML) format.

**Loaded variables:**

- **modelobj**: A SimBiology model object.
- **compobj**: A cell array containing compartment objects.
- **sbtab.species**: A table containing species-related data.
- **sbtab.defpar**: A table containing default parameter-related data.
- **sbtab.sim_time**: A table containing simulation time data.
- **Data**: A structure containing processed experimental data.
- **sbproj_model, matlab_model, data_model, xml_model**: Variables for saving the model in :ref:`.sbproj<model.sbproj>`, :ref:`.mat<model.mat>`, SBML(:ref:`.xml<model.xml>`) formats, and the experimental data(:ref:`file<data.mat>`), respectively.

.. _f_setup_input:

f_setup_input
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_setup_input.m
 	   :linenos:
	   :language: matlab

The f_setup_input function is designed to generate code for loading experiment inputs into a .mat file and create code to read these inputs during the simulation of the experiments. The generated code is stored in the "Input_functions" folder.

   :param stg: A structure containing information about the simulation settings.
   :type stg: structure
   :param mmf: A structure containing information about the model, including the model data, main folder, and input functions.
   :type mmf: structure
   :return: This function creates input function files and an input creator function file in the "Input_functions" folder. The input functions are used to calculate input values based on the simulation time, while the input creator function is used to create input data from the sbtab.datasets.
   :rtype: None

   The function calls the following helper functions:

   * template1: Generates code for input functions.
   * template2: Generates code for the first input of the first experiment in the input creator function.
   * template3: Generates code for the rest of the inputs in the input creator function.

   The function loads the following variables:

   * matlab_model: Loaded from mmf.model.data.mat_model.
   * data_model: Loaded from mmf.model.data.data_model.
   * inp_model_data: Loaded from mmf.model.data.input_model_data.
   * Model_folder: Loaded from mmf.model.main.
   * model_input: Loaded from mmf.model.input_functions.input.
   * sbtab: Loaded from the data_model file.
   * modelobj: Loaded from the matlab_model file.

.. _f_build_model_exp:

f_build_model_exp
^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_build_model_exp.m
 	   :linenos:
	   :language: matlab

Creates two .mat files for each experiment, one for the :ref:`equilibrium simulation run<rr_model_eq.mat>` and one for the :ref:`proper simulation<rr_model.mat>`.
These files have all the added rules, species and parameters needed depending on the inputs and outputs specified on the SBtab.

- **Inputs** - :ref:`stg<stg>`, sb
- **Saves** - :ref:`Ready to run models<rr_model>`

Function: f_build_model_exp
Description: This function creates two .mat files for each experiment: one for the equilibrium simulation run and one for the proper run. The .mat files contain necessary rules, species, and parameters based on the inputs and outputs specified in the sbtab. The function also configures simulation settings for the equilibrium and proper simulation runs, processes output and input species, and saves the .mat files for each experiment.

Inputs:
- stg: A structure containing settings for the simulations
- sb: An sbtab structure containing information about experiments
- mmf: A model management framework structure containing the data and mat models

Outputs:
- .mat files for equilibrium and proper runs for each experiment

Called Functions:
- getconfigset
- copyobj
- set
- load
- save
- addspecies
- addrule
- addparameter
- addevent

Loaded Variables:
- data_model
- mat_model
- model_exp_eq
- model_exp_default
- model_exp_detail
- Data
- sbtab
- modelobj

Notes:
- The function has a loop that iterates through all experiments and saves the corresponding .mat files.

Usage example:

.. code-block:: matlab

	% Initialize stg, sb, and mmf structures
	stg = ...
	sb = ...
	mmf = ...

	% Call the f_build_model_exp function
	f_build_model_exp(stg, sb, mmf);

This will create .mat files for equilibrium and proper runs for each experiment based on the information provided in the stg, sb, and mmf structures.
The function f_build_model_exp processes the input structures stg, sb, and mmf to create .mat files for each experiment. The stg structure contains simulation settings such as time units, maximum wall clock, and tolerances. The sb structure contains information about the experiments, while the mmf structure contains data and mat models.

The function loads data from the data_model and mat_model files and initializes arrays for model_run and configsetObj. It then iterates through all experiments, configuring the simulation settings for both the equilibrium and proper simulation runs.

For each experiment, the function processes the output species, adding them to the model if they don't already exist and setting up the appropriate rules. It then processes the input species, adding them either as events or repeated assignments based on the input time.

Finally, the function saves the .mat files for each experiment, creating separate files for the equilibrium, proper (default), and detailed simulation runs.

Below is an example of how to use the function:

.. code-block:: matlab

	% Initialize stg, sb, and mmf structures with the appropriate data
	stg = ...
	sb = ...
	mmf = ...

	% Call the f_build_model_exp function to generate .mat files for each experiment
	f_build_model_exp(stg, sb, mmf);

After executing the function with the appropriate input structures, .mat files will be created for each experiment, which can then be used for further analysis or simulation runs.