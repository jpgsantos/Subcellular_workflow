.. _functions_import:

Setup and Import 
----------------

.. _f_load_settings:

f_load_settings
^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_load_settings.m
		:linenos:
		:language: matlab
		
It prompts the user to choose the model to run, the settings file to use, and the Analysis to perform.

- **Outputs** - :ref:`stg<stg>`, :ref:`rst<rst>`, :ref:`sb<sb>`,Analysis_n


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
this generated code is stored on the "Model/:ref:`«model folder name»<stg.folder_model>`/Formulas" folder.

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