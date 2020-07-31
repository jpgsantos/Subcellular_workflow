Subcellular workflow
====================
!Short desacription needed!

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

We demonstrate all these features using an example model, a modifieed version of the D1 MSN subcellular cascade model from Nair et al 2016<sup>1</sup>.
<sup>superscript</sup>
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