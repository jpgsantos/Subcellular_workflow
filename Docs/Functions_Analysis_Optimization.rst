Optimization
============

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
- **Calls** - `fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html>`_, :ref:`f_sim_score<f_sim_score>`, f_opt_start_
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
- **Calls** - `simulannealbnd <https://www.mathworks.com/help/gads/simulannealbnd.html>`_, :ref:`f_sim_score<f_sim_score>` , f_opt_start_
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
- **Calls** - `patternsearch <https://www.mathworks.com/help/gads/patternsearch.html>`_, :ref:`f_sim_score<f_sim_score>`, f_opt_start_
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
- **Calls** - `ga <https://www.mathworks.com/help/gads/ga.html>`_, :ref:`f_sim_score<f_sim_score>`, f_opt_start_
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
- **Calls** - `particleswarm <https://www.mathworks.com/help/gads/particleswarm.html>`_, :ref:`f_sim_score<f_sim_score>`, f_opt_start_
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
- **Calls** - `Surrogateopt <https://www.mathworks.com/help/gads/surrogateopt.html>`_, :ref:`f_sim_score<f_sim_score>`, f_opt_start_
- **Loads**