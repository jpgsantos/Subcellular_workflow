Functions
=========

Model Specific
--------------

.. _f_settings:

:ref:`f_settings<stg>`
^^^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
	 
      .. toggle-header::
          :header: **All**
	  
          .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
             :linenos:
             :language: matlab	 
	 
      .. toggle-header::
          :header: **Import**
	  
          .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
             :linenos:
             :language: matlab
             :start-after: %% Import
             :end-before: %% Analysis
  	   
      .. toggle-header::
          :header: **Analysis**
	  
   	      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
   	         :linenos:
  	         :language: matlab
  	         :start-after: %% Analysis
  	         :end-before: %% Simulation	   
  	    
      .. toggle-header::
          :header: **Simulation**
         
          .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
             :linenos:
             :language: matlab
             :start-after: %% Simulation
             :end-before: %% Model
  	    
      .. toggle-header::
          :header: **Model**
	  
          .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
             :linenos:
             :language: matlab
             :start-after: %% Model
             :end-before: %% Diagnostics
      
      .. toggle-header::
          :header: **Diagnostics**
      
      	  .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
      	     :linenos:
             :language: matlab
             :start-after: %% Diagnostics
             :end-before: %% Plots
         
      .. toggle-header::
          :header: **Plots**
      
      	  .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
      	     :linenos:
             :language: matlab
             :start-after: %% Plots
             :end-before: %% Sensitivity analysis
         
      .. toggle-header::
          :header: **Sensitivity analysis**
      
      	  .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
      	     :linenos:
             :language: matlab
             :start-after: %% Sensitivity analysis
             :end-before: %% Optimization
         
      .. toggle-header::
          :header: **Optimization**
      
      	  .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
      	     :linenos:
             :language: matlab
             :start-after: %% Optimization

A place for the user to define all the relevant properties of model simulation that are not stored in SBTAB, usually things that need to change during optimizations or model development.

- **Inputs**
- **Outputs** - :ref:`stg<stg>`
- **Calls**
- **Loads**

Simulation
----------

.. _f_prep_sim:

f_prep_sim
^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_prep_sim.m
 	   :linenos:
	   :language: matlab


Prepares the simulation to be run making sure that an equilibration run is run every time it is needed before the main simulation run.

- **Inputs** - :ref:`stg<stg>`, parameters (parameter array that is going to be simulated)
- **Outputs** - :ref:`rst<rst>`
- **Calls** - f_sim_
- **Loads** - :ref:`data.mat<data.mat>`, :ref:`model.mat<model.mat>`

.. _f_score:

f_score
^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_score.m
 	   :linenos:
	   :language: matlab

Uses the results from the simulation of the model and the Data provided via the SBTAB to calculate a score for the parameter set.

- **Inputs** - :ref:`rst<rst>`, :ref:`stg<stg>`
- **Outputs** - :ref:`rst.st<rst.diag.st>` 
- **Calls**
- **Loads** - :ref:`data.mat<data.mat>`

.. _f_sim:

f_sim
^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_sim.m
 	   :linenos:
	   :language: matlab

First time it is run it creates an internal representation of the model and the simulation and compiles this information to C code.
Simulates the model with the provided configurations.

- **Inputs** - :ref:`stg<stg>`, rt, :ref:`rst<rst>`, number_exp(unique number to identify the model for each experiment or equilibrium reaction (it needs a new model object for each one))
- **Outputs** - :ref:`rst<rst>`
- **Calls** - `Sbioaccelerate <https://www.mathworks.com/help/simbio/ref/sbioaccelerate.html>`_, `Sbiosimulate <https://www.mathworks.com/help/simbio/ref/sbiosimulate.html>`_
- **Loads**

.. _f_sim_score:

f_sim_score
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_sim_score.m
 	   :linenos:
	   :language: matlab

Calls the function that runs the simulations and the function that scores the output of the runs in the correct order.

- **Inputs** - :ref:`stg<stg>`, parameters (parameter array that is going to be simulated)
- **Outputs** - :ref:`rst<rst>`
- **Calls** - f_prep_sim_, f_score_
- **Loads**

Analysis
--------

.. _f_analysis:

f_analysis
^^^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Analysis/f_analysis.m
		:linenos:
		:language: matlab

Main functions called from here

- **Inputs** - :ref:`stg<stg>`
- **Outputs** - :ref:`rst<rst>`
- **Calls** - :ref:`f_diagnostics<f_diagnostics>`, :ref:`f_opt<f_opt>`,
  :ref:`f_SA<f_SA>`
- **Loads**
- **Saves**

.. _f_diagnostics:

f_diagnostics
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/f_diagnostics.m
 	   :linenos:
	   :language: matlab

| Used to diagnose and understand the effects of different parameters to the model, it loads the user defined configurations, runs the model the specified number of time (depending on the number of experiments, or chosen experiments), calculates the scores of the error functions and plots relevant graphs for diagnosis.
| Useful to understand a result after having a good parameter set or to comparing different parameters sets, not to optimize for good parameters.

- **Inputs** - :ref:`stg<stg>`
- **Outputs** - :ref:`rst<rst>`
- **Calls** - f_plot_, f_sim_score_
- **Loads**

Optimization
------------

.. _f_opt:

f_opt
^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - f_opt_fmincon_, f_opt_sa_, f_opt_psearch_, f_opt_ga_, f_opt_pswarm_, f_opt_sopt_
- **Loads**

.. _f_opt_start:

