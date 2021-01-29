Subcellular workflow
====================

This workflow has been developed to tackle the challenge of building and analyzing biochemical pathway models, combining pre-existing tools and custom-made software.

At the root of our implementation is the SBtab format, a file format that can store biochemical models and associated data in an easily readable and expandable way.

We have also developed tools to convert the SBtab format into several formats that can be used in MATLAB&trade;, NEURON, STEPS and Copasi.

Using MATLAB&trade; we have developed custom scripts for parameter estimation, global sensitivitiy analysis, and diagnostics tools that can be used for model development.

We demonstrate all these features using an example model, a modified version of the D1 MSN subcellular cascade model from Nair et al 2016<sup>1</sup>.
Code to run this model in MATLAB&trade;, NEURON, and Subcellular aplication(STEPS) can be found on the "MATLAB&trade;", "NEURON" and "BioNetGen and Steps folders" respectively.

Features:

* Model simulation, using MATLAB&trade;, subcellular aplication(STEPS), or NEURON
* Analysis of selected parameter sets, using MATLAB&trade;
* Parameter optimization, using MATLAB&trade;
* Global Sensitivity analysis, using MATLAB&trade;
* Conversion tools:

  * SBtab(.xlsx) to SBtab(.tsv), using MATLAB&trade;&trade
  * SBtab(.xlsx) to MATLAB&trade; SimBiology(.m, .sbproj), using MATLAB&trade;
  * MATLAB&trade; SimBiology to SBML(.xml), using MATLAB&trade;
  * SBtab(.tsv) to VFGEN(.vf), using R
  * SBtab(.tsv) to Mod(.mod), using R
  * SBtab(.tsv) to SBML(.xml), using R



# Documentation

To check the online documentation please go to: https://subcellular-workflow.readthedocs.io/

If you want to build the documentation offline use [sphinx](https://www.sphinx-doc.org/en/master/) and the .rst files in the Doc folder.

After installing sphinx, install the following extra extensions to sphinx;

* [recommonmark](https://recommonmark.readthedocs.io/)
* [sphinxcontrib-contentui](https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html)
* [sphinx_markdown_tables](https://pypi.org/project/sphinx-markdown-tables/)

Get your console in the Doc folder and run `sphinx-build . "documentation folder name"`, this should generate html files in the "documentation folder name" folder that you can use with your browser to open and browse the documentation.

# Compatibility

Subcellular workflow MATLAB&trade; code and has been tested in 2020a (all packages installed) running on Microsoft Windows, macOS and Linux.

# References

(1) Nair, A.G., Bhalla, U.S., Kotaleski J.H. (2016). Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal Calcium and Dopamine integration. PLoS Computational Biology, 1;12(9):e1005080.  
