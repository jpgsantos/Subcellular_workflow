Subcellular workflow
====================
!Short desacription needed!

Features: !Please add missing features!

* Model simulation (Matlab, Neuron, subcellular aplication/STEPS)
* Analysis of selected parameter sets (Matlab)
* Parameter optimization (Matlab)
* Global Sensitivity analysis (Matlab)
* Conversion between:
* SBtab and Matlab SimBiology (Matlab)
* Matlab SimBiology and SBML (Matlab)
* SBtab and Mod file (R)
* SBtab and SBML (Matlab,R)
* SBtab and R (R)

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