NEURON
======

Here we describe the usage of the MOD files for two of the provided examples (the third one does not use MOD files).

Nair et al. 2016 (D1 MSN subcellular cascade)
---------------------------------------------

The model requires input in the form of dopamine and calcium. These need to be specified by the user:

1. Dopamine is set to be 20 nM in assign_calculated_values(). This line should be replaced to whatever the user needs for input. For example, it could be replaced with an expression for dopamine such as the one provided in this mod file, which makes a dopamine pulse with a double exponential shape. The line 

DA = 20 

should instead read 

DA = DA_expression.

2. The same goes for the calcium input. Alternatively, calcium could be provided via the intracellular concentration of a calcium ion. For example, in this MOD file we use the intracellular calcium concentration due to influx from NMDA receptors, ca_nmdai, which is calculated through a mechanism for calcium accumulation provided in a separate MOD file. Access to the ionic concentrations is provided by NEURON's "USEION" statement. In this case the variable ca_nmdai needs to be added to the ASSIGNED block. 


---------*IMPORTANT NOTE*---------


When specifying the calcium input like this care needs to be taken to make sure the units used by NEURON and the units in the model exported to the MOD file match. As mentioned in the article, the models exported as MOD files could have different units for the parameter values from the default units used by NEURON. For instance, NEURON's default units for internal calculations of ionic concentrations are in millimolars (mM), but the model's parameters are expressed in nanomolars (nM). It is absolutely *paramount* to match units, i.e. use the correct scaling for, in this case, the variable ca_nmdai, to provide the model with the right quantity of calcium so that it runs properly:

Ca = ca_nmdai * (1e6)

Viswan et al. 2016 (EGF-stimulated MAPK cascade)
------------------------------------------------

In this model we only use EGF as an input (only this input is used in Figure 7 in Viswan et al. 2018 which we reproduce; otherwise the model may have various other inputs, see the original paper for details [2]).

1. The input is a step in the concentration of EGF, given by an expression for a sharp sigmoidal function for EGF in assign_calculated_values():

 EGF = EGF_level/(1+exp(-(t-EGF_start) * EGF_steepness))

2. The SBtab format of this model expresses the parameter values in seconds, whereas NEURON's default unit for time is milliseconds. The conversion script SBtab_to_vfgen provides automatic scaling of time units in SBtab to milliseconds. The concentration units are given in micromolar, and if some species needs to be coupled to a NEURON variable which is expressed in other units (such as NEURON's default millimolar units), the species or the NEURON variable need to be rescaled as in the example above.

References
----------

[1] [Nair, A.G., Bhalla, U.S. and Hellgren Kotaleski, J., 2016. Role of DARPP-32 and ARPP-21 in the emergence of temporal constraints on striatal calcium and dopamine integration. PLoS computational biology, 12(9), p.e1005080.](https://doi.org/10.1371/journal.pcbi.1005080)

[2] [Viswan, N.A., HarshaRani, G.V., Stefan, M.I. and Bhalla, U.S., 2018. FindSim: a framework for integrating neuronal data and signaling models. Frontiers in neuroinformatics, 12, p.38.](https://doi.org/10.3389/fninf.2018.00038)
