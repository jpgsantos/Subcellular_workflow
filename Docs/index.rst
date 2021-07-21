Welcome to the Subcellular workflow documentation! 
==================================================

(Under construction - last updated |today|)

This workflow has been developed to tackle the challenge of building and analyzing biochemical pathway models, combining pre-existing tools and custom-made software. (Santos et al. 2020) (Preprint)

At the root of our implementation is the SBtab format (Lubitz et al. 2016), a file that can store biochemical models and associated data in an easily readable and expandable way.

We have also developed tools to convert the SBtab format into several formats that can be used in MATLAB\ |Reg|, NEURON, STEPS and COPASI.

Using MATLAB\ |Reg| we have developed custom scripts for parameter estimation, and global sensitivities analysis, as well as diagnostics tools that can be used for model development. The global sensitivity analysis algorithm is modified from Halnes et al 2009.

We demonstrate all these features using three example models, the main one being a modified version of the D1 MSN subcellular cascade model from Nair et al. 2016.

Code and files to run these models in different simulators:

* | For MATLAB\ |Reg|
  | `Matlab/ <https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab>`_; `Model_Nair_2016/Matlab <https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab>`_; `Model_Fujita_2010/Matlab <https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab>`_; `Model_Viswan_2018/Matlab <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab>`_ 
* | For Neuron  
  | `Model_Nair_2016 <https://github.com/jpgsantos/Model_Nair_2016>`_; `Model_Viswan_2018 <https://github.com/jpgsantos/Model_Viswan_2018>`_
* | For the Subcellular application (STEPS)  
  | `Model_Nair_2016/BioNetGen and STEPS/ <https://github.com/jpgsantos/Model_Nair_2016/tree/master/BioNetGen%20and%20STEPS>`_; `Model_Viswan_2018/BioNetGen and STEPS/ <https://github.com/jpgsantos/Model_Viswan_2018/tree/master/BioNetGen%20and%20STEPS>`_ 
* | Copasi  
  | `Model_Nair_2016 <https://github.com/jpgsantos/Model_Nair_2016>`_; `Model_Viswan_2018 <https://github.com/jpgsantos/Model_Viswan_2018>`_

Features:

* Wrapper for model simulation in MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
* Analysis of selected parameter sets, using MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
* Parameter optimization, using MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
* Global Sensitivity analysis, using MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
* Conversion tools:

  * | SBtab (.xlsx,.xls) to SBtab (.tsv), using MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
  * | SBtab (.xlsx) to MATLAB\ |Reg| SimBiology\ |Reg| (.m, .sbproj), using MATLAB&reg; (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
  * | MATLAB\ |Reg| SimBiology\ |Reg| to SBML (.xml), using MATLAB\ |Reg| (`Matlab/Run_main.m <https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m>`_)
    | Needs to be fixed with our R script (https://github.com/a-kramer/simbiology-sbml-fix)
  * | SBtab (.tsv) to VFGEN (.vf), using R (https://github.com/a-kramer/SBtabVFGEN)
  * | SBtab (.tsv) to Mod (.mod), using R (https://github.com/a-kramer/SBtabVFGEN)
  * | SBtab (.tsv) to SBML (.xml), using R (https://github.com/a-kramer/SBtabVFGEN)

|

.. image:: ../Docs/Images/Figure_1.png

|

Sections of the workflow in external repositories
-------------------------------------------------

Conversion tools: 

* https://github.com/a-kramer/SBtabVFGEN
* https://github.com/a-kramer/simbiology-sbml-fix

Implemented models
------------------

* https://github.com/jpgsantos/Model_Nair_2016
* https://github.com/jpgsantos/Model_Fujita_2010
* https://github.com/jpgsantos/Model_Viswan_2018

Compatibility
-------------

Subcellular workflow MATLAB\ |Reg| code is compatible with MATLAB\ |Reg| 2020a or above running on Microsoft Windows, macOS and Linux.

Matlab\ |Reg| packages needed:

  * Optimization Toolbox\ |TM|
  * Statistics and Machine Learning Toolbox\ |TM|
  * Fuzzy Logic Toolbox\ |TM|
  * Financial Toolbox\ |TM|
  * Global Optimization Toolbox
  * SimBiology\ |Reg|
  * Parallel Computing Toolbox\ |TM|

.. toctree::
   :hidden:
   :maxdepth: 1

   SBtab
   Matlab
   Neuron
   Sub_application
   Conversion_tools
   Model
   Code on Github <https://github.com/jpgsantos/Subcellular_workflow>

References
----------

`Santos, J.P., Pajo, K., Trpevski, D., Stepaniuk, A., Eriksson, O., Nair, A.G., Keller, D., Kotaleski, J.H. and Kramer, A., 2020. A Modular Workflow for Model Building, Analysis, and Parameter Estimation in Systems Biology and Neuroscience. bioRxiv.
<https://doi.org/10.1101/2020.11.17.385203>`_

`Lubitz, T., Hahn, J., Bergmann, F.T., Noor, E., Klipp, E. and Liebermeister, W., 2016. SBtab: a flexible table format for data exchange in systems biology. Bioinformatics, 32(16), pp.2559-2561.
<https://doi.org/10.1093/bioinformatics/btw179>`_

`Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.
<https://doi.org/10.1007/s10827-009-0162-6>`_

`Nair, A.G., Bhalla, U.S. and Hellgren Kotaleski, J., 2016. Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal calcium and dopamine integration. PLoS computational biology, 12(9), p.e1005080.
<https://doi.org/10.1371/journal.pcbi.1005080>`_
