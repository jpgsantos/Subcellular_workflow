.. _stg:
.. _f_settings:

Settings file
=============

A place for the user to define all the relevant properties of model simulation that are not stored in SBTAB, usually things that need to change during optimizations or model development.



  .. toggle-header::
      :header: **Code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab	 
	 

Import
------

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Import
         :end-before: %% Analysis	  

  .. _stg.import:
  
- **stg.import** - 0 or 1 to decide whether to run import functions

  .. _stg.folder_model:
  
- **stg.folder_model** - Name of the folder where everything related to the model is stored

  .. _stg.sbtab_excel_name:

- **stg.sbtab_excel_name** - Name of the excel file with the sbtab

  .. _stg.name:

- **stg.name** - Name of the model

  .. _stg.cname:

- **stg.cname** - Name of the default model compartment

  .. _stg.sbtab_name:

- **stg.sbtab_name** - Name of the sbtab saved in .mat format

Analysis
--------

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Analysis
         :end-before: %% Simulation	

	   
  .. _stg.analysis:

- **stg.analysis** - String with the analysis to be run, the options are "diag", "opt", "SA", they can be combined as for example "diag, opt", to not run any analysis set stg.analysis to equal to ""

  .. _stg.exprun:

- **stg.exprun** - Experiments to run

  .. _stg.useLog:

- **stg.useLog** - Choice between 0,1,2 and 3 to change either and how to apply log10 to the scores, check :ref:`results<rst>`:

  .. _stg.optmc:

- **stg.optmc** - 0 or 1 to decide whether to use multicore everywhere it is available  
  
  .. _stg.rseed:

- **stg.rseed** - Choice of ramdom seed

  .. _stg.simcsl:

- **stg.simcsl** - 0 or 1 to decide whether to use display simulation diagnostics in the console

  .. _stg.optcsl:

- **stg.optcsl** - 0 or 1 to decide whether to display optimization results on console 

  .. _stg.save_results:

- **stg.save_results** - 0 or 1 to decide whether to save results


Simulation
----------

  .. toggle-header::
      :header: **Example model code**
     
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Simulation
         :end-before: %% Model
			 
  .. _stg.maxt:
  
- **stg.maxt** - Maximum time for each individual function to run in seconds

  .. _stg.eqt:

- **stg.eqt** - Equilibration time

  .. _stg.dimenanal:

- **stg.dimenanal** - 0 or 1 to decide whether to do Dimensional Analysis

  .. _stg.abstolscale:

- **stg.UnitConversion** - 0 or 1 to decide whether to do Unit conversion

  .. _stg.UnitConversion:
  
- **stg.abstolscale** - 0 or 1 to decide whether to do Absolute Tolerance Scaling

  .. _stg.reltol:

- **stg.reltol** - Value of Relative tolerance

  .. _stg.abstol:

- **stg.abstol** - Value of Absolute tolerance

  .. _stg.simtime:

- **stg.simtime** - Time units for simulation

  .. _stg.sbioacc:

- **stg.sbioacc** - 0 or 1 to decide whether to run sbioaccelerate (after changing this value you need to run “clear functions” to see an effect)

  .. _stg.maxstep:

- **stg.maxstep** - Max step size in the simulation (if empty matlab decides whats best)

Model
-----

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Model
         :end-before: %% Diagnostics 
			 
  .. _stg.parnum:

- **stg.parnum** - Number of parameters to optimize

  .. _stg.tci:

- **stg.tci** - Index for the parameters that have thermodynamic constrains

  .. _stg.tcm:

- **stg.tcm** - Parameters to multiply to the first parameter (in Stg.ms.partest to get to the correct thermodynamic constrain formula)

  .. _stg.tcd*:

- **stg.tcd** - Parameters to divide to the first parameter (in Stg.ms.partest to get to the correct thermodynamic constrain formula)

  .. _stg.lb:

- **stg.lb** - Array with the lower bound of all parameters

  .. math::

      stg.lb = \begin{bmatrix}
              lb_{1} & lb_{2} & ... & lb_{i}
          \end{bmatrix}

  - :math:`i =` Parameter index   

  .. _stg.ub:

