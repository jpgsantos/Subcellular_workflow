Results
^^^^^^^
.. _rst:

Diagnostics
-----------

  .. _rst.diag.simd:

- **rst.diag.simd** - Simulation results (MATLAB representation)

  .. _rst.diag.st:

- **rst.diag.st** - Total score

  .. math:: 
     :label: score_total
   
     \sum_{k=1}^l \sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{data_{i,j,k}-sim_{i,j,k}}{data\_sd_{i,j,k}}\right)^2

  - :math:`n =` number of points for a given experimental output
  - :math:`m =` number of experimental outputs in an experiment
  - :math:`l =` number of experiments
  
  |
  
  .. _rst.diag.se:

- **rst.diag.se** - Score per experiment

  .. math:: 
     :label: score_experiment
   
     \sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{data_{i,j}-sim_{i,j}}{data\_sd_{i,j}}\right)^2
	 
  - :math:`n =` number of points for a given experimental output
  - :math:`m =` number of experimental outputs in an experiment
 
  |
  
  .. _rst.diag.sd:

- **rst.diag.sd** - Score per dataset 

  .. math::
     :label: score_dataset
   
     \frac{1}{n} \sum_{i=1}^n \left(\frac{data_i-sim_i}{data\_sd_i}\right)^2
	
  - :math:`n =` number of points for a given experimental output  

  |

Optimization
------------

  .. _rst.opt.name:

- **rst.opt.name** - optimizer name

  .. _rst.opt.x:

- **rst.opt.x** -  best parameter set found by the optimization

  .. _rst.opt.fval:

- **rst.opt.fval** - score for that best parameter set

  .. _rst.opt.exitflag:

- **rst.opt.exitflag** - diagnostics to see how the optimization went

  .. _rst.opt.output:

- **rst.opt.output** - diagnostics to see how the optimization went

Profile Likelihood
------------------

  .. _rst.PL.sa.x:

- **rst.PL.sa.x** - 

  .. _rst.PL.sa.fval:

- **rst.PL.sa.fval**  - 

  .. _rst.PL.fm.x:

- **rst.PL.fm.x** - 

  .. _rst.PL.fm.fval:

- **rst.PL.fm.fval**  - 

Sensitivity Analysis
--------------------

  .. _rst.SA.M1:

- **rst.SA.M1** - matrices with (Nsamples(:ref:`stg.sansamples<stg.sansamples>`) X Npars(:ref:`stg.ms.parnum<stg.ms.parnum>`)) random numbers within the lower and upper bound ranges set for each parameter

  .. _rst.SA.M2:

- **rst.SA.M2** - same as :ref:`rst.SA.M1<rst.SA.M1>` but different random initialization

  .. _rst.SA.N:

- **rst.SA.N** - matrix of size (Nsamples(:ref:`stg.sansamples<stg.sansamples>`) X Npars(:ref:`stg.ms.parnum<stg.ms.parnum>`) x Npars(:ref:`stg.ms.parnum<stg.ms.parnum>`)) with columns exchanged between M1 and M2

  .. _rst.SA.fM1:

- **rst.SA.fM1** - 

  .. _rst.SA.fM2:

- **rst.SA.fM2** - 

  .. _rst.SA.fN:

- **rst.SA.fN** - 

  .. _rst.SA.SI:

- **rst.SA.SI** - 

  .. _rst.SA.SIT:

- **rst.SA.SIT** - 
