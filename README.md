Subcellular workflow
====================


!Short desacription needed!


Features: !Please add missing features!

* Model simulation ,using MATLAB, subcellular aplication(STEPS), or Neuron
* Analysis of selected parameter sets, using MATLAB
* Parameter optimization, using MATLAB
* Global Sensitivity analysis, using MATLAB
* Conversion tools:

  * SBtab(.xlsx) to SBtab(.tsv), using MATLAB
  * SBtab(.xlsx) to MATLAB SimBiology(.m, .sbproj), using MATLAB
  * MATLAB SimBiology to SBML(.xml), using MATLAB
  * SBtab(.tsv) to VFGEN(.vf), using R
  * SBtab(.tsv) to Mod(.mod), using R
  * SBtab(.tsv) to SBML(.xml), using MATLAB or R
  * SBtab(.tsv) to R(.R), using R

We demonstrate all these features using an example model, a modifieed version of the D1 MSN subcellular cascade model from Nair et al 2016<sup>1</sup>.

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

(1) Nair, A.G., Bhalla, U.S., Kotaleski J.H. (2016). Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal Calcium and Dopamine integration. PLoS Computational Biology, 1;12(9):e1005080.  