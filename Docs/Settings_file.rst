﻿.. _stg:
.. _f_settings:

Settings file
=============

| A place for the user to define all the relevant properties of model simulation that are not stored in SBtab. This are usually things that need to change during optimizations or model development.

| These settings files can be found can be found on the respective model repository in the directory "Matlab/Settings", in the example model from our main repository in the directory "Matlab/model/Model_Example/Matlab/Settings", or by following these links:
	
    - `Example model settings files <https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab/Model/Model_Example/Matlab/Settings>`_
    - `Fujita_2010 model settings files <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Settings>`_
    - `Nair_2016 model settings files  <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Settings>`_
    - `Viswan_2018 model settings files  <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Settings>`_

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: matlab
		 
  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: matlab
		 
.. _stg.imp:

Import
------

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Import
         :end-before: %% Analysis	  
		 
  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Import
         :end-before: %% Analysis		 

  .. _stg.import:
  
- **stg.import** - (logical) Decide whether to run import functions

  .. _stg.sbtab_excel_name:

- **stg.sbtab_excel_name** - (string) Name of the Excel file with the SBtab

  .. _stg.name:

- **stg.name** - (string) Name of the model

  .. _stg.cname:

- **stg.cname** - (string) Name of the default model compartment

  .. _stg.sbtab_name:

- **stg.sbtab_name** - (string) Name of the SBtab saved in .mat format

.. _stg.analysis:

Analysis
--------

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Analysis
         :end-before: %% Simulation	
		 
  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Analysis
         :end-before: %% Simulation	
		 
  .. _stg.exprun:

- **stg.exprun** - (double) Experiments to run

  .. _stg.useLog:

- **stg.useLog** - (double) Choice between 0,1,2 and 3 to change either and how to apply log10 to the scores, check :ref:`results<rst>`:

  .. _stg.optmc:

- **stg.optmc** - (logical) Decide whether to use multicore everywhere it is available  
  
  .. _stg.rseed:

- **stg.rseed** - (double) Choice of random seed

  .. _stg.simcsl:

- **stg.simcsl** - (logical) Decide whether to display simulation diagnostics in the console

  .. _stg.optcsl:

- **stg.optcsl** - (logical) Decide whether to display optimization results on console 

  .. _stg.save_results:

- **stg.save_results** - (logical) Decide whether to save results

  .. _stg.simdetail:

- **stg.simdetail** - (logical) Decide whether to run detailed simulation for plots

  .. _stg.sim:

Simulation
----------

  .. toggle-header::
      :header: **Default settings code**
     
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Simulation
         :end-before: %% Model
			 
  .. toggle-header::
      :header: **Example settings code**
     
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Simulation
         :end-before: %% Model
			 
  .. _stg.maxt:
  
- **stg.maxt** - (double) Maximum time for each individual function has to run in seconds

  .. _stg.eqt:

- **stg.eqt** - (double) Equilibration time in seconds

  .. _stg.dimenanal:

- **stg.dimenanal** - (logical) Decide whether to do Dimensional Analysis

  .. _stg.abstolscale:

- **stg.UnitConversion** - (logical) Decide whether to do Unit conversion

  .. _stg.UnitConversion:
  
- **stg.abstolscale** - (logical) Decide whether to do Absolute Tolerance Scaling

  .. _stg.reltol:

- **stg.reltol** - (double) Value of Relative tolerance

  .. _stg.abstol:

- **stg.abstol** - (double) Value of Absolute tolerance

  .. _stg.simtime:

- **stg.simtime** - (string) Time units for simulation

  .. _stg.sbioacc:

- **stg.sbioacc** - (logical) Decide whether to run `sbioaccelerate <https://www.mathworks.com/help/simbio/ref/sbioaccelerate.html>`_ (after changing this value you need to run “clear functions” to see an effect)

  .. _stg.abstolstepsize_eq:

- **stg.abstolstepsize_eq** - (double) Absolute tolerance step size for equilibration (if empty MATLAB\ |Reg| decides whats best)

  .. _stg.maxstep:

