.. _files:

Model files and folders 
=======================

| Here we have the file hierarchy of the models used in MATLAB\ |Reg| portion of our workflow.
| Some of these folders and files need to be user generated before running the code and some are automatic generated at runtimne, in the list below the former are identified as (u-gen) and the later as (a-gen)
| When importing one of our provided models the user should place the model folder inside the "Subcellular_workflow/Matlab/Model/" all this folders and files are relative to this folder.

* .. toggle-header::
      :header: **"Model Folder name" (u-gen)**
     
      Placeholder description

  .. _sbtab.xlsx:

  * .. toggle-header::
        :header: "Source_sbtab_name".xlsx (u-gen)
     
        Contains the SBtab in .xlsx format.
  
  * .. toggle-header::
        :header: **Data/** (a-gen)
     
        Placeholder description

  .. _model.sbproj:

    * .. toggle-header::
          :header: model\_"model name".sbproj (a-gen)
     
          Contains the model derived from the SBtab in .sbproj (MATLAB\ |Reg| SimBiology\ |Reg|) format.	  
	
    .. _model.mat:

    * .. toggle-header::
          :header: model\_"model name".mat (a-gen)
     
          Contains the model derived from the SBtab in .mat format. 	  

    .. _data.mat:

    * .. toggle-header::
          :header: data\_"model name".mat (a-gen)
     
          Contains data derived from the SBtab in a .mat format. This data is used to run the model taking into account all the inputs and outputs of the model.	 

    .. _model.xml:

    * .. toggle-header::
          :header: model\_"model name".xml (a-gen)
     
          Contains the model derived from the SBtab in .xml (SBML) format. 	
	
    .. _input.mat:

    * .. toggle-header::
          :header: Input\_"model name".mat (a-gen)
     
          Contains input data derived from the SBtab in a .mat format for all the experimental inputs.  

    .. _sbtab.mat:

    * .. toggle-header::
          :header: SBtab\_"model name".mat (a-gen)
     
          Contains the SBtab in .mat format.

    .. _rr_model:

    * .. toggle-header::
          :header: **Exp/** (a-gen)
     
          Contains a version of the model for each experiment contained in the SBtab. They include all the neccessary inputs and outputs to simulate the supplied experimental conditions.
				
      .. _rr_model.mat:
				
      * .. toggle-header::
            :header: Model\_"model name"_\ :sub:`i`\.mat (a-gen)
     
            Tailor made for the main run of the simulation.

      .. _rr_model_eq.mat:

      * .. toggle-header::
            :header: Model\_eq\_"model name"_\ :sub:`i`\.mat (a-gen)
     
            Tailor made for the equilibration step of the simulation.
	  
      * .. toggle-header::
            :header: Model\_detail\_"model name"_\ :sub:`i`\.mat (a-gen)
     
            Tailor made for the main run of the simulation. The step size is reduced to generate better graphs

  .. _files_functions:

  * .. toggle-header::
        :header: **Input_functions/** (a-gen)
     
        Functions that are used at run time to give the correct input to all experiments

    * .. toggle-header::
          :header: "model name"_inputi_Ligand.mat (a-gen)
     
          These functions interpolate the input that is supposed to be given to the model at run time.
	
    * .. toggle-header::
          :header: "model name"_input_creator.mat (a-gen)
     
          Creates the previous functions for all experimental inputs.

  * .. toggle-header::
        :header: **Results/** (a-gen)
     
        Placeholder description

    * .. toggle-header::
          :header: **"Analysis name"/** (a-gen)
     
          Placeholder description
	
      * .. toggle-header::
            :header: **"date"/** (a-gen)
     
            Placeholder description

        * .. toggle-header::
              :header: All_figures.fig (a-gen)
     
              Placeholder description
		
        * .. toggle-header::
              :header: Analysis.mat (a-gen)
     
              Placeholder description
		
        * .. toggle-header::
              :header: "Figure name".png (a-gen)
     
              Placeholder description	
		
  * .. toggle-header::
        :header: **Settings/** (u-gen)
     
        Placeholder description
  
    * .. toggle-header::
          :header: "Settings file name" (u-gen)
     
          A place for the user to define all the relevant properties of model simulation that are not stored in SBtab. These are usually things that need to change during optimizations or model development.

  .. _sbtab.tsv:

  * .. toggle-header::
        :header: **tsv/** (a-gen)
     
        Placeholder description

    * .. toggle-header::
          :header: **"model name"** (a-gen)
     
          Contains the SBtab in .tsv format.		  
						
				
| "Model Folder name" - Placeholder description
| "Source_sbtab_name" - Placeholder description
| "model name" - Placeholder description
| "Analysis name" - Placeholder description
| "date" - Placeholder description
| "Figure name" -  Placeholder description