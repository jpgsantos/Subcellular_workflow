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
