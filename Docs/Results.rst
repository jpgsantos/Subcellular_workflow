Results
^^^^^^^
.. _rst:

Diagnostics
-----------

  .. _rst.diag.simd:

- **rst.diag.simd** - Simulation results (MATLAB representation)

  .. _rst.diag.st:

- **rst.diag.st** - Total score

  :math:`\sum_{k=1}^l \sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j,k}-y_{i,j,k}}{τ_{i,j,k}}\right)^2`

  .. _rst.diag.se:

- **rst.diag.se** - Score per experiment

  :math:`\sum_{j=1}^m \frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i,j}-y_{i,j}}{τ_{i,j}}\right)^2`
  
  .. _rst.diag.sd:

- **rst.diag.sd** - Score per dataset 

  :math:`\frac{1}{n} \sum_{i=1}^n \left(\frac{Y_{i}-y_{i}}{τ_{i}}\right)^2`
	
  - :math:`F =` Objective function for Particle Swarm optimization 
  - :math:`Y =` Simulation results from the original (validated) model
  - :math:`y =` Simulations of the updated model under parameterization θ
  - :math:`θ =` New parametization for y
  - :math:`τ =` Allowed mismatch between the two simulation results, analogous to the standard deviation of a Gaussian noise model in data fitting
  - :math:`n =` number of points in a given experimental output
  - :math:`m =` number of experimental outputs in an experiment
  - :math:`l =` number of experiments
  
- **rst.diag.xfinal** - x value of all the species being tested at the end of the simulation
  
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

Sensitivity Analysis
--------------------

  .. _rst.SA.M1:

- **rst.SA.M1** - Matrix with (:math:`r*k`) random numbers within the lower and upper bound ranges set for each parameter

  .. math::

      M_1 = \begin{bmatrix}
              x_{1}^{(1)} & x_{2}^{(1)} & ... & x_{k}^{(1)} \\
              x_{1}^{(2)} & x_{2}^{(2)} & ... & x_{k}^{(2)} \\
              ... & ... & ... &  ... \\
			  x_{1}^{(r)} & x_{2}^{(r)} & ... & x_{k}^{(r)}
          \end{bmatrix}

  - :math:`x =` Parameters
  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  
  
  .. _rst.SA.M2:

- **rst.SA.M2** - same as :ref:`rst.SA.M1<rst.SA.M1>` but different random initialization

  .. math::

      M_2 = \begin{bmatrix}
              x_{1}^{(1')} & x_{2}^{(1')} & ... & x_{k}^{(1')} \\
              x_{1}^{(2')} & x_{2}^{(2')} & ... & x_{k}^{(2')} \\
              ... & ... & ... &  ... \\
			  x_{1}^{(r')} & x_{2}^{(r')} & ... & x_{k}^{(r')}
          \end{bmatrix}

  - :math:`x =` Parameters
  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
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
  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index for each parameter
  
  .. _rst.SA.fM1:

- **rst.SA.fM1** -

  .. math::

       fM_1 = \begin{bmatrix}
              f(M_1^1) \\
              f(M_1^2) \\
              ... \\
			  f(M_1^r)
          \end{bmatrix}

  :math:`f(M_1^r) = f(x_{1}^{(r)},  x_{2}^{(r)},  ...,  x_{k}^{(r)})`

  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)

  .. _rst.SA.fM2:

- **rst.SA.fM2** - 

  .. math::

       fM_2 = \begin{bmatrix}
              f(M_2^1) \\
              f(M_2^2) \\
              ... \\
			  f(M_2^r)
          \end{bmatrix}

  :math:`f(M_2^r) = f(x_{1}^{(r')},  x_{2}^{(r')},  ...,  x_{k}^{(r')})`

  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)

  .. _rst.SA.fN:

- **rst.SA.fN** - 

  .. math::

       fN_i = \begin{bmatrix}
              f(N_i^1) \\
              f(N_i^2) \\
              ... \\
			  f(N_i^r)
          \end{bmatrix}

  :math:`f(N_i^r) = f(x_{1}^{(r')},  x_{2}^{(r')},  ...,  x_{i}^{(r)},  ...,   x_{k}^{(r')})`

  - :math:`k =` Total number of parameters (:ref:`stg.ms.parnum<stg.ms.parnum>`)
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index for each parameter
  
  .. _rst.SA.SI:

- **rst.SA.SI** - First order effects 

  :math:`S_{i}=\frac{V_{Θ_{i}}(E_{Θ_{-i}}(Y|Θ_{i}))}{V(Y)}=\frac{U_{i}-E^2(Y)}{V(Y)}`

    :math:`U_{i}=\frac{1}{N-1}\sum_{r=1}^Nf(M_1^r)f(N_i^r)`
  
    :math:`E^2(Y)=\frac{1}{N}\sum_{r=1}^Nf(M_1^r)f(M_2^r)`

    :math:`V(Y) = \frac{1}{N-1}f^2(M_1^r)-E^2(Y)`

  - :math:`V  =` Variance
  - :math:`E(... |...)  =` conditional expected value
  - :math:`Θ =` Parameters of the model
  - :math:`Y =` scalar output from the model
  
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index for each parameter
  
  .. _rst.SA.STI:

- **rst.SA.STI** - Total order effects 

  :math:`S_{Ti}=\frac{V(Y)-V_{Θ_{i}}(E_{Θ_{i}}(Y|Θ_{i}))}{V(Y)}=1-\frac{U_{-i}-E^2(Y)}{V_T(Y)}`
  
    :math:`U_{-i}=\frac{1}{N-1}\sum_{r=1}^Nf(M_2^r)f(N_i^r)`

    :math:`E^2(Y)=\frac{1}{N}\sum_{r=1}^Nf(M_1^r)f(M_2^r)`

    :math:`V_T(Y) = \frac{1}{N-1}f^2(M_2^r)-E^2(Y)`
	
  - :math:`V  =` Variance
  - :math:`E(... |...)  =` conditional expected value
  - :math:`Θ =` Parameters of the model
  - :math:`Y =` scalar output from the model
  - :math:`r =` Total number of Samples (:ref:`stg.sansamples<stg.sansamples>`)
  - :math:`i =` Index for each parameter