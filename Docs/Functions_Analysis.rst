.. _functions_analysis:

Analysis
========

.. _f_analysis:

f_analysis
----------

 .. toggle-header::
     :header: **Code**

     .. literalinclude:: ../Matlab/Code/Analysis/f_analysis.m
		:linenos:
		:language: matlab

The **f_analysis** function performs a specific analysis based on the given analysis options. It takes settings, analysis type, main model files, a list of possible analysis options, and a structure for storing analysis results as input arguments. The function outputs the results of the analysis and updates the settings as needed. The function calls the appropriate analysis functions (:ref:`f_diagnostics<f_diagnostics>`, :ref:`f_opt<f_opt>`, :ref:`f_sim_score<f_sim_score>`, :ref:`f_lsa<f_lsa>`, :ref:`f_gsa<f_gsa>`, :ref:`f_PL_m<f_PL_m>`) depending on the selected analysis type.

**Inputs**

- :ref:`stg<stg>`: Settings to use in the analysis.
- analysis: Type of analysis to be performed.
- mmf: Main model files.
- analysis_options: List of possible analysis options.
- rst: Structure for storing analysis results.

**Outputs**


- :ref:`rst<rst>`: Updated structure containing the results of the analysis.
- :ref:`stg<stg>`: Updated settings after the analysis.

**Usage**

.. code-block:: matlab

   [rst, stg] = f_analysis(stg, analysis, mmf, analysis_options, rst)

**Example**

.. code-block:: matlab

   settings = :ref:`stg<stg>`;
   analysis_type = 'diagnostics';
   model_files = 'path/to/model/files';
   options = ["Diagnostics","Parameter Estimation",...
    "Local Sensitivity Analysis","Global Sensitivity Analysis",...
    "Profile Likelihood Analysis","Reproduce a previous analysis",...
    "Reproduce the plots of a previous analysis","Import model files"];
   results = :ref:`stg<stg>`;

   [results, settings] = f_analysis(settings, analysis_type, model_files, options, results);


.. _diagnostics:

Diagnostics
-----------

.. _f_diagnostics:

f_diagnostics
^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/f_diagnostics.m
 	   :linenos:
	   :language: matlab

| Used to understand the effects of different parameters sets on model behaviour or in comparing different parameters sets.
| It loads the user defined configurations, performs all the needed simulations, and calculates scores of the error functions either per experimental output, per experiment, or in total (:ref:`check results<rst_diag>`).

- **Inputs**

  - :ref:`stg<stg>` - :ref:`stg.optmc<stg.optmc>` , :ref:`stg.pat<stg.pat>`
  
- **Outputs** - rst (:ref:`diagnostics results<rst_diag>`)

.. _opt:

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


Calls the correct optmizer or optimizers that have been chosen in the settings file.

- **Inputs**

  - :ref:`stg<stg>` - :ref:`stg.fmincon<stg.fmincon>`, :ref:`stg.sa<stg.sa>`, :ref:`stg.psearch<stg.psearch>`, :ref:`stg.ga<stg.ga>`, :ref:`stg.pswarm<stg.pswarm>`, :ref:`stg.sopt<stg.sopt>`

- **Outputs** - rst (:ref:`optimization results<rst_opt>`)

.. _f_opt_start:

f_opt_start
^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_start.m
 	   :linenos:
	   :language: matlab

| Creates the starting parameter set or sets of the optimizations, if single or multistart selected in settings file.
| It supports two different random distributions for the starting points. 

- **Inputs**

  - :ref:`stg<stg>` - :ref:`stg.rseed<stg.rseed>`, :ref:`stg.osm<stg.osm>`, :ref:`stg.msts<stg.msts>`, :ref:`stg.parnum<stg.parnum>`, :ref:`stg.ub<stg.ub>`, :ref:`stg.lb<stg.lb>`, :ref:`stg.popsize<stg.popsize>`, :ref:`stg.bestpa<stg.bestpa>`, :ref:`stg.dbpa<stg.dbpa>`

- **Outputs** 

  - spoint - (double) starting parameter set for the optimization
  - spop - (double) Starting parameter sets for multiple start optimizations

.. _f_opt_general:

f_opt_fmincon/sa/psearch/ga/pswarm/sopt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  .. toggle-header::
      :header: **Code**
  
      .. content-tabs::
      
          .. tab-container:: tab1
              :title: f_opt_fmincon
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_fmincon.m
             	    :linenos:
            	    :language: matlab
      
          .. tab-container:: tab2
              :title: f_opt_sa
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_sa.m
             	    :linenos:
            	    :language: matlab
      		
          .. tab-container:: tab3
              :title: f_opt_psearch
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_psearch.m
             	    :linenos:
            	    :language: matlab
      		   
          .. tab-container:: tab4
              :title: f_opt_ga
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_ga.m
             	    :linenos:
            	    :language: matlab	
      	   
          .. tab-container:: tab5
              :title: f_opt_pswarm
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_pswarm.m
             	    :linenos:
            	    :language: matlab	
      		   
          .. tab-container:: tab6
              :title: f_opt_sopt
      
             	 .. literalinclude:: ../Matlab/Code/Analysis/Optimization/f_opt_sopt.m
             	    :linenos:
            	    :language: matlab			   

