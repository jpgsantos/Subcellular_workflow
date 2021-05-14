.. _rst:

Results
^^^^^^^

|

.. _rst_score:

Scoring and saved simulation output
-----------------------------------

Every time a simulation is run the simulated results are compared to the results provided and a score is calculated.
Additionally the end point of the experimental output of all simulations is also stored.
When performing the diagnostics function an MATLAB\ |Reg| representation of the entire run is also saved.

  .. _rst.simd:

- **simd** - Simulation results (MATLAB\ |Reg| representation)

  .. _rst.st:

- **st** - Total score

To simplify representations the following correspondence has been used

:math:`score_{i,j,k} = \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2`

  if :ref:`stg.useLog<stg.useLog>` = 0
  
  :math:`st(θ;Y,τ) = \sum_{k=1}^l \sum_{j=1}^m score_{i,j,k}`
  
  if :ref:`stg.useLog<stg.useLog>` = 1
  
  :math:`st(θ;Y,τ) = \sum_{k=1}^l \sum_{j=1}^m log_{10}(score_{i,j,k})`  
  
  if :ref:`stg.useLog<stg.useLog>` = 2
  
  :math:`st(θ;Y,τ) = \sum_{k=1}^l log_{10}(\sum_{j=1}^m score_{i,j,k})`  
  
  if :ref:`stg.useLog<stg.useLog>` = 3
  
  :math:`st(θ;Y,τ) = log_{10}(\sum_{k=1}^l \sum_{j=1}^m score_{i,j,k})`
  
  .. _rst.se:

- **se** - Score of each experiment

  if :ref:`stg.useLog<stg.useLog>` = 0 or 3
  
  .. math::

      se(θ;Y,τ) = \begin{bmatrix}
              \sum_{j=1}^m score_{i,j,1} \\
              \sum_{j=1}^m score_{i,j,2} \\
              ... \\
			  \sum_{j=1}^m score_{i,j,k}
          \end{bmatrix}
    
  if :ref:`stg.useLog<stg.useLog>` = 1

  .. math::

      se(θ;Y,τ) = \begin{bmatrix}
              \sum_{j=1}^m log_{10}(score_{i,j,1}) \\
              \sum_{j=1}^m log_{10}(score_{i,j,2}) \\
              ... \\
			  \sum_{j=1}^m log_{10}(score_{i,j,k})
          \end{bmatrix}
		  
  if :ref:`stg.useLog<stg.useLog>` = 2

  .. math::

      se(θ;Y,τ) = \begin{bmatrix}
              log_{10}(\sum_{j=1}^m score_{i,j,1}) \\
              log_{10}(\sum_{j=1}^m score_{i,j,2})\\
              ... \\
			  log_{10}(\sum_{j=1}^m score_{i,j,k})
          \end{bmatrix}
		  
  .. _rst.sd:
  
- **sd** - Score of each experimental outputs in all experiments
  
  if :ref:`stg.useLog<stg.useLog>` = 0,2, or 3
  
  .. math::

      sd(θ;Y,τ) = \begin{bmatrix}
              score_{i,1,1} & score_{i,2,1} & ... & score_{i,j,1}\\
              score_{i,1,2} & score_{i,2,2} & ... & score_{i,j,2}\\
              ... & ... & ... & ... \\
			  score_{i,1,k} & score_{i,2,k} & ... & score_{i,j,k}
          \end{bmatrix}
		  
  if :ref:`stg.useLog<stg.useLog>` = 1

  .. math::
  
      sd(θ;Y,τ) = \begin{bmatrix}
              log_{10}(score_{i,1,1}) & log_{10}(score_{i,2,1}) & ... & log_{10}(score_{i,j,1})\\
              log_{10}(score_{i,1,2}) & log_{10}(score_{i,2,2}) & ... & log_{10}(score_{i,j,2})\\
              ... & ... & ... & ... \\
			  log_{10}(score_{i,1,k}) & log_{10}(score_{i,2,k}) & ... & log_{10}(score_{i,j,k})
          \end{bmatrix}

  .. _rst.xfinal:

