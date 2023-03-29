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

Reads information from the SBtab and saves the model in MATLAB (:ref:`.mat<model.mat>`, :ref:`.sbproj<model.sbproj>`) and SBML(:ref:`.xml<model.xml>`) format, while also creating a
:ref:`file<data.mat>` whith the data to run the model in all different experimental settings defined in the SBtab.

- **Inputs** - :ref:`stg<stg>`, sb
- **Saves** - :ref:`model file .mat<model.mat>`, :ref:`model file .sbproj<model.sbproj>`, :ref:`model file .xml<model.xml>`, and :ref:`data file<data.mat>`

.. _f_setup_input:

f_setup_input
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_setup_input.m
 	   :linenos:
	   :language: matlab

Creates code that loads the inputs of each experiment into a :ref:`.mat file<input.mat>` and
the code to read these inputs at runtime when the experiments are being simulated. All
this generated code is stored on the :ref:`"Model/'model folder name'/Formulas"<files_functions>` folder.

- **Inputs** - :ref:`stg<stg>`
- **Saves** - :ref:`model-specific functions<files_functions>`

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