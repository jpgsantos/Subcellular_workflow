Subcellular workflow
====================
!Short desacription needed!

Features: !Please add missing features!

* Analysis of selected parameter sets
* Optimization
* Global Sensitivity analysis
* Conversion between:
* SBtab and Matlab SimBiology
* Matlab SimBiology and SBML
* SBtab and Mod file
* SBtab and SBML
* SBtab and R

# Documentation

To check the online documentation please go to: https://subcellular-workflow.readthedocs.io/

If you want to build the documentation offline use [sphinx](https://www.sphinx-doc.org/en/master/) and the .rst files in the Doc folder.

After installing sphinx, install the following extra extensions to sphinx;

* [sphinxcontrib-contentui](https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html).
* [sphinxcontrib.matlab](https://pypi.org/project/sphinxcontrib-matlabdomain/)
* [sphinx_markdown_tables](https://pypi.org/project/sphinx-markdown-tables/)

Get your console in the Doc folder and run `sphinx-build . "documentation folder name"`, this should generate html files in the "documentation folder name" folder that you can use your browser to open and browse the documentation.

# Compatibility

Subcellular workflow MATLAB code and has been tested in 2020a (all packages installed) running on Microsoft Windows, macOS and Linux.

# References

!Add paper reference once it is published!