- **stg.ub** - Array with the upper bound of all parameters

  .. math::
  
      stg.up = \begin{bmatrix}
              ub_{1} & ub_{2} & ... & ub_{i}
          \end{bmatrix}
		   
  - :math:`i =` Parameter index   

Diagnostics
-----------

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Diagnostics
         :end-before: %% Plots

  .. stg.partest:
  
- **stg.partest** - Choice of what parameters in the array to test, the indices correspond to the parameters in the model
  SBTAB and the numbers correspond to the parameters in the work array (used for diagnostics, optimization, and Sensitivity
  analyis), usually not all parameters are optimized so there needs to be a match between one and the other.

  .. math::

      stg.partest_k = \begin{bmatrix}
              1_{k_1} & 2_{k_2} & ... & m_{k_i}
          \end{bmatrix}

  In our example model parameter 216 from the SBTAB is or parameter number 1, parameter 217 from the SBTAB is paramter number 2, and successively.
		  
  .. math::

      stg.partest_{[216:227]} = \begin{bmatrix}
              1_{216} & 2_{217} & ... & 6_{221} & 1_{222} & 2_{223} & ... & 6_{227}
          \end{bmatrix}
		  
  .. _stg.pat:
  
- **stg.pat** - Index(:math:`j`) of the Parameter array to test

  .. _stg.pa:

- **stg.pa** - All the parameter arrays, in the example model there is only one
  
  .. math::

      stg.pa = \begin{bmatrix}
              x_{1,1} & x_{2,1} & ... & x_{i,1} \\
			  x_{1,2} & x_{2,2} & ... & x_{i,2} \\
			  ... & ... & ... & ... \\
			  x_{1,j} & x_{2,j} & ... & x_{i,j}
          \end{bmatrix}
		  
  .. _stg.bestx:

- **stg.bestx** - Best parameter array found so far during optimization

  .. math::

      stg.bestx = \begin{bmatrix}
              bestx_{1} & bestx_{2} & ... & bestx_{i}
          \end{bmatrix}

  - :math:`i =` Index of Parameters being worked on
  - :math:`j =` Index of the Parameter array to test
  - :math:`k =` Index of the parameters in SBTAB
  - :math:`x =` Parameters being worked on

Plots
-----

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Plots
         :end-before: %% Sensitivity analysis

  .. _stg.plot:

- **stg.plot** - 0 or 1 to decide whether to plot results

  .. _stg.plotoln:

- **stg.plotoln** - 0 or 1 to decide whether to use long names in the title of the outputs plots in f_plot_outputs.m

Sensitivity Analysis (SA)
-------------------------

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Sensitivity analysis
         :end-before: %% Optimization 
		 
  .. _stg.sansamples:

- **stg.sansamples** - Number of samples to use in SA

  .. _stg.sasubmean:

- **stg.sasubmean** - 0 or 1 to decide whether to subtract mean before calculating SI and SIT

  .. _stg.sasamplemode:

- **stg.sasamplemode** - Choose the way you want to obtain the samples of the parameters for performing the SA;

 0. Reciprocal distribution truncated at the parameter bounds

  :math:`X_{i} \sim Reciprocal(a_{i},b_{i})`
  
    - :math:`i =` Parameter index 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`

  .. toggle-header::
       :header: Example distribution with :math:`a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_1.png

 #. Log normal distribution with μ as the best value for a parameter and σ as stg.sasamplesigma truncated at the parameter bounds
 
  :math:`X_{i} \sim TruncatedLogNormal(μ_{i}, σ, a_{i}, b_{i})`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = bestx_{i}`
    - :math:`σ = stg.sasamplesigma` 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = 0.5, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_2.png

 #. same as 1 without truncation
 
  :math:`X_{i} \sim LogNormal(μ, σ)`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = bestx_{i}`
    - :math:`σ = stg.sasamplesigma` 
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = 0.5, σ = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_3.png

 #. Log normal distribution centered at the mean of the parameter bounds and σ as stg.sasamplesigma truncated at the parameter bounds
 
  :math:`X_{i} \sim TruncatedLogNormal(μ_{i}, σ, a_{i}, b_{i})`
  
    - :math:`i =` Parameter index   
    - :math:`μ_{i} = \frac{stg.lb_{i} + (stg.ub_{i} - stg.lb_{i})}{2}`
    - :math:`σ = stg.sasamplesigma` 
    - :math:`a_{i} = stg.lb_{i}` 
    - :math:`b_{i} = stg.ub_{i}`
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = \frac{a+(b-a)}{2}, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_4.png
  
 #. same as 3 without truncation.
 
  :math:`X_{i} \sim LogNormal(mu_{i}, σ)`
  
    - :math:`i =` Parameter index 
    - :math:`μ_{i} = \frac{stg.lb_{i} + (stg.ub_{i} - stg.lb_{i})}{2}`
    - :math:`σ = stg.sasamplesigma` 
	
  .. toggle-header::
       :header: Example distribution with :math:`μ = \frac{a+(b-a)}{2}, σ = 1, a = -1, b = 1`
 
 	.. image:: ../Docs/Images/SA_Dist_5.png
  
  .. _stg.sasamplesigma:

- **stg.sasamplesigma** - σ for creating the normal distribution of parameters to perform sensitivity analysis


Optimization
------------

  .. toggle-header::
      :header: **Example model code**
  
      .. literalinclude:: ../Matlab/Model/D1_LTP_time_window/Settings/f_settings_all_TW.m
         :linenos:
         :language: matlab
         :start-after: %% Optimization

  .. _stg.optt:

- **stg.optt** - Time for the optimization in seconds (fmincon does not respect this time!!)

  .. _stg.popsize:

- **stg.popsize** - Population size (for the algorithms that use populations)

  .. _stg.osm:

- **stg.osm** - optimization start method, choose between

  #. Get a random starting point or group of starting points inside the bounds
  
  #. Get a random starting point or group of starting points near the best point

  .. _stg.dbs:

- **stg.dbs** - Distance from best point to be used in stg.osm method 2 

  .. _stg.mst:


- **stg.mst** - 0 or 1 to decide whether to use Multistart

  .. _stg.msts:

- **stg.msts** - Number of starting points for the optimizations

  .. _stg.optplots:

- **stg.optplots** - 0 or 1 to decide whether to display Plots (Plots doesn’t work if using multicore)

  .. _stg.fmincon:

- **stg.fmincon** - 0 or 1 to decide whether to run `fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html>`_ (no gradient so this doesn't work very well, no max time!!)

  .. _stg.fm_options:

- **stg.fm_options** - `Options for fmincon <https://www.mathworks.com/help/optim/ug/fmincon.html#busog7r-options>`_

  .. _stg.sa:

- **stg.sa** - 0 or 1 to decide whether to run `simulated annealing <https://www.mathworks.com/help/gads/simulannealbnd.html>`_

  .. _stg.sa_options:

- **stg.sa_options** - `Options for simulated annealing <https://www.mathworks.com/help/gads/simulannealbnd.html#buy3g1g-options>`_

  .. _stg.psearch:

- **stg.psearch** - 0 or 1 to decide whether to run `Pattern search <https://www.mathworks.com/help/gads/patternsearch.html>`_

  .. _stg.psearch_options:

- **stg.psearch_options** - `Options for Pattern search <https://www.mathworks.com/help/gads/patternsearch.html#buxdit7-options>`_

  .. _stg.ga:

- **stg.ga** - 0 or 1 to decide whether to run `Genetic algorithm <https://www.mathworks.com/help/gads/ga.html>`_

  .. _stg.ga_options:

- **stg.ga_options** - `Options for Genetic algorithm <https://www.mathworks.com/help/gads/ga.html#mw_4a8bfdb9-7c4c-4302-8f47-d260b7a43e26>`_

  .. _stg.pswarm:

- **stg.pswarm** - 0 or 1 to decide whether to run `Particle swarm <https://www.mathworks.com/help/gads/particleswarm.html>`_

  .. _stg.pswarm_options:

- **stg.pswarm_options** - `Options for Particle swarm <https://www.mathworks.com/help/gads/particleswarm.html#budidgf-options>`_

  .. _stg.sopt:

- **stg.sopt** - 0 or 1 to decide whether to run `Surrogate optimization <https://www.mathworks.com/help/gads/surrogateopt.html>`_

  .. _stg.sopt_options:

- **stg.sopt_options** - `Options for Surrogate optimization <https://www.mathworks.com/help/gads/surrogateopt.html#mw_fa3519af-f062-41df-af65-c65ea7a54eb6>`_