These functions call built in MATLAB\ |Reg| functions that perform parameter optimization . 
For furher information relating to how these optimizers work please follow the links to the MATLAB\ |Reg| documentation.
Optimizers used:

 - f_opt_fmincon - `fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html>`_
 - f_opt_sa -  `Simmulated annealing <https://www.mathworks.com/help/gads/simulannealbnd.html>`_
 - f_opt_psearch -  `Pattern search <https://www.mathworks.com/help/gads/patternsearch.html>`_
 - f_opt_ga - `Genetic algorihtm <https://www.mathworks.com/help/gads/ga.html>`_
 - f_opt_pswarm - `Particle swarm <https://www.mathworks.com/help/gads/particleswarm.html>`_
 - f_opt_sopt - `Surrogate optmization <https://www.mathworks.com/help/gads/surrogateopt.html>`_

- **Inputs** - :ref:`stg<stg>`
- **Outputs** - :ref:`Optimization results<rst_opt>`	   

Global Sensitivity Analysis
---------------------------

.. _f_gsa:

f_gsa
^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/f_gsa.m
 	   :linenos:
	   :language: matlab

Calls the global sensitivity analysis functions in the correct order.

.. _f_make_par_samples:

f_make_par_samples
^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/f_make_par_samples.m
 	   :linenos:
	   :language: matlab

Creates parameter sets samples with :ref:`specific parameter distributions <stg.sasamplemode>` that are used to perform the global sensitivity analysis.

- **Inputs**

  - stg - :ref:`stg.sansamples<stg.sansamples>`, :ref:`stg.parnum<stg.parnum>`, :ref:`stg.sasamplemode<stg.sasamplemode>`, :ref:`stg.ub<stg.ub>`, :ref:`stg.lb<stg.lb>`
  
- **Outputs** - :ref:`M1<rst.SA.M1>`, :ref:`M2<rst.SA.M2>`, :ref:`N<rst.SA.N>`

*Code inspired by Geir Halnes et al. 2009 paper.*

.. _f_make_output_sample:

f_make_output_sample
^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/f_make_output_sample.m
 	   :linenos:
	   :language: matlab

For each parameter set given in the matrices :ref:`M1<rst.SA.M1>`, :ref:`M2<rst.SA.M2>`, and :ref:`N<rst.SA.N>`
it runs the function :ref:`f_sim_score<f_sim_score>` generating new matrices
:ref:`fM1<rst.SA.fM1>`, :ref:`fM2<rst.SA.fM2>`, and :ref:`fN<rst.SA.fN>`
respectively.

- **Inputs** - :ref:`M1<rst.SA.M1>`, :ref:`M2<rst.SA.M2>`, :ref:`N<rst.SA.N>`, :ref:`stg.sansamples<stg.sansamples>`, :ref:`stg.parnum<stg.parnum>`,
- **Outputs** - :ref:`fM1<rst.SA.fM1>`, :ref:`fM2<rst.SA.fM2>`, :ref:`fN<rst.SA.fN>`

*Code inspired by Geir Halnes et al. 2009 paper.*

.. _f_calc_sensitivities:

f_calc_sensitivities
^^^^^^^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Analysis/Sensitivity Analysis/f_calc_sensitivities.m
 	   :linenos:
	   :language: matlab

Takes the matrices :ref:`fM1<rst.SA.fM1>`, :ref:`fM2<rst.SA.fM2>`, and :ref:`fN<rst.SA.fN>` and calculates sensitivity indexes.
It calculates indexes based on the following :ref:`oputputs<rst_score>` of the :ref:`f_sim_score function<f_sim_score>`:

  - :ref:`The scores of each experimental output<rst.sd>`
  - :ref:`The scores of each experiment<rst.se>`
  - :ref:`The total score<rst.st>`
  - :ref:`The value of each experimental outputs at the end of the simulation<rst.xfinal>`

- **Inputs** - :ref:`fM1<rst.SA.fM1>`, :ref:`fM2<rst.SA.fM2>`, :ref:`fN<rst.SA.fN>`, :ref:`stg.sasubmean<stg.sasubmean>`
- **Outputs** - :ref:`SI<rst.SA.SI>`, :ref:`STI<rst.SA.STI>`

*Code modified from the Geir Halnes et al. 2009 paper.*

References
----------

`Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.
<https://doi.org/10.1007/s10827-009-0162-6>`_