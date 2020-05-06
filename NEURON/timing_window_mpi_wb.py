# -*- coding: utf-8 -*-
"""
Created on Fri Jan 24 15:14:41 2020

@author: daniel
"""

from mpi4py import MPI 
import d1msn as msn
import timing_experiment as te
import numpy as np
import parameters as pp
import seaborn as sns
import pickle
import matplotlib.pyplot as plt
import json

def extend_list(l):
    res = []
    for el in l:
        res.extend(el)
    return res

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
nprocs = comm.Get_size()
print("Number of processes = %d" % nprocs)

if rank == 0:
    DA_start = [-4000, -3500, -3000, -2500, -2000, -1500, -1000, -500, -0, 
                500, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
    
    div, res = divmod(len(DA_start), nprocs)
    counts = [div + 1 if p < res else div for p in range(nprocs)]
    
    # determine the starting and ending indices of each sub-task
    starts = [sum(counts[:p]) for p in range(nprocs)]
    ends = [sum(counts[:p+1]) for p in range(nprocs)]
    DA_start = [DA_start[starts[p]:ends[p]] for p in range(nprocs)]
else:
    DA_start = None

DA_start = comm.scatter(DA_start, root=0)

with open('D1_71bestFit_updRheob.pkl', 'rb') as f:
    model_sets  = pickle.load(f, encoding="latin1")

cell_index = 70
variables = model_sets[cell_index]['variables'] 
cell = msn.MSN(variables = variables)

dend_record_list = [3]
plateau_cluster_list = [3]

ex = te.Timing_Experiment('record_ca', cell)            
ex.insert_synapses('plateau_cluster', plateau_cluster_list, deterministic = 1, 
                   num_syns = pp.plateau_cluster_size, add_spine = 1)
ex.insert_synapses('glutamate_phos', plateau_cluster_list, deterministic = 1)
ex.set_up_recording(dend_record_list)
    
integral = []   

if rank == 0:
    for spine in ex.cell.spines:
        spine.head(0.5).D1_LTP_time_window.DA_max = 0
        spine.head(0.5).D1_LTP_time_window.DA_start = 100 
        
    ex.simulate()
    integral0 = ex.integral[0].to_python()[-1]

for d in DA_start:
    for spine in ex.cell.spines:
        spine.head(0.5).D1_LTP_time_window.DA_max = pp.DA_max
        spine.head(0.5).D1_LTP_time_window.DA_start = d + pp.plateau_burst_start 

    ex.simulate()
    integral.append(ex.integral[0].to_python()[-1])

DA_start = comm.gather(DA_start, root = 0)    
integral = comm.gather(integral, root = 0)    
# 5. Calculate and plot results
if rank == 0:
    print("pSubstrate area for the baseline case (Ca only) is %.2f" % integral0)
    DA_start = extend_list(DA_start)
    print("DA_start:"); print(DA_start)
    integral = extend_list(integral)

    res_dict = {'integral' : integral
    }    
    to_save = json.dumps(res_dict)
    with open('timing_window.dat', 'w', encoding = 'utf-8') as f:
        json.dump(to_save, f)
    
    integral = np.array(integral)

    fig_parea = plt.figure()
    ax_parea = fig_parea.add_subplot(111)
    ax_parea.plot(DA_start, integral/integral0)
    ax_parea.set_xlabel('t_Ca - t_Da (ms)')
    ax_parea.set_ylabel('pSubstrate area')
    
    plt.show()
    
