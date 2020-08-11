.. _functions_simulation:

Simulation
----------

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

Prepares the simulation making sure that an equilibration is preformed when necessary before running the main simulation.

- **Inputs**

  - :ref:`stg<stg>` - :ref:`stg.folder_model<stg.folder_model>`, :ref:`stg.name<stg.name>`, :ref:`stg.partest<stg.partest>`, :ref:`stg.tci<stg.tci>`, :ref:`stg.tcm<stg.tcm>`, :ref:`stg.tcd<stg.tcd>`, :ref:`stg.exprun<stg.exprun>`, :ref:`stg.simcsl<stg.simcsl>`, :ref:`stg.expn<stg.expn>`
  - parameters - (double) Set of parameters that we are working on
  
- **Created Variables**

  - rt
  
    - rt.ssa - (double) steady state amounts
    - rt.par - (double) All parameters of the model, takes the default ones from SBtab and then replaces the ones being worked on.
	
- **Outputs**

  - :ref:`rst<rst>` - :ref:`rst.simd<rst.simd>`
	
- **Calls** - f_sim_
- **Loads** - :ref:`data.mat<data.mat>`, :ref:`model.mat<model.mat>`

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
  - :ref:`stg<stg>` - :ref:`stg.expn<stg.expn>`, :ref:`stg.folder_model<stg.folder_model>`, :ref:`stg.name<stg.name>`, :ref:`stg.sbioacc<stg.sbioacc>`
	
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
  - :ref:`stg<stg>` - :ref:`stg.folder_model<stg.folder_model>`, :ref:`stg.name<stg.name>`, :ref:`stg.exprun<stg.exprun>`, :ref:`stg.useLog<stg.useLog>`  
	
- **Outputs**

  - :ref:`rst.st<rst.st>` - :ref:`rst.xfinal<rst.xfinal>`, :ref:`rst.sd<rst.sd>`, :ref:`rst.se<rst.se>`, :ref:`rst.st<rst.st>`
	
- **Calls**
- **Loads** - :ref:`data.mat<data.mat>`