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
