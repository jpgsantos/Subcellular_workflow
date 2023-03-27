.. _functions_simulation:

Simulation and Scoring
----------------------

.. _f_sim_score:

f_sim_score
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_sim_score.m
 	   :linenos:
	   :language: matlab

Calls the function that runs the simulations and the function that scores the output of the runs.

- **Inputs** 

  - :ref:`stg<stg>`
  - parameters - (double) Set of parameters that we are working on
  
- **Outputs**

  - score - :ref:`rst.st<rst.st>`
  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`, :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, and :ref:`rst.st<rst.st>`
  - rst_not_simd - :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, and :ref:`rst.st<rst.st>`
	
- **Calls** - f_prep_sim_, f_score_
- **Loads**

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
- **stg**: settings for the simulation
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

Simulates the model with the provided configurations.
The first time it is run it loads a representation of the model and the simulation, and compiles this information to C code.


- **Inputs**

  - exp_n - (double) Unique number to identify the model for each experiment or equilibrium reaction (it needs a new model object for each one)
  - :ref:`stg<stg>` - :ref:`stg.expn<stg.expn>`, :ref:`stg.name<stg.name>`, :ref:`stg.sbioacc<stg.sbioacc>`
	
  - rt
  
    - rt.ssa - (double) steady state amounts
    - rt.par - (double) All parameters of the model, takes the default ones from SBtab and then replaces the ones being worked on.
	
  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
  
- **Outputs**

  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
	
- **Calls** - `Sbioaccelerate <https://www.mathworks.com/help/simbio/ref/sbioaccelerate.html>`_, `Sbiosimulate <https://www.mathworks.com/help/simbio/ref/sbiosimulate.html>`_
- **Loads** - :ref:`Ready to run model<rr_model.mat>`, :ref:`Ready to run model equilibration<rr_model_eq.mat>`

.. _f_score:

f_score
^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Simulation/f_score.m
 	   :linenos:
	   :language: matlab

Uses the results from the simulation of the model and the Data provided via the SBTAB to calculate a score for a given parameter set.

- **Inputs**

  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
  - :ref:`stg<stg>` - :ref:`stg.name<stg.name>`, :ref:`stg.exprun<stg.exprun>`, :ref:`stg.useLog<stg.useLog>`  
	
- **Outputs**

  - :ref:`rst.st<rst.st>` - :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, :ref:`rst.st<rst.st>`
	
- **Calls**
- **Loads** - :ref:`data.mat<data.mat>`