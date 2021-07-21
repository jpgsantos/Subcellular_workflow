.. _files:

Model files and folders 
=======================

| Here we have the file hierarchy of the models used in MATLAB\ |Reg| portion of our workflow.
| Some of these folders and files need to be user generated before running the code and some are automatic generated at runtimne, in the list below the former are identified as (u-gen) and the later as (a-gen)
| When importing one of our provided models the user should place the model folder inside the "Subcellular_workflow/Matlab/Model/" all this folders and files are relative to this folder.

* .. toggle-header::
      :header: **"Model Folder name"/ (u-gen)**
     
      Folder containing all the model files the model, we recomend using the same name as the repository name for the models we provide but there is no restrictions.

  .. _sbtab.xlsx:

  * .. toggle-header::
        :header: "Source_sbtab_name".xlsx (u-gen)
     
        Contains the SBtab in .xlsx format.

  * .. toggle-header::
        :header: **Matlab/** (u-gen)
     
        Folder containing all model files related to MATLAB\ |Reg|, the model is used in other softwares so here reside all the files that MATLAB\ |Reg| uses or generates
 
    * .. toggle-header::
          :header: **Data/** (a-gen)
       
          Folder containing the model in severall diferent formats relevant for the analysis and files contaning model metadata such as experimental inputs and outputs
  
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
       
          Folder containing the functions that are used at run time to give the correct input to all experiments
  
      * .. toggle-header::
            :header: "model name"_inputi_Ligand.mat (a-gen)
       
            These functions interpolate the input that is supposed to be given to the model at run time.
  	
      * .. toggle-header::
            :header: "model name"_input_creator.mat (a-gen)
       
            Creates the functions above for all experimental inputs.
  
    * .. toggle-header::
          :header: **Results/** (a-gen)
       
          Folder containing the results of the various possible Matlab analysis provided by our workflow
  
      * .. toggle-header::
            :header: **"Analysis name"/** (a-gen)
       
            Each analysis output is stored in its own folder, depending on the analysis run the the results can be saved in either a "Diagnostics", "Optimization" or "Sensitivity Analysis". An "Examples" folder is also provided with analysis that were pre-run by us.
  	
        * .. toggle-header::
              :header: **"date"/** (a-gen)
       
              The date and time of when the analysis was run, this is auto generated when an user choses to run any alysis.
  
          * .. toggle-header::
                :header: All_figures.fig (a-gen)
       
                All the plots generated by the analysis stored in a Matlab figure assembly
  		
          * .. toggle-header::
                :header: Analysis.mat (a-gen)
       
                All the data used as input to the analysis, saved as the SBtab and the setting fileconverted to a matlab structs called "sb" and "stg" respectively. And all the outputs generated by running the analysis saved also in a matlab struct called ":ref:`rst<rst>`" 
  		
          * .. toggle-header::
                :header: "Figure name".png (a-gen)
       
                 All the plots generated by the analysis stored individually as images
  		
    * .. toggle-header::
          :header: **Settings/** (u-gen)
       
          Folder containing the :ref:`settings file<stg>`
    
      * .. toggle-header::
            :header: "Settings file name" (u-gen)
       
            :ref:`Settings file<stg>` of the model. A place for the user to define all the relevant properties of model simulation that are not stored in SBtab. These are usually things that need to change during optimizations or model development.
  
  .. _sbtab.tsv:

  * .. toggle-header::
        :header: **tsv/** (a-gen)
     
        Folder containing the SBtab converted to .tsv files for each SBtab that as been run through one of our analysis.

    * .. toggle-header::
          :header: **"model name"** (a-gen)
     
          Contains the SBtab in .tsv format.		  
						
Description of the general terms:

| **"Model Folder name"** - Name of the folder containing the model files and folders. We recomend using the     same name as the repository name for the models we provide but there is no restrictions.
| **"Source_sbtab_name"** - Name of the SBtab provided by the user
| **"model name"** - Name given to the model in all the automatic generated model files, chosen in the :ref:`settings file<stg>`
| **"Settings file name"** - Name chosen by the user for the :ref:`settings file<stg>` of the model. By default we chose the same as the "model name".
| **"Analysis name"** - Depending on the analysis run the the results can be saved in either a ":ref:`Diagnostics<diag>`", ":ref:`Optimization<param_ext>`" or ":ref:`Sensitivity Analysis<gsa>`" folder. An "Examples" folder is also provided with analysis that were pre-run by us.
| **"date"** - The date and time of when the analysis was run, this is auto generated when an user choses to run any analysis.
| **"Figure name"** - Catch all for all description for the names of all the plots that are generated by our analysis.
