Conversion tools
================

For this workflow we have developed some conversion tools to facilitate model developement.

The MATLAB\ |Reg| code takes the SBtab file in excel format and generates tab separeted file (.tsv) of this SBtab, an SBML file (.xml) of the model, and two MATLAB\ |Reg| versions of the model (.m and .sbproj).

  SBtab (.xls,.xlsx) -> Matlab\ |Reg| model (.m .sbproj), SBtab (.tsv), Matlab\ |Reg| SBML (.xml)


We also have R code to perform other conversions in two external repositories:

 * Code for fixing the SBML produced by MATLAB\ |Reg|
 
     \ https://github.com/a-kramer/simbiology-sbml-fix
   
     Matlab\ |Reg| SBML (.xml) -> SBML (.xml)
   
 * A standalone SBtab to VFgen SBML and NEURON tool
 
     \ https://github.com/a-kramer/SBtabVFGEN
   
     SBtab (.tsv or .ods) -> VFGEN (.vf) + SBML (.xml) + Neuron (.mod)