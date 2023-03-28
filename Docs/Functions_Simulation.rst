.. _functions_simulation:

Simulation and Scoring
======================

.. _f_sim_score:

f_sim_score
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_sim_score.m
 	   :linenos:
	   :language: matlab

This function, f_sim_score, calculates the total score of a given model by simulating the model and scoring its performance. The function takes three input arguments: parameters, stg, and model_folders. The output of the function includes the total score (score), the result of the simulation and scoring (rst), and the result of the simulation and scoring without the 'simd' field (rst_not_simd).

- **Inputs** 

  - :ref:`stg<stg>` - Structure containing the settings and configurations for the simulation and scoring process.
  - parameters - Double containing the model's parameters that are necessary for the simulation.
  - model_folders: Structure containing the paths to the folders where the model and other relevant files are stored.
   
- **Outputs**

  - score - :ref:`rst.st<rst.st>` Scalar value representing the total score of the model's performance.
  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`, :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, and :ref:`rst.st<rst.st>` Structure containing the results of the simulation and scoring process.
  - rst_not_simd - :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, and :ref:`rst.st<rst.st>` Structure containing the results of the simulation and scoring process with the 'simd' field removed.
	
- **Calls** 

  - f_prep_sim_  This function simulates the model using the provided parameters, settings, and model folders.
  - f_score_ This function calculates the score of the model based on the results of the simulation.

.. _f_prep_sim:

f_prep_sim
^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_prep_sim.m
 	   :linenos:
	   :language: matlab

The code defines a main function **f_prep_sim** and three additional helper functions **update_thermo_constrained_multiplications**, **update_thermo_constrained_divisions**, and **f_sim**. The main function f_prep_sim prepares the parameters for a simulation, setting default values and updating any parameters being tested. It also adjusts the parameters according to thermodynamic constraints.

The main function f_prep_sim takes the following inputs:

- **parameters**: parameters for the simulation
- **:ref:`stg<stg>`**: settings for the simulation
- **model_folders**: folder paths for the models

And it outputs :

- **rst**: results of the simulation

The function initializes several persistent variables, imports data on the first run, and sets the default parameters for the simulation.

The function checks if the parameters need to be updated for Profile Likelihood.

It iterates through all model parameters, updating tested parameters and thermodynamic constrained parameters accordingly.

The function initializes the start amount for the species in the model to 0 and sets up a loop for each experiment being run.

Within the loop, the function tries to simulate the model, performing several checks and updates. If an error occurs during the simulation, the function catches the error and sets the simulation output to 0, indicating the simulation did not work properly.

The helper functions **update_thermo_constrained_multiplications** and **update_thermo_constrained_divisions** update the parameters according to the thermodynamic constraints. They iterate through parameters that need to be multiplied or divided, respectively, and make the appropriate adjustments.

The helper function **f_sim** runs simulations using SimBiology models for a set of experiments. It takes the following inputs:

- **experiment_idx**: indices of experiments to run
- **settings**: simulation settings
- **simulation_parameters**: parameter values for simulations
- **species_start_amount**: start amounts for species in simulations
- **results**: output variable to save simulation results
- **main_model_folders**: paths for model files

It outputs:

- **results**: simulation results

The function **f_sim** maintains the state of the loaded models between calls using persistent variables, loads the appropriate models, compiles the code for the simulation run, substitutes the start amounts of species and parameter values based on real-time results, and runs the simulation.

The simulation results are saved in the output variable, and the function can be called multiple times for different experiments. The function checks if the times of the simulation output and the simulation data from SBTAB match. If they do not match, it sets the simulation output to 0, indicating that the simulation did not work properly.

In summary, the main function **f_prep_sim** prepares the parameters for a simulation by setting them to the default values and then updating any parameters being tested. It adjusts the parameters according to any thermodynamic constraints and iterates through all the experiments to be run. The function then calls the helper function **f_sim** to run the simulation using SimBiology models for the set of experiments. The simulation results are saved in the output variable, and any errors encountered during the simulation are caught and handled appropriately.

.. _f_sim:

f_sim
^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_sim.m
 	   :linenos:
	   :language: matlab

Description
-----------

Simulates the model with the provided configurations.
The first time it is run it loads a representation of the model and the simulation, and compiles this information to C code.

**Input Arguments**

  - exp_n - (double) Unique number to identify the model for each experiment or equilibrium reaction (it needs a new model object for each one)
  - :ref:`stg<stg>` - :ref:`stg.expn<stg.expn>`, :ref:`stg.name<stg.name>`, :ref:`stg.sbioacc<stg.sbioacc>`
	
  - rt
  
    - rt.ssa - (double) steady state amounts
    - rt.par - (double) All parameters of the model, takes the default ones from SBtab and then replaces the ones being worked on.
	
  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
  
**Output Arguments**

  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
	
**Functions called** - `Sbioaccelerate <https://www.mathworks.com/help/simbio/ref/sbioaccelerate.html>`_, `Sbiosimulate <https://www.mathworks.com/help/simbio/ref/sbiosimulate.html>`_
**Loaded variables** - :ref:`Ready to run model<rr_model.mat>`, :ref:`Ready to run model equilibration<rr_model_eq.mat>`

.. _f_score:

f_score
^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_score.m
 	   :linenos:
	   :language: matlab

Description
-----------

The ``f_score`` function computes the score for a given set of simulated results by comparing them with the experimental data. The function calculates the score for each dataset and experiment, and then computes the total score based on the selected scoring strategy. The score serves as a metric for comparing the accuracy of different simulations or models.

**Input Arguments**

- :ref:`rst<rst>`: Structure containing the simulation results and scores.
- :ref:`stg<stg>`: Structure containing the settings for the scoring strategy, such as the option to use log10 scaling, error score, and other options.
- mmf: Structure containing the model information, including the data model.

**Output Arguments**

- :ref:`rst.st<rst.st>`: Updated structure containing the calculated scores for each dataset, experiment, and the total score.

Example
-------

.. code-block:: matlab

   % Define the input structures and settings
   stg.useLog = 1;
   stg.errorscore = 1e10;
   stg.exprun = 1:3;
   mmf.model.data.data_model = matlab model file
   rst.simd = matlab output from f_prep_sim

   % Call the f_score function
   rst = f_score(rst, stg, mmf);

This example demonstrates how to call the ``f_score`` function with the input structures and settings. The function calculates the scores for the given simulation results based on the scoring strategy defined in the :ref:`stg<stg>` structure.


.. _f_normalize:

f_normalize
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_normalize.m
 	   :linenos:
	   :language: matlab

Description
-----------

The f_normalize function processes and normalizes simulation results based on a specified normalization method. It accepts a set of inputs, including the simulation results, settings, experiment and output numbers, and a model metafile structure. The function returns normalized simulation results, along with detailed normalized simulation results if the 'simdetail' setting is enabled.

**Input Arguments**

- :ref:`rst<rst>`: A structure containing the simulation results.
- :ref:`stg<stg>`: A structure containing the settings for the simulation.
- exp_number: An integer representing the experiment number.
- output_number: An integer representing the output number.
- mmf: A structure containing the model metafile information.

**Output Arguments**

- sim_results: A matrix containing the normalized simulation results.
- sim_results_detailed: A matrix containing the detailed normalized simulation results (if stg.simdetail is true).