Here you can find a modified version of the D1 MSN subcellular cascade model from Nair et al 2016.

## SBtab

The model along with the simulated data (sheets E0-E8) used for optimization of the CaMKII autophosphorylation 
module (reactions 128-135) is found in the SBtab format D1_LTP_time_window_SBtab.xlsx. Inputs to all datasets 
are also represented in the sheet following each dataset (E0I-E8I).

## tsv

tsv files generated from each SBtab sheet are available in the zipped file D1_LTP_time_window.tar.gz

## MATLAB

The steady-state model in MATLAB SimBiology format can be found in the MATLAB folder. In addition, there are 
input scripts (spike.m, spiketraindd_Ca.m, spiketraindd_DA.m) that generate the input curves used in model 
simulations. These are used by the script Regenerate_figures.m that can be run directly and will produce two 
figures from the original paper, validating the updated model.

## SBML

The model in SBML format is called D1_LTP_time_window_SBML.xml

## VFGEN/MOD

The folder "SBtab to VFGEN/MOD Conversion Tools" contains the main script sbtab_to_vfgen.R that converts the model
in SBtab into a VFGEN (D1_LTP_time_window_VFgen.vf) and a MOD file (D1_LTP_time_window_MOD.mod) that can be run 
in NEURON. Additional instruction can be found in the README.

## R

The folder R contains the model in R format D1_LTP_time_window.R
.
## Neuron

Usage of the mod file:

The model requires input in th form of dopamine and calcium. These need to be specified by the user:

1. Dopamine is set to be 20 nM in assign_calculated_values(). This line should be replaced to whatever the user needs for input. For example, it could be replaced with an expression for dopamine such as the one provided in this mod file, which makes a dopamine pulse with a double exponential shape. The line 

DA = 20 

should instead read 

DA = DA_expression.

2. The same goes for the calcium input. Additionally, calcium could be provided via the internal concentration of a calcium ion. For example, in this mod file we use the internal calcium concentration due to influx from NMDA receptors, ca_nmdai, which is written through a mechanism for calcium accumulation provided in a separate mod file. Access to the ionic concentrations is provided by NEURON's USEION statement. This variable, ca_nmdai, needs to be added to the ASSIGNED block. 
*--------------------*
*   IMPORTANT NOTE   *
*--------------------* 
Specifying the calcium input like this needs to take care of the units in the model, i.e. the expression for Ca in this case is: 

Ca = ca_nmdai * (1e6)

This is due to the fact that NEURON's default units for concentration are in millimolars (mM), but the model's parameters are expressed in nanomolars (nM). In this way the correct scaling for units in the calcium input is achieved. 