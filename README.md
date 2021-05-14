[![View Subcellular_workflow on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/89293-subcellular_workflow) [![Documentation Status](https://readthedocs.org/projects/subcellular-workflow/badge/?version=doc_update)](https://subcellular-workflow.readthedocs.io/en/doc_update/?badge=doc_update)

Subcellular workflow
====================

This workflow has been developed to tackle the challenge of building and analyzing biochemical pathway models, combining pre-existing tools and custom-made software.<sup>1</sup>

At the root of our implementation is the SBtab format<sup>2</sup>, a file format that can store biochemical models and associated data in an easily readable and expandable way.

We have also developed tools to convert the SBtab format into several formats that can be used in MATLAB&reg;, NEURON, STEPS and COPASI.

Using MATLAB&reg; we have developed custom scripts for parameter estimation, global sensitivitiy analysis, and diagnostics tools that can be used for model development. The global sensitivity analysis algorithm is modified from Halnes et al 2009<sup>3</sup>.


We demonstrate all these features using three example models, the main one being a modified version of the D1 MSN subcellular cascade model from Nair et al. 2016<sup>4</sup>.

Code to run this model in MATLAB&reg;, NEURON, and Subcellular application (STEPS) can be found on the "MATLAB", "NEURON" and "BioNetGen and STEPS folders" respectively.

Features:

* Model simulation, using MATLAB&reg;,  the Subcellular application (STEPS), or NEURON
* Analysis of selected parameter sets, using MATLAB&reg;
* Parameter optimization, using MATLAB&reg;
* Global Sensitivity analysis, using MATLAB&reg;
* Conversion tools:

  * SBtab (.xlsx,.xls) to SBtab (.tsv), using MATLAB&reg;
  * SBtab (.xlsx) to MATLAB&reg; SimBiology&reg; (.m, .sbproj), using MATLAB&reg;
  * MATLAB&reg; SimBiology&reg; to SBML (.xml), using MATLAB&reg;
  * SBtab (.tsv) to VFGEN (.vf), using R
  * SBtab (.tsv) to Mod (.mod), using R
  * SBtab (.tsv) to SBML (.xml), using R
  
# Sections of the workflow in external repositories

Conversion tools

* https://github.com/a-kramer/SBtabVFGEN
* https://github.com/a-kramer/simbiology-sbml-fix

# Implemented models

* https://github.com/jpgsantos/Model_Nair_2016
* https://github.com/jpgsantos/Model_Fujita_2010
* https://github.com/jpgsantos/Model_Viswan_2018

# Documentation

To check the online documentation please go to: https://subcellular-workflow.readthedocs.io/

If you want to build the documentation offline use [sphinx](https://www.sphinx-doc.org/en/master/) and the .rst files in the Doc folder.

After installing sphinx, install the following extra extensions to sphinx;

* [sphinx_rtd_theme](https://pypi.org/project/sphinx-rtd-theme/)
* [recommonmark](https://recommonmark.readthedocs.io/)
* [sphinxcontrib-contentui](https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html)
* [sphinx_markdown_tables](https://pypi.org/project/sphinx-markdown-tables/)

Get your console in the Doc folder and run `sphinx-build . "documentation folder name"`, this should generate html files in the "documentation folder name" folder that you can use with your browser to open and browse the documentation.

# Compatibility

Subcellular workflow MATLAB&reg; code is compatible with MATLAB&reg; 2020a or above running on Microsoft Windows, macOS and Linux.

Matlab&reg; packages needed:

  * Optimization Toolbox&trade;
  * Statistics and Machine Learning Toolbox&trade;
  * Fuzzy Logic Toolbox&trade;
  * Financial Toolbox&trade;
  * Global Optimization Toolbox
  * SimBiology&reg;
  * Parallel Computing Toolbox&trade;

# References

(1) Santos, J.P., Pajo, K., Trpevski, D., Stepaniuk, A., Eriksson, O., Nair, A.G., Keller, D., Kotaleski, J.H. and Kramer, A., 2020. A Modular Workflow for Model Building, Analysis, and Parameter Estimation in Systems Biology and Neuroscience. bioRxiv.

(2) Lubitz, T., Hahn, J., Bergmann, F.T., Noor, E., Klipp, E. and Liebermeister, W., 2016. SBtab: a flexible table format for data exchange in systems biology. Bioinformatics, 32(16), pp.2559-2561.

(3) Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.

(4) Nair, A.G., Bhalla, U.S. and Hellgren Kotaleski, J., 2016. Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal calcium and dopamine integration. PLoS computational biology, 12(9), p.e1005080.
