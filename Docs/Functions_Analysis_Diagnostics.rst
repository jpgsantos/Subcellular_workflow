Diagnostics
===========

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