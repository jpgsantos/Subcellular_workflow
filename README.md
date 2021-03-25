[![View Subcellular_workflow on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/89293-subcellular_workflow) [![Documentation Status](https://readthedocs.org/projects/subcellular-workflow/badge/?version=doc_update)](https://subcellular-workflow.readthedocs.io/en/doc_update/?badge=doc_update)

Subcellular workflow
====================

This workflow has been developed to tackle the challenge of building and analyzing biochemical pathway models, combining pre-existing tools and custom-made software.

At the root of our implementation is the SBtab format, a file format that can store biochemical models and associated data in an easily readable and expandable way.

We have also developed tools to convert the SBtab format into several formats that can be used in MATLAB&reg;, NEURON, STEPS and Copasi.

Using MATLAB&reg; we have developed custom scripts for parameter estimation, global sensitivitiy analysis, and diagnostics tools that can be used for model development.

We demonstrate all these features using an example model, a modified version of the D1 MSN subcellular cascade model from Nair et al 2016<sup>1</sup>.
Code to run this model in MATLAB&reg;, NEURON, and Subcellular aplication(STEPS) can be found on the "MATLAB&reg;", "NEURON" and "BioNetGen and Steps folders" respectively.

Features:

* Model simulation, using MATLAB&reg;, subcellular aplication(STEPS), or NEURON
* Analysis of selected parameter sets, using MATLAB&reg;
* Parameter optimization, using MATLAB&reg;
* Global Sensitivity analysis, using MATLAB&reg;
* Conversion tools:

  * SBtab(.xlsx) to SBtab(.tsv), using MATLAB&reg;
  * SBtab(.xlsx) to MATLAB&reg; SimBiology&trade;(.m, .sbproj), using MATLAB&reg;
  * MATLAB&reg; SimBiology&trade; to SBML(.xml), using MATLAB&reg;
  * SBtab(.tsv) to VFGEN(.vf), using R
  * SBtab(.tsv) to Mod(.mod), using R
  * SBtab(.tsv) to SBML(.xml), using R

# Implemented models

* https://github.com/jpgsantos/Model_Nair_2016
* https://github.com/jpgsantos/Model_Fujita_2010
* https://github.com/jpgsantos/Model_Viswan_2018

# Documentation

To check the online documentation please go to: https://subcellular-workflow.readthedocs.io/

If you want to build the documentation offline use [sphinx](https://www.sphinx-doc.org/en/master/) and the .rst files in the Doc folder.

After installing sphinx, install the following extra extensions to sphinx;

* [recommonmark](https://recommonmark.readthedocs.io/)
* [sphinxcontrib-contentui](https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html)
* [sphinx_markdown_tables](https://pypi.org/project/sphinx-markdown-tables/)

Get your console in the Doc folder and run `sphinx-build . "documentation folder name"`, this should generate html files in the "documentation folder name" folder that you can use with your browser to open and browse the documentation.

# Compatibility

Subcellular workflow MATLAB&reg; code and has been tested in 2020a (all packages installed) running on Microsoft Windows, macOS and Linux.

# References

(1) Nair, A.G., Bhalla, U.S., Kotaleski J.H. (2016). Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal Calcium and Dopamine integration. PLoS Computational Biology, 1;12(9):e1005080.  
