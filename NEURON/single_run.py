# -*- coding: utf-8 -*-
"""
Created on Thu Dec 15 17:48:41 2016

@author: daniel
"""

from neuron import h
import d1msn as msn
import timing_experiment as pe
import pickle
import parameters as p
import random as rnd
# --- 1. Create a cell and other useful stuff

with open('D1_71bestFit_updRheob.pkl', 'rb') as f:
    model_sets  = pickle.load(f, encoding="latin1")

cell_ID = 70
variables = model_sets[cell_ID]['variables'] 
d1 = msn.MSN(variables = variables) 
#d2 = msn.MSN(variables = variables) 
#d1.dendlist[57].diam = 1.15
print(d1.max_dist())

for sec in d1.dendlist:
    print(sec.name(), "%f, %f, %f, d = %.2f" % (h.distance(1.0, sec = sec), 
                                      h.distance(0, sec = sec), 
                                      h.distance(0.70, sec = sec) - h.distance(0.55, sec = sec),
                                      sec.diam))

for sec in d1.somalist:
    print(sec.name(), "%f, %f, %f, d = %.2f" % (h.distance(1, sec = sec), 
                                      h.distance(0, sec = sec), 
                                      h.distance(1, sec = sec) - h.distance(0, sec = sec),
                                      sec.diam))


# --- 2. Insert stimulation to cell

#independent_dends = [3, 5, 8, 12, 15, 22, 26, 35, 41, 47, 53, 57]
dend_record_list = [3]
dend_stim_list = []                    
plateau_cluster_list = [3]
inhibitory_cluster_dict = {'loc': [3], 
                        'pos': [0.85], 
                        'start': [p.inhibitory_burst_start ],
                        'end': [p.inhibitory_burst_end ] }


ex = pe.Timing_Experiment('record_ca', d1)
              
ex.insert_synapses('plateau_cluster', plateau_cluster_list, deterministic = 1, 
                   num_syns = p.plateau_cluster_size, add_spine = 1)
#d1.insert_spines([3], 0.85, 0.95, num_spines = 1)
ex.insert_synapses('glutamate_phos', plateau_cluster_list, deterministic = 1)

for spine in d1.spines:
    spine.head(0.5).timing_model.DA_max = p.DA_max
    spine.head(0.5).timing_model.DA_start = p.DA_start

ex.set_up_recording(dend_record_list)
ex.simulate()
ex.plot_results()

total_input_freq = 0;
for exper in ex.estim:
    total_input_freq += 1000/exper.interval
print('Total input frequency = %.6f' % total_input_freq)

