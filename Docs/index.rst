.. Subcelular workflow documentation master file, created by
   sphinx-quickstart on Fri Nov 22 15:04:59 2019.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to the Subcelular workflow documentation!
=================================================

|

!Short description needed!

|

Features: !Please add missing features!

* Model simulation , using Matlab, subcellular aplication(STEPS), or Neuron
* Analysis of selected parameter sets , using Matlab
* Parameter optimization , using Matlab
* Global Sensitivity analysis , using Matlab
* Conversion tools:

  * SBtab(.xlsx) to SBtab(.tsv), using Matlab
  * SBtab(.xlsx) to Matlab SimBiology(.m,.sbproj), using Matlab
  * Matlab SimBiology to SBML(.xml), using Matlab
  * SBtab(.tsv) to VFGEN, using R
  * SBtab(.tsv) to Mod(.mod), using R
  * SBtab(.tsv) to SBML(.xml), using Matlab or R
  * SBtab(.tsv) to R(.R), using R

We demonstrate all these features using an example model, a modifieed version of the D1 MSN subcellular cascade model from Nair et al 2016\ :sup:`1`\.

|

.. image:: ../Docs/Images/Figure_1.png

|

.. toctree::
   :maxdepth: 2

   Matlab 

.. toctree::
   :maxdepth: 2

   Model

.. toctree::
   :maxdepth: 2

   Neuron
   
.. toctree::
   :maxdepth: 2

   Sub_application

.. toctree::
   :maxdepth: 2

   SBtab_vfgen_convertion_tool

.. toctree::
   :maxdepth: 2
   
   SBML_fix
   
References
----------

(1) Nair, A.G., Bhalla, U.S., Kotaleski J.H. (2016). Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal Calcium and Dopamine integration. PLoS Computational Biology, 1;12(9):e1005080.  