[![View Subcellular_workflow on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/89293-subcellular_workflow) [![Documentation Status](https://readthedocs.org/projects/subcellular-workflow/badge/?version=latest)](https://subcellular-workflow.readthedocs.io/en/latest/?badge=latest)
# Subcellular Workflow

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Implemented models](#implemented-models)
- [Usage](#usage)
- [Sections of the workflow in external repositories](#sections-of-the-workflow-in-external-repositories)
- [Compatibility](#compatibility)
- [Documentation](#documentation)
- [References](#references)

## Introduction

This workflow was created to address the challenge of constructing and analyzing biochemical pathway models by combining pre-existing tools with custom-made software.<sup>1</sup> The foundation of our implementation is the SBtab format<sup>2</sup>,, which is a file format that can store biochemical models and related data in a way that is easy to read and expand.

We have also created tools to convert the SBtab format into several formats that can be used with MATLAB®, NEURON, STEPS, and COPASI. Using MATLAB®, we have developed custom scripts for parameter estimation, global sensitivity analysis, and diagnostic tools for model development. The global sensitivity analysis algorithm has been adapted from Halnes et al 2009<sup>3</sup>.

We showcase all these features using three example models. The primary model is a modified version of the D1 MSN subcellular cascade model from Nair et al. 2016.<sup>4</sup>

## Features

* Wrapper for model simulation in MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
* Analysis of selected parameter sets, using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
* Parameter optimization, using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
* Global Sensitivity analysis algorithm modified from Halnes et al 2009.<sup>3</sup>, using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
* Conversion tools:

  * SBtab (.xlsx,.xls) to SBtab (.tsv), using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
  * SBtab (.xlsx) to MATLAB&reg; SimBiology&reg; (.m, .sbproj), using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))
  * MATLAB&reg; SimBiology&reg; to SBML (.xml), using MATLAB&reg; ([Matlab/Run_main.m](https://github.com/jpgsantos/Subcellular_workflow/blob/master/Matlab/Run_main.m))  
    Needs to be fixed with our R script (https://github.com/a-kramer/simbiology-sbml-fix)
  * SBtab (.tsv) to VFGEN (.vf), using R (https://github.com/a-kramer/SBtabVFGEN)
  * SBtab (.tsv) to Mod (.mod), using R (https://github.com/a-kramer/SBtabVFGEN)
  * SBtab (.tsv) to SBML (.xml), using R (https://github.com/a-kramer/SBtabVFGEN)

## Implemented models
We demonstrate all these features using three models:
1. [Model_Fujita_2010](https://github.com/jpgsantos/Model_Fujita_2010)
2. [Model_Nair_2016](https://github.com/jpgsantos/Model_Nair_2016) (modified version of the D1 MSN subcellular cascade model from Nair et al. 2016)<sup>4</sup>
3. [Model_Viswan_2018](https://github.com/jpgsantos/Model_Viswan_2018)

## Usage
Code and files to run these models in different simulators can be found in the following repositories:
* For MATLAB®: [Matlab/](https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab),[Model_Fujita_2010](https://github.com/jpgsantos/Model_Fujita_2010),[Model_Nair_2016](https://github.com/jpgsantos/Model_Nair_2016),[Model_Viswan_2018](https://github.com/jpgsantos/Model_Viswan_2018)
* For Neuron: [Model_Nair_2016](https://github.com/jpgsantos/Model_Nair_2016/tree/master/NEURON), [Model_Viswan_2018](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/NEURON)
* For the Subcellular application (STEPS): [Model_Nair_2016](https://github.com/jpgsantos/Model_Nair_2016/tree/master/BioNetGen%20and%20STEPS), [Model_Viswan_2018](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/BioNetGen%20and%20STEPS)
* For Copasi: [Model_Nair_2016](https://github.com/jpgsantos/Model_Nair_2016), [Model_Viswan_2018](https://github.com/jpgsantos/Model_Viswan_2018)
  
## Sections of the workflow in external repositories

Conversion tools

* https://github.com/a-kramer/SBtabVFGEN
* https://github.com/a-kramer/simbiology-sbml-fix

## Implemented models

* https://github.com/jpgsantos/Model_Nair_2016
* https://github.com/jpgsantos/Model_Fujita_2010
* https://github.com/jpgsantos/Model_Viswan_2018

## Compatibility

Subcellular workflow MATLAB&reg; code is compatible with MATLAB&reg; 2020a or above running on Microsoft Windows, macOS and Linux.

Matlab&reg; packages needed:

  * Optimization Toolbox&trade;
  * Statistics and Machine Learning Toolbox&trade;
  * Fuzzy Logic Toolbox&trade;
  * Financial Toolbox&trade;
  * Global Optimization Toolbox
  * SimBiology&reg;
  * Parallel Computing Toolbox&trade;

## Documentation

To check the online documentation please go to: https://subcellular-workflow.readthedocs.io/

If you want to build the documentation offline use [sphinx](https://www.sphinx-doc.org/en/master/) and the .rst files in the Doc folder.

After installing sphinx, install the following extra extensions to sphinx;

* [sphinx_rtd_theme](https://pypi.org/project/sphinx-rtd-theme/)
* [recommonmark](https://recommonmark.readthedocs.io/)
* [sphinxcontrib-contentui](https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html)
* [sphinx_markdown_tables](https://pypi.org/project/sphinx-markdown-tables/)

Get your console in the Doc folder and run `sphinx-build . "documentation folder name"`, this should generate html files in the "documentation folder name" folder that you can use with your browser to open and browse the documentation.

## References

(1) Santos, J.P., Pajo, K., Trpevski, D., Stepaniuk, A., Eriksson, O., Nair, A.G., Keller, D., Kotaleski, J.H. and Kramer, A., 2020. A Modular Workflow for Model Building, Analysis, and Parameter Estimation in Systems Biology and Neuroscience. bioRxiv.

(2) Lubitz, T., Hahn, J., Bergmann, F.T., Noor, E., Klipp, E. and Liebermeister, W., 2016. SBtab: a flexible table format for data exchange in systems biology. Bioinformatics, 32(16), pp.2559-2561.

(3) Halnes, G., Ulfhielm, E., Ljunggren, E.E., Kotaleski, J.H. and Rospars, J.P., 2009. Modelling and sensitivity analysis of the reactions involving receptor, G-protein and effector in vertebrate olfactory receptor neurons. Journal of Computational Neuroscience, 27(3), p.471.

(4) Nair, A.G., Bhalla, U.S. and Hellgren Kotaleski, J., 2016. Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal calcium and dopamine integration. PLoS computational biology, 12(9), p.e1005080.
