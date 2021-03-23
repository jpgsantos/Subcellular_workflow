Viswan et al. 2018
==================

Model from the FindSim framework by Viswan et al. 2018. The model represents an epidermal growth factor (EGF)-dependent mitogen-activated protein kinase (MAPK) signaling pathway
(the green block from [Fig. 7a]) which measures MAPK phosphorylation. Here, two simulation experiments with EGF step inputs of different sizes are used to perform parameter estimation on 29 model parameters corresponding to reactions involved in MAPK phosphorylation (see below). For this we used activated MAPK curves in [Fig. 7b and 7c].

.. raw:: html

   <h2>Reactions chosen for parameter estimation and Global Sensitivity Analysis</h2>

* GTP_Ras + craf_1_p <=> Raf_p_GTP_Ras
* GEF_p -> inact_GEF
* GTP_Ras -> GDP_Ras
* GAP_p -> GAP
* MAPK_p_p + craf_1_p <=> MAPK_p_p_feedback_cplx
* MAPK_p_p_feedback_cplx -> MAPK_p_p + craf_1_p_p
* MAPKK_p_p + MAPK <=> MAPKKtyr_cplx
* MAPKKtyr_cplx -> MAPKK_p_p + MAPK_p
* MAPKK_p_p + MAPK_p <=> MAPKKthr_cplx
* MAPKKthr_cplx -> MAPKK_p_p + MAPK_p_p
* MAPKK + Raf_p_GTP_Ras <=> Raf_p_GTP_Ras_1_cplx
* Raf_p_GTP_Ras_1_cplx -> MAPKK_p + Raf_p_GTP_Ras
* MAPKK_p + Raf_p_GTP_Ras <=> Raf_p_GTP_Ras_2_cplx
* Raf_p_GTP_Ras_2_cplx -> MAPKK_p_p + Raf_p_GTP_Ras
* inact_GEF + GDP_Ras <=> basal_GEF_activity_cplx
* basal_GEF_activity_cplx -> inact_GEF + GTP_Ras
* GEF_p + GDP_Ras <=> GEF_p_act_Ras_cplx
* GEF_p_act_Ras_cplx -> GEF_p + GTP_Ras
* GAP + GTP_Ras <=> GAP_inact_Ras_cplx
* GAP_inact_Ras_cplx -> GAP + GDP_Ras

.. raw:: html

   <h2>References</h2>

[Viswan, N.A., HarshaRani, G.V., Stefan, M.I., Bhalla, U.S. (2018). FindSim: A framework for integrating neuronal data and signaling models. Frontiers in Neuroinformatics, 12, 38.](https://doi.org/10.3389/fninf.2018.00038)