f_opt_start
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_start.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls**
- **Loads**

.. _f_opt_fmincon:

f_opt_fmincon
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_fmincon.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html>`_, f_sim_score_, f_opt_start_
- **Loads**

.. _f_opt_sa:

f_opt_sa
^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_sa.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `simulannealbnd <https://www.mathworks.com/help/gads/simulannealbnd.html>`_, f_sim_score_ , f_opt_start_
- **Loads**

.. _f_opt_psearch:

f_opt_psearch
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_psearch.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `patternsearch <https://www.mathworks.com/help/gads/patternsearch.html>`_, f_sim_score_, f_opt_start_
- **Loads**

.. _f_opt_ga:

f_opt_ga
^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_ga.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `ga <https://www.mathworks.com/help/gads/ga.html>`_, f_sim_score_, f_opt_start_
- **Loads**

.. _f_opt_pswarm:

f_opt_pswarm
^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_pswarm.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `particleswarm <https://www.mathworks.com/help/gads/particleswarm.html>`_, f_sim_score_, f_opt_start_
- **Loads**

.. _f_opt_sopt:

f_opt_sopt
^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_sopt.m
 	   :linenos:
	   :language: matlab

- **Inputs** - :ref:`stg<stg>`
- **Outputs**
- **Calls** - `Surrogateopt <https://www.mathworks.com/help/gads/surrogateopt.html>`_, f_sim_score_, f_opt_start_
- **Loads**

Sensitivity Analysis
--------------------

.. _f_SA:

f_SA
^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/f_SA.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

.. _makeParSamplesFromRanges:

makeParSamplesFromRanges
^^^^^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/makeParSamplesFromRanges.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

.. _makeOutputSample:

makeOutputSample
^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/makeOutputSample.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

.. _calcSobolSaltelli:

calcSobolSaltelli
^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/calcSobolSaltelli.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

Import
------

f_import
^^^^^^^^

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Import/f_import.m
		:linenos:
		:language: matlab

- **Calls** - :ref:`f_excel_sbtab_importer<f_excel_sbtab_importer>`,
  :ref:`f_sbtab_to_model<f_sbtab_to_model>`, :ref:`f_settings<f_settings>`
- **Loads** - :ref:`data.mat<data.mat>`
- **Saves**

.. _f_excel_sbtab_importer:

f_excel_sbtab_importer
^^^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_excel_sbtab_importer.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

.. _f_sbtab_to_model:

f_sbtab_to_model
^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_sbtab_to_model.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

.. _f_build_model_exp:

f_build_model_exp
^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Import/f_build_model_exp.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**

Plots
-----

.. _f_plot:

f_plot
^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Plots/f_plot.m
 	   :linenos:
	   :language: matlab

The function that calls all the custom plot functions when appropriate
Plots diagnosis that are important to understand if everything is working as it was supposed, it , expected outputs, observed outputs and scores for the models and conditions specified.

- **Inputs** - :ref:`rst<rst>`, :ref:`stg<stg>`
- **Outputs**

   .. toggle-header::
       :header: **Figure Scores**
 
 	.. image:: ../Docs/Images/Scores_example.png
	
   Total scores and scores per dataset given the parameters specified in :ref:`stg.pa<stg.pa>`
   
   .. toggle-header::
       :header: **Code Figure Scores**
  
  	 .. literalinclude:: ../Matlab/Code/Plots/f_plot_scores.m
 		:linenos:
 		:language: matlab
		
   |
   
   .. toggle-header::
       :header: **Figure Inputs**
 
 	.. image:: ../Docs/Images/Inputs_example.png
	
   Checks inputs to the model
   
   .. toggle-header::
       :header: **Code Figure Inputs**
   
    	 .. literalinclude:: ../Matlab/Code/Plots/f_plot_inputs.m
 		:linenos:
 		:language: matlab
				
   |

   .. toggle-header::
       :header: **Figure Outputs**
 
 	.. image:: ../Docs/Images/Outputs_example.png
   
   Expected outputs, observed outputs
   
   .. toggle-header::
       :header: **Code Figure Outputs**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_outputs.m
          :linenos:
          :language: matlab
		  		
   | 

   .. toggle-header::
       :header: **Figure Input and Outputs per experiment**
 
 	.. image:: ../Docs/Images/Inputs_Outputs_example.png
	
   Combined figure of the inputs and outputs for each experiment, on the left side we have the inputs of the experiment and on the right side the outputs
   
   .. toggle-header::
       :header: **Code Figure Input and Outputs**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_in_out.m
          :linenos:
          :language: matlab
		  		
   | 
  
   .. toggle-header::
       :header: **Figure Sensitivity Analysis SI**
 
 	.. image:: ../Docs/Images/SA_SI_example.png

   SI

   .. toggle-header::
       :header: **Figure Sensitivity Analysis SIT**
	   
	.. image:: ../Docs/Images/SA_SIT_example.png

   SIT

   .. toggle-header::
       :header: **Figure Sensitivity Analysis SIT-SI**
	   
	.. image:: ../Docs/Images/SA_SIT-SI_example.png

   SIT-SI
   
   .. toggle-header::
       :header: **Code figures SA**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_SA_sensitivities.m
          :linenos:
          :language: matlab		 		  
	  
- **Calls**
- **Loads** - :ref:`data.mat<data.mat>`

.. _f_get_subplot:

f_get_subplot
^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Plots/f_get_subplot.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**