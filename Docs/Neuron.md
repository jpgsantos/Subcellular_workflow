NEURON
======

Usage of the MOD file:

The model requires input in the form of dopamine and calcium. These need to be specified by the user:

Dopamine is set to be 20 nM in assign_calculated_values(). This line should be replaced to whatever the user needs for input. For example, it could be replaced with an expression for dopamine such as the one provided in this mod file, which makes a dopamine pulse with a double exponential shape. The line
DA = 20

should instead read

DA = DA_expression.

The same goes for the calcium input. Additionally, calcium could be provided via the intracellular concentration of a calcium ion. For example, in this mod file we use the intracellular calcium concentration due to influx from NMDA receptors, ca_nmdai, which is written through a mechanism for calcium accumulation provided in a separate MOD file. Access to the ionic concentrations is provided by NEURON's USEION statement. In this case the variable ca_nmdai needs to be added to the ASSIGNED block. 

-------------------- * IMPORTANT NOTE * -------------------- 

When specifying the calcium input like this needs care needs to be taken to make sure the units used by NEURON and the units used in the imported model match. As mentioned in the article, the models imported as MOD files could have different units for the parameter values from the default units used by NEURON to perform internal calculations of variables such as ionic concentrations. For instance, NEURON's default units for concentration are in millimolars (mM), but the model's parameters are expressed in nanomolars (nM). It is absolutely paramount to match units, i.e. use the correct scaling for, in this case, the variable ca_nmdai, to provide the model with the right quantity of calcium so that it runs properly:
Ca = ca_nmdai * (1e6)