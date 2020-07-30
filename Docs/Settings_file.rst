Settings file
=============

.. _stg:

Import
------

Settings struct for model import from SBtab.

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

  .. _stg.analysis:

- **stg.analysis** - String with the analysis to be run, the options are "RS", "diag", "optlocal", "optcluster", "PLlocal", "PLcluster", "SAlocal", "SAcluster" and can be combined as for example "RS,diag", to not run any analysis set stg.analysis to equal to ""

  .. _stg.exprun:

- **stg.exprun** - Experiments to run

  .. _stg.useLog:

- **stg.useLog** - Choice between 0,1,2 and 3 to change either and how to apply log10 to the scores

 0. :math:`F(θ;Y,τ) = \sum_{k=1}^l \sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2`
 #. :math:`F(θ;Y,τ) = \sum_{k=1}^l \sum_{j=1}^m log_{10}\left(\frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2\right)`
 #. :math:`F(θ;Y,τ) = \sum_{k=1}^l log_{10}\left(\sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2\right)`
 #. :math:`F(θ;Y,τ) = log_{10}\left(\sum_{k=1}^l \sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2\right)`
 
  - :math:`F =` Objective function for Particle Swarm optimization 
  - :math:`Y =` Simulation results from the original (validated) model
  - :math:`y =` Simulations of the updated model under parameterization θ
  - :math:`θ =` New parametization for y
  - :math:`τ =` Allowed mismatch between the two simulation results, analogous to the standard deviation of a Gaussian noise model in data fitting
  - :math:`n =` number of points in a given experimental output
  - :math:`m =` number of experimental outputs in an experiment
  - :math:`l =` number of experiments
  
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

  .. _stg.ms.maxt:
  
- **stg.ms.maxt** - Maximum time for each individual function to run in seconds

  .. _stg.ms.eqt:

- **stg.ms.eqt** - Equilibration time

  .. _stg.ms.dimenanal:

- **stg.ms.dimenanal** - 0 or 1 to decide whether to do Dimensional Analysis

  .. _stg.ms.abstolscale:

- **stg.UnitConversion** - 0 or 1 to decide whether to do Unit conversion

  .. _stg.UnitConversion:
  
- **stg.ms.abstolscale** - 0 or 1 to decide whether to do Absolute Tolerance Scaling

  .. _stg.ms.reltol:

- **stg.ms.reltol** - Value of Relative tolerance

  .. _stg.ms.abstol:

- **stg.ms.abstol** - Value of Absolute tolerance

  .. _stg.simtime:

- **stg.simtime** - Time units for simulation

  .. _stg.ms.sbioacc:

- **stg.ms.sbioacc** - 0 or 1 to decide whether to run sbioaccelerate (after changing this value you need to run “clear functions” to see an effect)

  .. _stg.maxstep:

- **stg.maxstep** - Max step size in the simulation (if empty matlab decides whats best)

Model
-----

  .. _stg.ms.parnum:

- **stg.ms.parnum** - Number of parameters to optimize

  .. _stg.ms.tci:

- **stg.ms.tci** - Index for the parameters that have thermodynamic constrains

  .. _stg.ms.tcm:

- **stg.ms.tcm** - Parameters to multiply to the first parameter (in Stg.ms.partest to get to the correct thermodynamic constrain formula)

  .. _stg.ms.tcd*:

- **stg.ms.tcd** - Parameters to divide to the first parameter (in Stg.ms.partest to get to the correct thermodynamic constrain formula)

  .. _stg.lb:

- **stg.lb** - Array with the lower bound of all parameters

  .. _stg.ub:

- **stg.ub** - Array with the upper bound of all parameters

Diagnostics
-----------

  .. stg.ms.partest:
  
- **stg.ms.partest** - Choice of what parameters in the array to test, the indices correspond to the parameters in the model and the numbers correspond to the parameters in the optimization array, usually not all parameters are optimized so there needs to be a match between one and the other.

  .. _stg.pat:
  
- **stg.pat** - Parameter array to test

  .. _stg.pa:

- **stg.pa** - All the parameter arrays, in this case there is only one

  .. _stg.bestx:

- **stg.bestx** - Best parameter array found so far during optimization

Plots
-----

  .. _stg.plot:

- **stg.plot** - 0 or 1 to decide whether to plot results

  .. _stg.plotoln:

- **stg.plotoln** - 0 or 1 to decide whether to use long names in the title of the outputs plots in f_plot_outputs.m

Sensitivity Analysis (SA)
-------------------------

  .. _stg.sansamples:

- **stg.sansamples** - Number of samples to use in SA

  .. _stg.sasubmean:

- **stg.sasubmean** - 0 or 1 to decide whether to subtract mean before calculating SI and SIT

  .. _stg.sasamplemode:

- **stg.sasamplemode** - Choose the way you want to obtain the samples of the parameters for performing the SA;

 #. Log uniform distribution truncated at the parameter bounds

 #. Log normal distribution with mu as the best value for a parameter and sigma as stg.sasamplesigma truncated at the parameter bounds

 #. same as 1 without truncation

 #. Log normal distribution centered at the mean of the parameter bounds and sigma as stg.sasamplesigma truncated at the parameter bounds

 #. same as 3 without truncation.

  .. _stg.sasamplesigma:

- **stg.sasamplesigma** - Sigma for creating the normal distribution of parameters to perform sensitivity analysis


Optimization
------------

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