- **xfinal** - Value of each experimental outputs at the end of the simulation

  .. math::

      xfinal(θ;Y,τ) = \begin{bmatrix}
              y_{n,1,1} & y_{n,2,1} & ... & y_{n,j,1} \\
              y_{n,1,2} & y_{n,2,2} & ... & y_{n,j,2} \\
              ... & ... & ... & ... \\
			  y_{n,1,k} & y_{n,2,k} & ... & y_{n,j,k}
          \end{bmatrix}

  - :math:`F =` Objective function for Particle Swarm optimization 
  - :math:`Y =` Data provided for fitting
  - :math:`y =` Simulation results of the updated model under parameterization :math:`θ`
  - :math:`θ =` New parameterization for :math:`y`
  - :math:`τ =` Allowed mismatch between the two simulation results, analogous to the standard deviation of a Gaussian noise model in data fitting
  - :math:`n/i =` Number/index of points in a given experimental output
  - :math:`m/j =` Number/index of experimental outputs
  - :math:`l/k =` Number/index of experiments
    
|

.. _rst_diag:

Diagnostics
-----------

When running the diagnostics a struct gets created that stores all the :ref:`oputputs<rst_score>` of the :ref:`f_sim_score function.<f_sim_score>`

  .. _rst.diag.simd:

- **rst.diag.simd** - Simulation results (MATLAB\ |Reg| representation)

  .. _rst.diag.st:

- **rst.diag.st** - Total score
  
  .. _rst.diag.se:

- **rst.diag.se** - Score per experiment
		  
  .. _rst.diag.sd:
  
- **rst.diag.sd** - Score per experimental outputs in all experiments
 
  .. _rst.diag.xfinal:

- **rst.diag.xfinal** - x value of all the species being tested at the end of the simulation
    
|

.. _rst_opt:

Optimization
------------

  .. _rst.opt.name:

- **rst.opt.name** - Name of optimizer that was used

  .. _rst.opt.x:

- **rst.opt.x** -  Best parameter set found by the optimization

  .. _rst.opt.fval:

- **rst.opt.fval** - Score for that best parameter set

  .. _rst.opt.exitflag:

- **rst.opt.exitflag** - Diagnostics to see how the optimization went

  .. _rst.opt.output:

- **rst.opt.output** - Diagnostics to see how the optimization went

|

Sensitivity Analysis
--------------------

The calculations performed to obtain these sensitivities where performed according to the equations described in Halnes et al 2009.

  .. _rst.SA.M1:

- **rst.SA.M1** - Matrix with (:math:`r*k`) random numbers within the lower and upper bound ranges set for each parameter

  .. math::

      M_1 = \begin{bmatrix}
              x_{1}^{(1)} & x_{2}^{(1)} & ... & x_{k}^{(1)} \\
              x_{1}^{(2)} & x_{2}^{(2)} & ... & x_{k}^{(2)} \\
              ... & ... & ... & ... \\
			  x_{1}^{(r)} & x_{2}^{(r)} & ... & x_{k}^{(r)}
          \end{bmatrix}

  - :math:`x =` Parameters
  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  
  
  .. _rst.SA.M2:

