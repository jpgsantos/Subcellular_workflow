# -*- coding: utf-8 -*-
"""
Created on Thu Dec 15 17:48:41 2016

@author: daniel
"""

import single_sec_cell as se
import timing_experiment as pe
import parameters as p

cell = se.SingleSecCell()

ex = pe.Timing_Experiment('single_sec', cell)

ex.cell.somalist[0].DA_max_timing_model = 0              
ex.set_up_recording()
ex.simulate()
ex.plot_results()

