# -*- coding: utf-8 -*-
"""
Created on Thu Dec 15 17:48:41 2016

@author: daniel
"""

import single_sec_cell as se
import timing_experiment as te
import json

simtime = 2000e3
cell = se.SingleSecCell()

ex = te.Timing_Experiment('single_sec', cell)

ex.cell.somalist[0].DA_max_D1_LTP_time_window = 0              
ex.set_up_recording()
ex.simulate(simtime = simtime)
ex.plot_results()

steady_states = []
for sp in ex.species:
    steady_states.append(sp.to_python()[-1])

result = {'steady_states': steady_states}
to_save = json.dumps(result)
with open('steady_states.dat', 'w', encoding = 'utf-8') as f:
    json.dump(to_save, f)
    