- **rst.SA.M2** - Same as :ref:`rst.SA.M1<rst.SA.M1>` but different random initialization

  .. math::

      M_2 = \begin{bmatrix}
              x_{1}^{(1')} & x_{2}^{(1')} & ... & x_{k}^{(1')} \\
              x_{1}^{(2')} & x_{2}^{(2')} & ... & x_{k}^{(2')} \\
              ... & ... & ... &  ... \\
			  x_{1}^{(r')} & x_{2}^{(r')} & ... & x_{k}^{(r')}
          \end{bmatrix}

  - :math:`x =` Parameters
  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)

  .. _rst.SA.N:

- **rst.SA.N** - Matrix of size (:math:`r*k*k`) with columns exchanged between M1 and M2 as follows:

  .. math::

      N_i = \begin{bmatrix}
              x_{1}^{(1')} & x_{2}^{(1')} & ... & x_{i}^{(1)} & ... & x_{k}^{(1')} \\
              x_{1}^{(2')} & x_{2}^{(2')} & ... & x_{i}^{(2)} & ... &  x_{k}^{(2')} \\
              ... & ... & ... & ... & ... & ... \\
			  x_{1}^{(r')} & x_{2}^{(r')} & ... & x_{i}^{(r)} & ... &  x_{k}^{(r')}
          \end{bmatrix}

  - :math:`x =` Parameters
  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index of each parameter
  
  .. _rst.SA.fM1:

- **rst.SA.fM1** -

  .. math::

       fM_1 = \begin{bmatrix}
              f(M_1^{(1)}) \\
              f(M_1^{(2)}) \\
              ... \\
			  f(M_1^{(r)})
          \end{bmatrix} = \begin{bmatrix}
              f(x_{1}^{(1)} & x_{2}^{(1)} & ... & x_{k}^{(1)}) \\
              f(x_{1}^{(2)} & x_{2}^{(2)} & ... & x_{k}^{(2)}) \\
              ... & ... & ... &  ... \\
			  f(x_{1}^{(r)} & x_{2}^{(r)} & ... & x_{k}^{(r)})
          \end{bmatrix}

  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)

  .. _rst.SA.fM2:

- **rst.SA.fM2** - 

  .. math::

       fM_2 = \begin{bmatrix}
              f(M_2^{(1')}) \\
              f(M_2^{(2')}) \\
              ... \\
			  f(M_2^{(r')})
          \end{bmatrix} = \begin{bmatrix}
              f(x_{1}^{(1')} & x_{2}^{(1')} & ... & x_{k}^{(1')}) \\
              f(x_{1}^{(2')} & x_{2}^{(2')} & ... & x_{k}^{(2')}) \\
              ... & ... & ... &  ... \\
			  f(x_{1}^{(r')} & x_{2}^{(r')} & ... & x_{k}^{(r')})
          \end{bmatrix}

  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)

  .. _rst.SA.fN:

- **rst.SA.fN** - 

  .. math::

       fN_i = \begin{bmatrix}
              f(N_i^{(1)}) \\
              f(N_i^{(2)}) \\
              ... \\
			  f(N_i^{(r)})
          \end{bmatrix} = \begin{bmatrix}
              f(x_{1}^{(1')} & x_{2}^{(1')} & ... & x_{i}^{(1)} & ... & x_{k}^{(1')}) \\
              f(x_{1}^{(2')} & x_{2}^{(2')} & ... & x_{i}^{(2)} & ... &  x_{k}^{(2')}) \\
              ... & ... & ... & ... & ... & ... \\
			  f(x_{1}^{(r')} & x_{2}^{(r')} & ... & x_{i}^{(r)} & ... &  x_{k}^{(r')})
          \end{bmatrix}

  - :math:`k =` Total number of parameters (:ref:`stg.parnum<stg.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index of each parameter
  
  .. _rst.SA.SI:

- **rst.SA.SI** - First order effects 

  :math:`S_{i}=\frac{V_{Θ_{i}}(E_{Θ_{-i}}(Y|Θ_{i}))}{V(Y)}=\frac{U_{i}-E^2(Y)}{V(Y)}`

    :math:`U_{i}=\frac{1}{n-1}\sum_{r=1}^nf(M_1^r)f(N_i^r)`
  
    :math:`E^2(Y)=\frac{1}{n}\sum_{r=1}^nf(M_1^r)f(M_2^r)`

    :math:`V(Y) = \frac{1}{n-1}f^2(M_1^r)-E^2(Y)`

  - :math:`V  =` Variance
  - :math:`E(... |...)  =` Conditional expected value
  - :math:`Θ =` Parameters of the model
  - :math:`Y =` Scalar output from the model
  - :math:`n =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`r =` Index of the Samples
  - :math:`i =` Index of each parameter
  
  .. _rst.SA.STI:

- **rst.SA.STI** - Total order effects 

  :math:`S_{Ti}=\frac{V(Y)-V_{Θ_{i}}(E_{Θ_{i}}(Y|Θ_{i}))}{V(Y)}=1-\frac{U_{-i}-E^2(Y)}{V_T(Y)}`
  
    :math:`U_{-i}=\frac{1}{n-1}\sum_{r=1}^nf(M_2^r)f(N_i^r)`

    :math:`E^2(Y)=\frac{1}{n}\sum_{r=1}^nf(M_1^r)f(M_2^r)`

    :math:`V_T(Y) = \frac{1}{n-1}f^2(M_2^r)-E^2(Y)`
	
  - :math:`V  =` Variance
  - :math:`E(... |...)  =` Conditional expected value
  - :math:`Θ =` Parameters of the model
  - :math:`Y =` Scalar output from the model
  - :math:`n =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`r =` Index of the Samples
  - :math:`i =` Index of each parameter

|

References
----------
  
`Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.
<https://doi.org/10.1007/s10827-009-0162-6>`_