- **stg.maxstep** - (double) Max step size in the simulation (if empty MATLAB\ |Reg| decides what's best)

  .. _stg.maxstepeq:

- **stg.maxstepeq** - (double) Max step size in the equilibration (if empty MATLAB\ |Reg| decides whats best)

  .. _stg.maxstepdetail:

- **stg.maxstepdetail** - (double) Max step size in the detailed plots (if empty MATLAB\ |Reg| decides whats best)

  .. _stg.errorscore:

- **stg.errorscore** - (double) Default score when there is a simulation error, this is needed to keep the optimizations working.

.. _stg.model:

Model
-----

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Model
         :end-before: %% Diagnostics 
			 
  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Model
         :end-before: %% Diagnostics 
			 
  .. _stg.parnum:

- **stg.parnum** - (double) Number of parameters to optimize

  .. _stg.tci:

- **stg.tci** - (double) Index for the parameters that have thermodynamic constraints

  .. _stg.tcm:

- **stg.tcm** - (double) Parameters to multiply to the first parameter (in stg.partest_ to get to the correct thermodynamic constraint formula)

  .. _stg.tcd:

- **stg.tcd** - (double) Parameters to divide to the first parameter (in stg.partest_ to get to the correct thermodynamic constraint formula)

  .. _stg.lb:

- **stg.lb** - (double) Lower bound of all parameters

  .. math::

      stg.lb = \begin{bmatrix}
              lb_{1} & lb_{2} & ... & lb_{i}
          \end{bmatrix}

  - :math:`i =` Parameter index   

  .. _stg.ub:

- **stg.ub** - (double) Upper bound of all parameters

  .. math::
  
      stg.up = \begin{bmatrix}
              ub_{1} & ub_{2} & ... & ub_{i}
          \end{bmatrix}
		   
  - :math:`i =` Parameter index   

  .. _stg.diag:

Diagnostics
-----------

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Diagnostics
         :end-before: %% Plots

  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Diagnostics
         :end-before: %% Plots

  .. _stg.partest:
  
- **stg.partest** - (double) Choice of which parameters to work on, since depending on the task, not all SBtab parameters are worked on.
  k indices correspond to the parameters in the SBtab and numbers up to i correspond to the parameters in the work set. 
  This is the set that actually gets used for diagnostics, optimization, and sensitivity analyis.
  

  .. math::

      stg.partest_k = \begin{bmatrix}
              1_{k_1} & 2_{k_2} & ... & i_{k_{end}}
          \end{bmatrix}

  In our example model parameter 216 from the SBtab is parameter number 1 of the work set, parameter 217 from the SBtab is parameter number 2 of the work set, and successively.
		  
  .. math::

      stg.partest_{[216:227]} = \begin{bmatrix}
              1_{216} & 2_{217} & ... & 6_{221} & 1_{222} & 2_{223} & ... & 6_{227}
          \end{bmatrix}
		  
  .. _stg.pat:
  
- **stg.pat** - (double) Index(:math:`j`) of the parameter set to work on

  .. _stg.pa:

- **stg.pa** - (double) All the parameter sets
  
  .. math::

      stg.pa = \begin{bmatrix}
              x_{1,1} & x_{2,1} & ... & x_{i,1} \\
			  x_{1,2} & x_{2,2} & ... & x_{i,2} \\
			  ... & ... & ... & ... \\
			  x_{1,j} & x_{2,j} & ... & x_{i,j}
          \end{bmatrix}
		  
  .. _stg.bestpa:

- **stg.bestpa** - (double) Best parameter set found so far during optimization

  .. math::

      stg.bestx = \begin{bmatrix}
              bestx_{1} & bestx_{2} & ... & bestx_{i}
          \end{bmatrix}

  - :math:`x =` Parameters being worked on
  - :math:`i =` Index of Parameters being worked on
  - :math:`k =` Index of the parameters in SBtab
  - :math:`j =` Index of the Parameter set to work on
  
Plots
-----

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Plots
         :end-before: %% Sensitivity analysis

  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Plots
         :end-before: %% Sensitivity analysis
		 
  .. _stg.plot:

- **stg.plot** - (logical) Decide whether to plot results

  .. _stg.plotoln:

- **stg.plotoln** - (logical) Decide whether to use long names in the title of the output plots in f_plot_outputs.m

.. _stg.gsa:

Global Sensitivity Analysis (GSA)
---------------------------------

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Sensitivity analysis
         :end-before: %% Optimization 

  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Sensitivity analysis
         :end-before: %% Optimization 
		 		 
  .. _stg.sansamples:

- **stg.sansamples** - (double) Number of samples to use in GSA (in total (2+npars)*sansamples simulations will be performed, where npars are the number of parameters).

  .. _stg.sasubmean:

- **stg.sasubmean** - (logical) Decide whether to subtract mean before calculating :ref:`SI<rst.SA.SI>` and :ref:`STI<rst.SA.STI>`, see Halnes et al 2009.

  .. _stg.sasamplemode:

- **stg.sasamplemode** - (double) Choose the way you want to obtain the samples of the parameters for performing the GSA;

 0. Reciprocal (log uniform) distribution

  :math:`X_{i} \sim Reciprocal(a_{i},b_{i})`
  
    - :math:`i =` Parameter index 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`

  .. toggle-header::
       :header: Example distribution with :math:`a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_1.png

 1. Log normal distribution with μ corresponding to the best value for a parameter, as recieved from the optimization, and σ as :ref:`stg.sasamplesigma<stg.sasamplesigma>` truncated at the parameter bounds
 
  :math:`X_{i} \sim TruncatedLogNormal(μ_{i}, σ, a_{i}, b_{i})`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = bestx_{i}`
    - :math:`σ = stg.sasamplesigma` 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = 0.5, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_2.png

 2. same as 1 without truncation
 
  :math:`X_{i} \sim LogNormal(μ, σ)`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = bestx_{i}`
    - :math:`σ = stg.sasamplesigma` 
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = 0.5, σ = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_3.png

 3. Log normal distribution with μ corresponding to the mean of the parameter bounds and σ as :ref:`stg.sasamplesigma<stg.sasamplesigma>` but truncated at the parameter bounds
 
  :math:`X_{i} \sim TruncatedLogNormal(μ_{i}, σ, a_{i}, b_{i})`
  
    - :math:`i =` Parameter index   
    - :math:`μ_{i} = \frac{stg.lb_{i} + (stg.ub_{i} - stg.lb_{i})}{2}`
    - :math:`σ = stg.sasamplesigma` 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = \frac{a+(b-a)}{2}, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_4.png
  
 4. same as 3 without truncation.
 
  :math:`X_{i} \sim LogNormal(mu_{i}, σ)`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = \frac{stg.lb_{i} + (stg.ub_{i} - stg.lb_{i})}{2}`
    - :math:`σ = stg.sasamplesigma` 
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = \frac{a+(b-a)}{2}, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_5.png
  
  .. _stg.sasamplesigma:

- **stg.sasamplesigma** - (double) σ for creating the normal distribution of parameters to perform sensitivity analysis

  .. _stg.opt:

Optimization
------------

  .. toggle-header::
      :header: **Default settings code**
  
      .. literalinclude:: ../Matlab/Code/default_settings.m
         :linenos:
         :language: MATLAB
         :start-after: %% Optimization

  .. toggle-header::
      :header: **Example settings code**
  
      .. literalinclude:: ../Matlab/Model/Model_Example/Matlab/Settings/Example_model.m
         :linenos:
         :language: MATLAB
         :start-after: %% Optimization

  .. _stg.optt:

- **stg.optt** - (double) Time for the optimization in seconds (fmincon does not respect this time!!)

  .. _stg.popsize:

- **stg.popsize** - (double) Population size (for the algorithms that use populations)

  .. _stg.osm:

- **stg.osm** - (double) optimization start method, choose between

  #. Get a random starting parameter set or group of starting parameter sets inside the bounds
  
  #. Get a random starting parameter set or group of starting parameter sets near the best parameter set

  .. _stg.dbpa:

- **stg.dbpa** - (double) Distance from best parameter set to be used in :ref:`stg.osm<stg.osm>` method 2 

  .. _stg.mst:

- **stg.mst** - (logical) Decide whether to use one or multiple starting parameter sets for the optimization

  .. _stg.msts:

- **stg.msts** - (double) Number of starting parameter sets for the optimizations

  .. _stg.optplots:

- **stg.optplots** - (logical) Decide whether to display optimiazation plots (They aren't ploted if running the code in multicore)

  .. _stg.fmincon:

- **stg.fmincon** - (logical) Decide whether to run `fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html>`_ (no gradient in our models so this doesn't work very well, does not respect :ref:`time set for the optimization<stg.optt>`!!)

  .. _stg.fm_options:

- **stg.fm_options** - (optim.options.Fmincon) `Options for fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html#busog7r-options>`_

  .. _stg.sa:

- **stg.sa** - (logical) Decide whether to run `simulated annealing <https://www.mathworks.com/help/gads/simulannealbnd.html>`_

  .. _stg.sa_options:

- **stg.sa_options** - (optim.options.SimulannealbndOptions) `Options for simulated annealing <https://www.mathworks.com/help/gads/simulannealbnd.html#buy3g1g-options>`_

  .. _stg.psearch:

- **stg.psearch** - (logical) Decide whether to run `Pattern search <https://www.mathworks.com/help/gads/patternsearch.html>`_

  .. _stg.psearch_options:

- **stg.psearch_options** - (optim.options.PatternsearchOptions) `Options for Pattern search <https://www.mathworks.com/help/gads/patternsearch.html#buxdit7-options>`_

  .. _stg.ga:

- **stg.ga** - (logical) Decide whether to run `Genetic algorithm <https://www.mathworks.com/help/gads/ga.html>`_

  .. _stg.ga_options:

- **stg.ga_options** - (optim.options.GaOptions) `Options for Genetic algorithm <https://www.mathworks.com/help/gads/ga.html#mw_4a8bfdb9-7c4c-4302-8f47-d260b7a43e26>`_

  .. _stg.pswarm:

- **stg.pswarm** - (logical) Decide whether to run `Particle swarm <https://www.mathworks.com/help/gads/particleswarm.html>`_

  .. _stg.pswarm_options:

- **stg.pswarm_options** - (optim.options.Particleswarm) `Options for Particle swarm <https://www.mathworks.com/help/gads/particleswarm.html#budidgf-options>`_

  .. _stg.sopt:

- **stg.sopt** - (logical) Decide whether to run `Surrogate optimization <https://www.mathworks.com/help/gads/surrogateopt.html>`_

  .. _stg.sopt_options:

- **stg.sopt_options** - (optim.options.Surrogateopt) `Options for Surrogate optimization <https://www.mathworks.com/help/gads/surrogateopt.html#mw_fa3519af-f062-41df-af65-c65ea7a54eb6>`_

Automatically generated at Import
---------------------------------

  .. _stg.expn:
  
- **stg.expn** - (double) Total number of experiments stored in the SBtab

  .. _stg.outn:
  
- **stg.outn** - (double) Total number of experimental outputs specified in the SBtab

References
----------
  
`Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.
<https://doi.org/10.1007/s10827-009-0162-6>`_