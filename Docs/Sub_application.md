Subcellular application
=======================


Subcellular application (<https://subcellular.humanbrainproject.eu/model/meta>) provides a web interface for simulation of biomolecular networks expressed on bionetgen language (<https://bionetgen.org/>) using network free solver NFsim and reaction-diffusion stochastic systems solver STEPS (<http://steps.sourceforge.net/STEPS/documentation.php>) Models can be imported from an sbml file. 

This repository represents the use case model example.
Initial SBML model was transformed to bngl format for simulation with STEPS TetOpSplit solver.

D1_LTP_time_window.bngl - BioNetGen model converted from the SBML version of the use case model (D1_LTP_time_window.xml). 
spine.ele, spine.face, spine.node - TetGen (www.tetgen.org) mesh files
spine.json - geometry json file linking meshes and bngl model compartments
stim_DA_complex.tsv, stim_noDA_complex.tsv - files describing stimulation patterns (Ca and dopamine concentrations in spine)
D1_LTP_time_window.ebngl - extended BioNetGen model file (json). In addition to the BioNetGen model it contains geometry and diffusion information as well as
stimulation patterns and parameters of simulation.

To load and simulate the model with the subcellular application:
1) import D1_LTP_time_window.bngl to the subcellular application (import button of the Model panel)
2) add geometry data (add geometry button of the Geometry panel)
3) create simulation (New Simulation button of the Simulations panel), select STEPS as a solver,
specify stimulation pattern (load stim_DA_complex.tsv or stim_noDA_complex.tsv), then run simulation.
