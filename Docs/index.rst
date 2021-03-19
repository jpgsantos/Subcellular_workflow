Welcome to the Subcelular workflow documentation! (Under construction - last updated |today|)
=============================================================================================

|

This workflow has been developed to tackle the challenge of building and analyzing biochemical pathway models, combining pre-existing tools and custom-made software.

At the root of our implementation is the SBtab format, a file that can store biochemical models and associated data in an easily readable and expandable way.

We have also developed tools to convert the SBtab format into several formats that can be used in MATLAB\ |TM|, NEURON, STEPS and COPASI.

Using MATLAB\ |TM| we have developed custom scripts for parameter estimation, global sensitivities analysis, and diagnostics tools that can be used for model development.

We demonstrate all these features using three example models, the main one being a modified version of the D1 MSN subcellular cascade model from Nair et al. 2016 [1]_.

Code to run this model in MATLAB\ |TM|, NEURON, and the Subcellular web application (STEPS) can be found on the "MATLAB\ |TM|", "NEURON" and "BioNetGen and STEPS folders", respectively.

|

Features:

* Model simulation using MATLAB\ |TM|, the Subcellular application (STEPS), or NEURON
* Analysis of selected parameter sets, using MATLAB\ |TM|
* Parameter optimization using MATLAB\ |TM|
* Global Sensitivity Analysis using MATLAB\ |TM|
* Conversion tools:

  * SBtab(.xlsx) to SBtab(.tsv), using MATLAB\ |TM|
  * SBtab(.xlsx) to MATLAB\ |TM| SimBiology(.m, .sbproj) using MATLAB\ |TM|
  * MATLAB\ |TM| SimBiology to SBML(.xml) using MATLAB\ |TM|
  * SBtab(.tsv) to VFGEN(.vf) using R
  * SBtab(.tsv) to MOD(.mod) using R
  * SBtab(.tsv) to SBML(.xml) using R

|

.. image:: ../Docs/Images/Figure_1.png

|

.. toctree::
   :hidden:
   :maxdepth: 1

   SBtab 
   Matlab
   Neuron
   Sub_application
   Conversion_tools
   Model

References
----------

.. [1] Nair, A.G., Bhalla, U.S., Kotaleski J.H. (2016). Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal Calcium and Dopamine integration. PLoS Computational Biology, 1;12(9):e1005080.
