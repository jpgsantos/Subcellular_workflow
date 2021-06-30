/* Created by Language version: 7.7.0 */
/* VECTORIZED */
#define NRN_VECTORIZED 1
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib_ansi.h"
#undef PI
#define nil 0
#include "md1redef.h"
#include "section.h"
#include "nrniv_mf.h"
#include "md2redef.h"
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define nrn_init _nrn_init__SBTAB_Findsim
#define _nrn_initial _nrn_initial__SBTAB_Findsim
#define nrn_cur _nrn_cur__SBTAB_Findsim
#define _nrn_current _nrn_current__SBTAB_Findsim
#define nrn_jacob _nrn_jacob__SBTAB_Findsim
#define nrn_state _nrn_state__SBTAB_Findsim
#define _net_receive _net_receive__SBTAB_Findsim 
#define assign_calculated_values assign_calculated_values__SBTAB_Findsim 
#define observables_func observables_func__SBTAB_Findsim 
#define ode ode__SBTAB_Findsim 
 
#define _threadargscomma_ _p, _ppvar, _thread, _nt,
#define _threadargsprotocomma_ double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt,
#define _threadargs_ _p, _ppvar, _thread, _nt
#define _threadargsproto_ double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define PKC_active _p[0]
#define PKC_active1 _p[1]
#define APC _p[2]
#define Inositol _p[3]
#define PC _p[4]
#define PIP2 _p[5]
#define EGF _p[6]
#define Ca _p[7]
#define PPhosphatase2A _p[8]
#define MKP_1 _p[9]
#define PLCg_basal _p[10]
#define PLC_g _p[11]
#define Grb2 _p[12]
#define SHC _p[13]
#define Sos _p[14]
#define EGFR _p[15]
#define CaM_GEF _p[16]
#define GAP _p[17]
#define inact_GEF _p[18]
#define GDP_Ras _p[19]
#define MAPKK _p[20]
#define craf_1 _p[21]
#define MAPK _p[22]
#define PLC_Ca_Gq _p[23]
#define PLC _p[24]
#define PIP2_Ca_PLA2_p _p[25]
#define PIP2_PLA2_p _p[26]
#define PLA2_cytosolic _p[27]
#define PKC_cytosolic _p[28]
#define pERK1_2_ratio1 _p[29]
#define MAPK_out _p[30]
#define MAPK_p_out _p[31]
#define MAPK_p_p_out _p[32]
#define MAPK_p_p_cplx_out _p[33]
#define MAPK_p_p_feedback_cplx_out _p[34]
#define pERK1_2_ratio2 _p[35]
#define PKC_Ca _p[36]
#define PKC_DAG_AA_p _p[37]
#define PKC_Ca_AA_p _p[38]
#define PKC_Ca_memb_p _p[39]
#define PKC_DAG_memb_p _p[40]
#define PKC_basal_p _p[41]
#define PKC_AA_p _p[42]
#define PKC_Ca_DAG _p[43]
#define PKC_DAG _p[44]
#define PKC_DAG_AA _p[45]
#define PLA2_Ca_p _p[46]
#define DAG_Ca_PLA2_p _p[47]
#define PLA2_p_Ca _p[48]
#define PLA2_p _p[49]
#define Arachidonic_Acid _p[50]
#define PLC_Ca _p[51]
#define PLC_Gq _p[52]
#define DAG _p[53]
#define IP3 _p[54]
#define MAPK_p_p _p[55]
#define craf_1_p _p[56]
#define craf_1_p_p _p[57]
#define MAPK_p _p[58]
#define MAPKK_p_p _p[59]
#define MAPKK_p _p[60]
#define Raf_p_GTP_Ras _p[61]
#define craf_1_p_ser259 _p[62]
#define GEF_p _p[63]
#define GTP_Ras _p[64]
#define GAP_p _p[65]
#define inact_GEF_p _p[66]
#define L_EGFR _p[67]
#define Internal_L_EGFR _p[68]
#define SHC_p_Sos_Grb2 _p[69]
#define SHC_p _p[70]
#define Sos_p_Grb2 _p[71]
#define Sos_Grb2 _p[72]
#define Sos_p _p[73]
#define SHC_p_Grb2_clx _p[74]
#define PLC_g_p _p[75]
#define Ca_PLC_g _p[76]
#define Ca_PLC_g_p _p[77]
#define PKC_act_raf_cplx _p[78]
#define PKC_inact_GAP_cplx _p[79]
#define PKC_act_GEF_cplx _p[80]
#define kenz_cplx _p[81]
#define kenz_cplx_1 _p[82]
#define kenz_cplx_2 _p[83]
#define kenz_cplx_3 _p[84]
#define kenz_cplx_4 _p[85]
#define PLC_Ca_cplx _p[86]
#define PLCb_Ca_Gq_cplx _p[87]
#define MAPK_p_p_cplx _p[88]
#define MAPK_p_p_feedback_cplx _p[89]
#define phosph_Sos_cplx _p[90]
#define MAPKKtyr_cplx _p[91]
#define MAPKKthr_cplx _p[92]
#define Raf_p_GTP_Ras_1_cplx _p[93]
#define Raf_p_GTP_Ras_2_cplx _p[94]
#define basal_GEF_activity_cplx _p[95]
#define GEF_p_act_Ras_cplx _p[96]
#define GAP_inact_Ras_cplx _p[97]
#define CaM_GEF_act_Ras_cplx _p[98]
#define Ca_PLC_g_phospho_cplx _p[99]
#define SHC_phospho_cplx _p[100]
#define Sos_Ras_GEF_cplx _p[101]
#define PLC_g_phospho_cplx _p[102]
#define MKP1_tyr_deph_cplx _p[103]
#define MKP1_thr_deph_cplx _p[104]
#define craf_dephospho_cplx _p[105]
#define MAPKK_dephospho_cplx _p[106]
#define MAPKK_dephospho_ser_cplx _p[107]
#define craf_p_p_dephospho_cplx _p[108]
#define deph_raf_ser259_cplx _p[109]
#define time _p[110]
#define ReactionFlux0 _p[111]
#define ReactionFlux1 _p[112]
#define ReactionFlux2 _p[113]
#define ReactionFlux3 _p[114]
#define ReactionFlux4 _p[115]
#define ReactionFlux5 _p[116]
#define ReactionFlux6 _p[117]
#define ReactionFlux7 _p[118]
#define ReactionFlux8 _p[119]
#define ReactionFlux9 _p[120]
#define ReactionFlux10 _p[121]
#define ReactionFlux11 _p[122]
#define ReactionFlux12 _p[123]
#define ReactionFlux13 _p[124]
#define ReactionFlux14 _p[125]
#define ReactionFlux15 _p[126]
#define ReactionFlux16 _p[127]
#define ReactionFlux17 _p[128]
#define ReactionFlux18 _p[129]
#define ReactionFlux19 _p[130]
#define ReactionFlux20 _p[131]
#define ReactionFlux21 _p[132]
#define ReactionFlux22 _p[133]
#define ReactionFlux23 _p[134]
#define ReactionFlux24 _p[135]
#define ReactionFlux25 _p[136]
#define ReactionFlux26 _p[137]
#define ReactionFlux27 _p[138]
#define ReactionFlux28 _p[139]
#define ReactionFlux29 _p[140]
#define ReactionFlux30 _p[141]
#define ReactionFlux31 _p[142]
#define ReactionFlux32 _p[143]
#define ReactionFlux33 _p[144]
#define ReactionFlux34 _p[145]
#define ReactionFlux35 _p[146]
#define ReactionFlux36 _p[147]
#define ReactionFlux37 _p[148]
#define ReactionFlux38 _p[149]
#define ReactionFlux39 _p[150]
#define ReactionFlux40 _p[151]
#define ReactionFlux41 _p[152]
#define ReactionFlux42 _p[153]
#define ReactionFlux43 _p[154]
#define ReactionFlux44 _p[155]
#define ReactionFlux45 _p[156]
#define ReactionFlux46 _p[157]
#define ReactionFlux47 _p[158]
#define ReactionFlux48 _p[159]
#define ReactionFlux49 _p[160]
#define ReactionFlux50 _p[161]
#define ReactionFlux51 _p[162]
#define ReactionFlux52 _p[163]
#define ReactionFlux53 _p[164]
#define ReactionFlux54 _p[165]
#define ReactionFlux55 _p[166]
#define ReactionFlux56 _p[167]
#define ReactionFlux57 _p[168]
#define ReactionFlux58 _p[169]
#define ReactionFlux59 _p[170]
#define ReactionFlux60 _p[171]
#define ReactionFlux61 _p[172]
#define ReactionFlux62 _p[173]
#define ReactionFlux63 _p[174]
#define ReactionFlux64 _p[175]
#define ReactionFlux65 _p[176]
#define ReactionFlux66 _p[177]
#define ReactionFlux67 _p[178]
#define ReactionFlux68 _p[179]
#define ReactionFlux69 _p[180]
#define ReactionFlux70 _p[181]
#define ReactionFlux71 _p[182]
#define ReactionFlux72 _p[183]
#define ReactionFlux73 _p[184]
#define ReactionFlux74 _p[185]
#define ReactionFlux75 _p[186]
#define ReactionFlux76 _p[187]
#define ReactionFlux77 _p[188]
#define ReactionFlux78 _p[189]
#define ReactionFlux79 _p[190]
#define ReactionFlux80 _p[191]
#define ReactionFlux81 _p[192]
#define ReactionFlux82 _p[193]
#define ReactionFlux83 _p[194]
#define ReactionFlux84 _p[195]
#define ReactionFlux85 _p[196]
#define ReactionFlux86 _p[197]
#define ReactionFlux87 _p[198]
#define ReactionFlux88 _p[199]
#define ReactionFlux89 _p[200]
#define ReactionFlux90 _p[201]
#define ReactionFlux91 _p[202]
#define ReactionFlux92 _p[203]
#define ReactionFlux93 _p[204]
#define ReactionFlux94 _p[205]
#define ReactionFlux95 _p[206]
#define ReactionFlux96 _p[207]
#define ReactionFlux97 _p[208]
#define ReactionFlux98 _p[209]
#define ReactionFlux99 _p[210]
#define ReactionFlux100 _p[211]
#define ReactionFlux101 _p[212]
#define DPKC_Ca _p[213]
#define DPKC_DAG_AA_p _p[214]
#define DPKC_Ca_AA_p _p[215]
#define DPKC_Ca_memb_p _p[216]
#define DPKC_DAG_memb_p _p[217]
#define DPKC_basal_p _p[218]
#define DPKC_AA_p _p[219]
#define DPKC_Ca_DAG _p[220]
#define DPKC_DAG _p[221]
#define DPKC_DAG_AA _p[222]
#define DPLA2_Ca_p _p[223]
#define DDAG_Ca_PLA2_p _p[224]
#define DPLA2_p_Ca _p[225]
#define DPLA2_p _p[226]
#define DArachidonic_Acid _p[227]
#define DPLC_Ca _p[228]
#define DPLC_Gq _p[229]
#define DDAG _p[230]
#define DIP3 _p[231]
#define DMAPK_p_p _p[232]
#define Dcraf_1_p _p[233]
#define Dcraf_1_p_p _p[234]
#define DMAPK_p _p[235]
#define DMAPKK_p_p _p[236]
#define DMAPKK_p _p[237]
#define DRaf_p_GTP_Ras _p[238]
#define Dcraf_1_p_ser259 _p[239]
#define DGEF_p _p[240]
#define DGTP_Ras _p[241]
#define DGAP_p _p[242]
#define Dinact_GEF_p _p[243]
#define DL_EGFR _p[244]
#define DInternal_L_EGFR _p[245]
#define DSHC_p_Sos_Grb2 _p[246]
#define DSHC_p _p[247]
#define DSos_p_Grb2 _p[248]
#define DSos_Grb2 _p[249]
#define DSos_p _p[250]
#define DSHC_p_Grb2_clx _p[251]
#define DPLC_g_p _p[252]
#define DCa_PLC_g _p[253]
#define DCa_PLC_g_p _p[254]
#define DPKC_act_raf_cplx _p[255]
#define DPKC_inact_GAP_cplx _p[256]
#define DPKC_act_GEF_cplx _p[257]
#define Dkenz_cplx _p[258]
#define Dkenz_cplx_1 _p[259]
#define Dkenz_cplx_2 _p[260]
#define Dkenz_cplx_3 _p[261]
#define Dkenz_cplx_4 _p[262]
#define DPLC_Ca_cplx _p[263]
#define DPLCb_Ca_Gq_cplx _p[264]
#define DMAPK_p_p_cplx _p[265]
#define DMAPK_p_p_feedback_cplx _p[266]
#define Dphosph_Sos_cplx _p[267]
#define DMAPKKtyr_cplx _p[268]
#define DMAPKKthr_cplx _p[269]
#define DRaf_p_GTP_Ras_1_cplx _p[270]
#define DRaf_p_GTP_Ras_2_cplx _p[271]
#define Dbasal_GEF_activity_cplx _p[272]
#define DGEF_p_act_Ras_cplx _p[273]
#define DGAP_inact_Ras_cplx _p[274]
#define DCaM_GEF_act_Ras_cplx _p[275]
#define DCa_PLC_g_phospho_cplx _p[276]
#define DSHC_phospho_cplx _p[277]
#define DSos_Ras_GEF_cplx _p[278]
#define DPLC_g_phospho_cplx _p[279]
#define DMKP1_tyr_deph_cplx _p[280]
#define DMKP1_thr_deph_cplx _p[281]
#define Dcraf_dephospho_cplx _p[282]
#define DMAPKK_dephospho_cplx _p[283]
#define DMAPKK_dephospho_ser_cplx _p[284]
#define Dcraf_p_p_dephospho_cplx _p[285]
#define Ddeph_raf_ser259_cplx _p[286]
#define v _p[287]
#define _g _p[288]
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 
#if defined(__cplusplus)
extern "C" {
#endif
 static int hoc_nrnpointerindex =  -1;
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 /* declaration of user functions */
 static void _hoc_assign_calculated_values(void);
 static void _hoc_observables_func(void);
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 
#define NMODL_TEXT 1
#if NMODL_TEXT
static const char* nmodl_file_text;
static const char* nmodl_filename;
extern void hoc_reg_nmodl_text(int, const char*);
extern void hoc_reg_nmodl_filename(int, const char*);
#endif

 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_SBTAB_Findsim", _hoc_setdata,
 "assign_calculated_values_SBTAB_Findsim", _hoc_assign_calculated_values,
 "observables_func_SBTAB_Findsim", _hoc_observables_func,
 0, 0
};
 /* declare global and static user variables */
#define CaM_GEF_ConservedConst CaM_GEF_ConservedConst_SBTAB_Findsim
 double CaM_GEF_ConservedConst = 0;
#define EGFR_ConservedConst EGFR_ConservedConst_SBTAB_Findsim
 double EGFR_ConservedConst = 0.00016666;
#define GDP_Ras_ConservedConst GDP_Ras_ConservedConst_SBTAB_Findsim
 double GDP_Ras_ConservedConst = 0.0005;
#define GAP_ConservedConst GAP_ConservedConst_SBTAB_Findsim
 double GAP_ConservedConst = 2e-005;
#define Grb2_ConservedConst Grb2_ConservedConst_SBTAB_Findsim
 double Grb2_ConservedConst = 0.0009;
#define MAPK_ConservedConst MAPK_ConservedConst_SBTAB_Findsim
 double MAPK_ConservedConst = 0.00036;
#define MAPKK_ConservedConst MAPKK_ConservedConst_SBTAB_Findsim
 double MAPKK_ConservedConst = 0.00018001;
#define MKP_1_ConservedConst MKP_1_ConservedConst_SBTAB_Findsim
 double MKP_1_ConservedConst = 2e-005;
#define PKC_cytosolic_ConservedConst PKC_cytosolic_ConservedConst_SBTAB_Findsim
 double PKC_cytosolic_ConservedConst = 0.00102;
#define PLA2_cytosolic_ConservedConst PLA2_cytosolic_ConservedConst_SBTAB_Findsim
 double PLA2_cytosolic_ConservedConst = 0.0004;
#define PIP2_PLA2_p_ConservedConst PIP2_PLA2_p_ConservedConst_SBTAB_Findsim
 double PIP2_PLA2_p_ConservedConst = 0;
#define PIP2_Ca_PLA2_p_ConservedConst PIP2_Ca_PLA2_p_ConservedConst_SBTAB_Findsim
 double PIP2_Ca_PLA2_p_ConservedConst = 0;
#define PLC_ConservedConst PLC_ConservedConst_SBTAB_Findsim
 double PLC_ConservedConst = 0.0008;
#define PLC_Ca_Gq_ConservedConst PLC_Ca_Gq_ConservedConst_SBTAB_Findsim
 double PLC_Ca_Gq_ConservedConst = 0;
#define PLC_g_ConservedConst PLC_g_ConservedConst_SBTAB_Findsim
 double PLC_g_ConservedConst = 0.00082001;
#define PLCg_basal_ConservedConst PLCg_basal_ConservedConst_SBTAB_Findsim
 double PLCg_basal_ConservedConst = 7.0002e-007;
#define PPhosphatase2A_ConservedConst PPhosphatase2A_ConservedConst_SBTAB_Findsim
 double PPhosphatase2A_ConservedConst = 0.00026001;
#define Sos_ConservedConst Sos_ConservedConst_SBTAB_Findsim
 double Sos_ConservedConst = 0.0001;
#define SHC_ConservedConst SHC_ConservedConst_SBTAB_Findsim
 double SHC_ConservedConst = 0.00040001;
#define craf_1_ConservedConst craf_1_ConservedConst_SBTAB_Findsim
 double craf_1_ConservedConst = -0.0003;
#define inact_GEF_ConservedConst inact_GEF_ConservedConst_SBTAB_Findsim
 double inact_GEF_ConservedConst = 0.0001;
#define kf_R102 kf_R102_SBTAB_Findsim
 double kf_R102 = 5.99998;
#define kr_R101 kr_R101_SBTAB_Findsim
 double kr_R101 = 23.9994;
#define kf_R101 kf_R101_SBTAB_Findsim
 double kf_R101 = 1806.34;
#define kf_R100 kf_R100_SBTAB_Findsim
 double kf_R100 = 5.99998;
#define kr_R99 kr_R99_SBTAB_Findsim
 double kr_R99 = 24.9977;
#define kf_R99 kf_R99_SBTAB_Findsim
 double kf_R99 = 1866.81;
#define kf_R98 kf_R98_SBTAB_Findsim
 double kf_R98 = 5.99998;
#define kr_R97 kr_R97_SBTAB_Findsim
 double kr_R97 = 24.9977;
#define kf_R97 kf_R97_SBTAB_Findsim
 double kf_R97 = 1866.81;
#define kf_R96 kf_R96_SBTAB_Findsim
 double kf_R96 = 5.99998;
#define kr_R95 kr_R95_SBTAB_Findsim
 double kr_R95 = 24.9977;
#define kf_R95 kf_R95_SBTAB_Findsim
 double kf_R95 = 1866.81;
#define kf_R94 kf_R94_SBTAB_Findsim
 double kf_R94 = 5.99998;
#define kr_R93 kr_R93_SBTAB_Findsim
 double kr_R93 = 24.9977;
#define kf_R93 kf_R93_SBTAB_Findsim
 double kf_R93 = 1866.81;
#define kf_R92 kf_R92_SBTAB_Findsim
 double kf_R92 = 4;
#define kr_R91 kr_R91_SBTAB_Findsim
 double kr_R91 = 15.9993;
#define kf_R91 kf_R91_SBTAB_Findsim
 double kf_R91 = 2714.56;
#define kf_R90 kf_R90_SBTAB_Findsim
 double kf_R90 = 4;
#define kr_R89 kr_R89_SBTAB_Findsim
 double kr_R89 = 15.9993;
#define kf_R89 kf_R89_SBTAB_Findsim
 double kf_R89 = 2714.56;
#define kf_R88 kf_R88_SBTAB_Findsim
 double kf_R88 = 0.5;
#define kr_R87 kr_R87_SBTAB_Findsim
 double kr_R87 = 2;
#define kf_R87 kf_R87_SBTAB_Findsim
 double kf_R87 = 7972.6;
#define kr_R86 kr_R86_SBTAB_Findsim
 double kr_R86 = 57.0033;
#define kf_R86 kf_R86_SBTAB_Findsim
 double kf_R86 = 0.0197925;
#define kr_R85 kr_R85_SBTAB_Findsim
 double kr_R85 = 13.9991;
#define kf_R85 kf_R85_SBTAB_Findsim
 double kf_R85 = 0.0972299;
#define kf_R84 kf_R84_SBTAB_Findsim
 double kf_R84 = 0.2;
#define kr_R83 kr_R83_SBTAB_Findsim
 double kr_R83 = 0.8;
#define kf_R83 kf_R83_SBTAB_Findsim
 double kf_R83 = 1866.81;
#define kf_R82 kf_R82_SBTAB_Findsim
 double kf_R82 = 0.2;
#define kr_R81 kr_R81_SBTAB_Findsim
 double kr_R81 = 0.8;
#define kf_R81 kf_R81_SBTAB_Findsim
 double kf_R81 = 1131.36;
#define kf_R80 kf_R80_SBTAB_Findsim
 double kf_R80 = 0.2;
#define kr_R79 kr_R79_SBTAB_Findsim
 double kr_R79 = 0.8;
#define kf_R79 kf_R79_SBTAB_Findsim
 double kf_R79 = 2828.13;
#define kf_R78 kf_R78_SBTAB_Findsim
 double kf_R78 = 0.2;
#define kr_R77 kr_R77_SBTAB_Findsim
 double kr_R77 = 0.8;
#define kf_R77 kf_R77_SBTAB_Findsim
 double kf_R77 = 1866.81;
#define kf_R76 kf_R76_SBTAB_Findsim
 double kf_R76 = 10;
#define kr_R75 kr_R75_SBTAB_Findsim
 double kr_R75 = 40.0037;
#define kf_R75 kf_R75_SBTAB_Findsim
 double kf_R75 = 46655.2;
#define kf_R74 kf_R74_SBTAB_Findsim
 double kf_R74 = 0.0199986;
#define kr_R73 kr_R73_SBTAB_Findsim
 double kr_R73 = 0.0800018;
#define kf_R73 kf_R73_SBTAB_Findsim
 double kf_R73 = 186.681;
#define kf_R72 kf_R72_SBTAB_Findsim
 double kf_R72 = 0.0199986;
#define kr_R71 kr_R71_SBTAB_Findsim
 double kr_R71 = 0.0800018;
#define kf_R71 kf_R71_SBTAB_Findsim
 double kf_R71 = 9.47196;
#define kf_R70 kf_R70_SBTAB_Findsim
 double kf_R70 = 0.299999;
#define kr_R69 kr_R69_SBTAB_Findsim
 double kr_R69 = 1.2;
#define kf_R69 kf_R69_SBTAB_Findsim
 double kf_R69 = 8887.92;
#define kf_R68 kf_R68_SBTAB_Findsim
 double kf_R68 = 0.299999;
#define kr_R67 kr_R67_SBTAB_Findsim
 double kr_R67 = 1.2;
#define kf_R67 kf_R67_SBTAB_Findsim
 double kf_R67 = 8887.92;
#define kf_R66 kf_R66_SBTAB_Findsim
 double kf_R66 = 0.15;
#define kr_R65 kr_R65_SBTAB_Findsim
 double kr_R65 = 0.599998;
#define kf_R65 kf_R65_SBTAB_Findsim
 double kf_R65 = 15272.1;
#define kf_R64 kf_R64_SBTAB_Findsim
 double kf_R64 = 0.15;
#define kr_R63 kr_R63_SBTAB_Findsim
 double kr_R63 = 0.599998;
#define kf_R63 kf_R63_SBTAB_Findsim
 double kf_R63 = 15272.1;
#define kf_R62 kf_R62_SBTAB_Findsim
 double kf_R62 = 10;
#define kr_R61 kr_R61_SBTAB_Findsim
 double kr_R61 = 40.0037;
#define kf_R61 kf_R61_SBTAB_Findsim
 double kf_R61 = 18382.3;
#define kf_R60 kf_R60_SBTAB_Findsim
 double kf_R60 = 10;
#define kr_R59 kr_R59_SBTAB_Findsim
 double kr_R59 = 40.0037;
#define kf_R59 kf_R59_SBTAB_Findsim
 double kf_R59 = 1838.23;
#define kf_R58 kf_R58_SBTAB_Findsim
 double kf_R58 = 19.9986;
#define kr_R57 kr_R57_SBTAB_Findsim
 double kr_R57 = 80.0018;
#define kf_R57 kf_R57_SBTAB_Findsim
 double kf_R57 = 3677.05;
#define kf_R56 kf_R56_SBTAB_Findsim
 double kf_R56 = 47.9954;
#define kr_R55 kr_R55_SBTAB_Findsim
 double kr_R55 = 191.999;
#define kf_R55 kf_R55_SBTAB_Findsim
 double kf_R55 = 45248.1;
#define kf_R54 kf_R54_SBTAB_Findsim
 double kf_R54 = 10;
#define kr_R53 kr_R53_SBTAB_Findsim
 double kr_R53 = 40.0037;
#define kf_R53 kf_R53_SBTAB_Findsim
 double kf_R53 = 2375.75;
#define kf_R52 kf_R52_SBTAB_Findsim
 double kf_R52 = 120.005;
#define kr_R51 kr_R51_SBTAB_Findsim
 double kr_R51 = 479.954;
#define kf_R51 kf_R51_SBTAB_Findsim
 double kf_R51 = 28281.3;
#define kf_R50 kf_R50_SBTAB_Findsim
 double kf_R50 = 60.0067;
#define kr_R49 kr_R49_SBTAB_Findsim
 double kr_R49 = 239.994;
#define kf_R49 kf_R49_SBTAB_Findsim
 double kf_R49 = 14141.6;
#define kf_R48 kf_R48_SBTAB_Findsim
 double kf_R48 = 35.9998;
#define kr_R47 kr_R47_SBTAB_Findsim
 double kr_R47 = 144.012;
#define kf_R47 kf_R47_SBTAB_Findsim
 double kf_R47 = 8483.99;
#define kf_R46 kf_R46_SBTAB_Findsim
 double kf_R46 = 11.0408;
#define kr_R45 kr_R45_SBTAB_Findsim
 double kr_R45 = 44.157;
#define kf_R45 kf_R45_SBTAB_Findsim
 double kf_R45 = 2601.96;
#define kf_R44 kf_R44_SBTAB_Findsim
 double kf_R44 = 5.39995;
#define kr_R43 kr_R43_SBTAB_Findsim
 double kr_R43 = 21.6023;
#define kf_R43 kf_R43_SBTAB_Findsim
 double kf_R43 = 1272.62;
#define kf_R42 kf_R42_SBTAB_Findsim
 double kf_R42 = 4;
#define kr_R41 kr_R41_SBTAB_Findsim
 double kr_R41 = 15.9993;
#define kf_R41 kf_R41_SBTAB_Findsim
 double kf_R41 = 5657.18;
#define kf_R40 kf_R40_SBTAB_Findsim
 double kf_R40 = 4;
#define kr_R39 kr_R39_SBTAB_Findsim
 double kr_R39 = 15.9993;
#define kf_R39 kf_R39_SBTAB_Findsim
 double kf_R39 = 5657.18;
#define kf_R38 kf_R38_SBTAB_Findsim
 double kf_R38 = 4;
#define kr_R37 kr_R37_SBTAB_Findsim
 double kr_R37 = 15.9993;
#define kf_R37 kf_R37_SBTAB_Findsim
 double kf_R37 = 949.73;
#define kf_R36 kf_R36_SBTAB_Findsim
 double kf_R36 = 0.0700003;
#define kf_R35 kf_R35_SBTAB_Findsim
 double kf_R35 = 0.0500035;
#define kr_R34 kr_R34_SBTAB_Findsim
 double kr_R34 = 10;
#define kf_R34 kf_R34_SBTAB_Findsim
 double kf_R34 = 12000.5;
#define kr_R33 kr_R33_SBTAB_Findsim
 double kr_R33 = 10;
#define kf_R33 kf_R33_SBTAB_Findsim
 double kf_R33 = 180011;
#define kr_R32 kr_R32_SBTAB_Findsim
 double kr_R32 = 1;
#define kf_R32 kf_R32_SBTAB_Findsim
 double kf_R32 = 1000;
#define kr_R31 kr_R31_SBTAB_Findsim
 double kr_R31 = 0.0167996;
#define kf_R31 kf_R31_SBTAB_Findsim
 double kf_R31 = 24.9977;
#define kf_R30 kf_R30_SBTAB_Findsim
 double kf_R30 = 0.001;
#define kr_R29 kr_R29_SBTAB_Findsim
 double kr_R29 = 0.0167996;
#define kf_R29 kf_R29_SBTAB_Findsim
 double kf_R29 = 24.9977;
#define kr_R28 kr_R28_SBTAB_Findsim
 double kr_R28 = 0.1;
#define kf_R28 kf_R28_SBTAB_Findsim
 double kf_R28 = 500.035;
#define kf_R27 kf_R27_SBTAB_Findsim
 double kf_R27 = 0.2;
#define kr_R26 kr_R26_SBTAB_Findsim
 double kr_R26 = 0.000329989;
#define kf_R26 kf_R26_SBTAB_Findsim
 double kf_R26 = 0.00199986;
#define kr_R25 kr_R25_SBTAB_Findsim
 double kr_R25 = 0.25;
#define kf_R25 kf_R25_SBTAB_Findsim
 double kf_R25 = 4199.52;
#define kf_R24 kf_R24_SBTAB_Findsim
 double kf_R24 = 1;
#define kf_R23 kf_R23_SBTAB_Findsim
 double kf_R23 = 0.1;
#define kf_R22 kf_R22_SBTAB_Findsim
 double kf_R22 = 0.0001;
#define kf_R21 kf_R21_SBTAB_Findsim
 double kf_R21 = 1;
#define kr_R20 kr_R20_SBTAB_Findsim
 double kr_R20 = 0.5;
#define kf_R20 kf_R20_SBTAB_Findsim
 double kf_R20 = 10000;
#define kr_R19 kr_R19_SBTAB_Findsim
 double kr_R19 = 1;
#define kf_R19 kf_R19_SBTAB_Findsim
 double kf_R19 = 29998.5;
#define kf_R18 kf_R18_SBTAB_Findsim
 double kf_R18 = 0.15;
#define kf_R17 kf_R17_SBTAB_Findsim
 double kf_R17 = 2.5;
#define kr_R16 kr_R16_SBTAB_Findsim
 double kr_R16 = 1;
#define kf_R16 kf_R16_SBTAB_Findsim
 double kf_R16 = 2999.85;
#define kf_R15 kf_R15_SBTAB_Findsim
 double kf_R15 = 0.17;
#define kr_R14 kr_R14_SBTAB_Findsim
 double kr_R14 = 0.1;
#define kf_R14 kf_R14_SBTAB_Findsim
 double kf_R14 = 5999.29;
#define kf_R13 kf_R13_SBTAB_Findsim
 double kf_R13 = 0.4;
#define kr_R12 kr_R12_SBTAB_Findsim
 double kr_R12 = 4;
#define kf_R12 kf_R12_SBTAB_Findsim
 double kf_R12 = 2.99999;
#define kr_R11 kr_R11_SBTAB_Findsim
 double kr_R11 = 0.1;
#define kf_R11 kf_R11_SBTAB_Findsim
 double kf_R11 = 1000;
#define kr_R10 kr_R10_SBTAB_Findsim
 double kr_R10 = 2;
#define kf_R10 kf_R10_SBTAB_Findsim
 double kf_R10 = 18.0011;
#define kr_R9 kr_R9_SBTAB_Findsim
 double kr_R9 = 0.1;
#define kf_R9 kf_R9_SBTAB_Findsim
 double kf_R9 = 0.599998;
#define kr_R8 kr_R8_SBTAB_Findsim
 double kr_R8 = 0.1;
#define kf_R8 kf_R8_SBTAB_Findsim
 double kf_R8 = 0.12;
#define kr_R7 kr_R7_SBTAB_Findsim
 double kr_R7 = 50.0035;
#define kf_R7 kf_R7_SBTAB_Findsim
 double kf_R7 = 1;
#define kr_R6 kr_R6_SBTAB_Findsim
 double kr_R6 = 0.2;
#define kf_R6 kf_R6_SBTAB_Findsim
 double kf_R6 = 2;
#define kr_R5 kr_R5_SBTAB_Findsim
 double kr_R5 = 0.1;
#define kf_R5 kf_R5_SBTAB_Findsim
 double kf_R5 = 1.20001;
#define kr_R4 kr_R4_SBTAB_Findsim
 double kr_R4 = 0.1;
#define kf_R4 kf_R4_SBTAB_Findsim
 double kf_R4 = 1;
#define kr_R3 kr_R3_SBTAB_Findsim
 double kr_R3 = 3.5026;
#define kf_R3 kf_R3_SBTAB_Findsim
 double kf_R3 = 1.27049;
#define kr_R2 kr_R2_SBTAB_Findsim
 double kr_R2 = 8.63475;
#define kf_R2 kf_R2_SBTAB_Findsim
 double kf_R2 = 7.99982;
#define kr_R1 kr_R1_SBTAB_Findsim
 double kr_R1 = 0.5;
#define kf_R1 kf_R1_SBTAB_Findsim
 double kf_R1 = 599.929;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "kf_R1_SBTAB_Findsim", "liter/millimole-second",
 "kr_R1_SBTAB_Findsim", "/second",
 "kf_R2_SBTAB_Findsim", "liter/millimole-second",
 "kr_R2_SBTAB_Findsim", "/second",
 "kf_R3_SBTAB_Findsim", "/second",
 "kr_R3_SBTAB_Findsim", "/second",
 "kf_R4_SBTAB_Findsim", "/second",
 "kr_R4_SBTAB_Findsim", "/second",
 "kf_R5_SBTAB_Findsim", "liter/millimole-second",
 "kr_R5_SBTAB_Findsim", "/second",
 "kf_R6_SBTAB_Findsim", "/second",
 "kr_R6_SBTAB_Findsim", "/second",
 "kf_R7_SBTAB_Findsim", "/second",
 "kr_R7_SBTAB_Findsim", "/second",
 "kf_R8_SBTAB_Findsim", "liter/millimole-second",
 "kr_R8_SBTAB_Findsim", "/second",
 "kf_R9_SBTAB_Findsim", "liter/millimole-second",
 "kr_R9_SBTAB_Findsim", "/second",
 "kf_R10_SBTAB_Findsim", "liter/millimole-second",
 "kr_R10_SBTAB_Findsim", "/second",
 "kf_R11_SBTAB_Findsim", "liter/millimole-second",
 "kr_R11_SBTAB_Findsim", "/second",
 "kf_R12_SBTAB_Findsim", "liter/millimole-second",
 "kr_R12_SBTAB_Findsim", "/second",
 "kf_R13_SBTAB_Findsim", "/second",
 "kf_R14_SBTAB_Findsim", "liter/millimole-second",
 "kr_R14_SBTAB_Findsim", "/second",
 "kf_R15_SBTAB_Findsim", "/second",
 "kf_R16_SBTAB_Findsim", "liter/millimole-second",
 "kr_R16_SBTAB_Findsim", "/second",
 "kf_R17_SBTAB_Findsim", "/second",
 "kf_R18_SBTAB_Findsim", "/second",
 "kf_R19_SBTAB_Findsim", "liter/millimole-second",
 "kr_R19_SBTAB_Findsim", "/second",
 "kf_R20_SBTAB_Findsim", "liter/millimole-second",
 "kr_R20_SBTAB_Findsim", "/second",
 "kf_R21_SBTAB_Findsim", "/second",
 "kf_R22_SBTAB_Findsim", "/second",
 "kf_R23_SBTAB_Findsim", "/second",
 "kf_R24_SBTAB_Findsim", "/second",
 "kf_R25_SBTAB_Findsim", "liter/millimole-second",
 "kr_R25_SBTAB_Findsim", "/second",
 "kf_R26_SBTAB_Findsim", "/second",
 "kr_R26_SBTAB_Findsim", "/second",
 "kf_R27_SBTAB_Findsim", "/second",
 "kf_R28_SBTAB_Findsim", "liter/millimole-second",
 "kr_R28_SBTAB_Findsim", "/second",
 "kf_R29_SBTAB_Findsim", "liter/millimole-second",
 "kr_R29_SBTAB_Findsim", "/second",
 "kf_R30_SBTAB_Findsim", "/second",
 "kf_R31_SBTAB_Findsim", "liter/millimole-second",
 "kr_R31_SBTAB_Findsim", "/second",
 "kf_R32_SBTAB_Findsim", "liter/millimole-second",
 "kr_R32_SBTAB_Findsim", "/second",
 "kf_R33_SBTAB_Findsim", "liter/millimole-second",
 "kr_R33_SBTAB_Findsim", "/second",
 "kf_R34_SBTAB_Findsim", "liter/millimole-second",
 "kr_R34_SBTAB_Findsim", "/second",
 "kf_R35_SBTAB_Findsim", "/second",
 "kf_R36_SBTAB_Findsim", "/second",
 "kf_R37_SBTAB_Findsim", "liter/millimole-second",
 "kr_R37_SBTAB_Findsim", "/second",
 "kf_R38_SBTAB_Findsim", "/second",
 "kf_R39_SBTAB_Findsim", "liter/millimole-second",
 "kr_R39_SBTAB_Findsim", "/second",
 "kf_R40_SBTAB_Findsim", "/second",
 "kf_R41_SBTAB_Findsim", "liter/millimole-second",
 "kr_R41_SBTAB_Findsim", "/second",
 "kf_R42_SBTAB_Findsim", "/second",
 "kf_R43_SBTAB_Findsim", "liter/millimole-second",
 "kr_R43_SBTAB_Findsim", "/second",
 "kf_R44_SBTAB_Findsim", "/second",
 "kf_R45_SBTAB_Findsim", "liter/millimole-second",
 "kr_R45_SBTAB_Findsim", "/second",
 "kf_R46_SBTAB_Findsim", "/second",
 "kf_R47_SBTAB_Findsim", "liter/millimole-second",
 "kr_R47_SBTAB_Findsim", "/second",
 "kf_R48_SBTAB_Findsim", "/second",
 "kf_R49_SBTAB_Findsim", "liter/millimole-second",
 "kr_R49_SBTAB_Findsim", "/second",
 "kf_R50_SBTAB_Findsim", "/second",
 "kf_R51_SBTAB_Findsim", "liter/millimole-second",
 "kr_R51_SBTAB_Findsim", "/second",
 "kf_R52_SBTAB_Findsim", "/second",
 "kf_R53_SBTAB_Findsim", "liter/millimole-second",
 "kr_R53_SBTAB_Findsim", "/second",
 "kf_R54_SBTAB_Findsim", "/second",
 "kf_R55_SBTAB_Findsim", "liter/millimole-second",
 "kr_R55_SBTAB_Findsim", "/second",
 "kf_R56_SBTAB_Findsim", "/second",
 "kf_R57_SBTAB_Findsim", "liter/millimole-second",
 "kr_R57_SBTAB_Findsim", "/second",
 "kf_R58_SBTAB_Findsim", "/second",
 "kf_R59_SBTAB_Findsim", "liter/millimole-second",
 "kr_R59_SBTAB_Findsim", "/second",
 "kf_R60_SBTAB_Findsim", "/second",
 "kf_R61_SBTAB_Findsim", "liter/millimole-second",
 "kr_R61_SBTAB_Findsim", "/second",
 "kf_R62_SBTAB_Findsim", "/second",
 "kf_R63_SBTAB_Findsim", "liter/millimole-second",
 "kr_R63_SBTAB_Findsim", "/second",
 "kf_R64_SBTAB_Findsim", "/second",
 "kf_R65_SBTAB_Findsim", "liter/millimole-second",
 "kr_R65_SBTAB_Findsim", "/second",
 "kf_R66_SBTAB_Findsim", "/second",
 "kf_R67_SBTAB_Findsim", "liter/millimole-second",
 "kr_R67_SBTAB_Findsim", "/second",
 "kf_R68_SBTAB_Findsim", "/second",
 "kf_R69_SBTAB_Findsim", "liter/millimole-second",
 "kr_R69_SBTAB_Findsim", "/second",
 "kf_R70_SBTAB_Findsim", "/second",
 "kf_R71_SBTAB_Findsim", "liter/millimole-second",
 "kr_R71_SBTAB_Findsim", "/second",
 "kf_R72_SBTAB_Findsim", "/second",
 "kf_R73_SBTAB_Findsim", "liter/millimole-second",
 "kr_R73_SBTAB_Findsim", "/second",
 "kf_R74_SBTAB_Findsim", "/second",
 "kf_R75_SBTAB_Findsim", "liter/millimole-second",
 "kr_R75_SBTAB_Findsim", "/second",
 "kf_R76_SBTAB_Findsim", "/second",
 "kf_R77_SBTAB_Findsim", "liter/millimole-second",
 "kr_R77_SBTAB_Findsim", "/second",
 "kf_R78_SBTAB_Findsim", "/second",
 "kf_R79_SBTAB_Findsim", "liter/millimole-second",
 "kr_R79_SBTAB_Findsim", "/second",
 "kf_R80_SBTAB_Findsim", "/second",
 "kf_R81_SBTAB_Findsim", "liter/millimole-second",
 "kr_R81_SBTAB_Findsim", "/second",
 "kf_R82_SBTAB_Findsim", "/second",
 "kf_R83_SBTAB_Findsim", "liter/millimole-second",
 "kr_R83_SBTAB_Findsim", "/second",
 "kf_R84_SBTAB_Findsim", "/second",
 "kf_R85_SBTAB_Findsim", "/second",
 "kr_R85_SBTAB_Findsim", "millimole/liter",
 "kf_R86_SBTAB_Findsim", "/second",
 "kr_R86_SBTAB_Findsim", "millimole/liter",
 "kf_R87_SBTAB_Findsim", "liter/millimole-second",
 "kr_R87_SBTAB_Findsim", "/second",
 "kf_R88_SBTAB_Findsim", "/second",
 "kf_R89_SBTAB_Findsim", "liter/millimole-second",
 "kr_R89_SBTAB_Findsim", "/second",
 "kf_R90_SBTAB_Findsim", "/second",
 "kf_R91_SBTAB_Findsim", "liter/millimole-second",
 "kr_R91_SBTAB_Findsim", "/second",
 "kf_R92_SBTAB_Findsim", "/second",
 "kf_R93_SBTAB_Findsim", "liter/millimole-second",
 "kr_R93_SBTAB_Findsim", "/second",
 "kf_R94_SBTAB_Findsim", "/second",
 "kf_R95_SBTAB_Findsim", "liter/millimole-second",
 "kr_R95_SBTAB_Findsim", "/second",
 "kf_R96_SBTAB_Findsim", "/second",
 "kf_R97_SBTAB_Findsim", "liter/millimole-second",
 "kr_R97_SBTAB_Findsim", "/second",
 "kf_R98_SBTAB_Findsim", "/second",
 "kf_R99_SBTAB_Findsim", "liter/millimole-second",
 "kr_R99_SBTAB_Findsim", "/second",
 "kf_R100_SBTAB_Findsim", "/second",
 "kf_R101_SBTAB_Findsim", "liter/millimole-second",
 "kr_R101_SBTAB_Findsim", "/second",
 "kf_R102_SBTAB_Findsim", "/second",
 "PKC_Ca_SBTAB_Findsim", "millimole/litre",
 "PKC_DAG_AA_p_SBTAB_Findsim", "millimole/litre",
 "PKC_Ca_AA_p_SBTAB_Findsim", "millimole/litre",
 "PKC_Ca_memb_p_SBTAB_Findsim", "millimole/litre",
 "PKC_DAG_memb_p_SBTAB_Findsim", "millimole/litre",
 "PKC_basal_p_SBTAB_Findsim", "millimole/litre",
 "PKC_AA_p_SBTAB_Findsim", "millimole/litre",
 "PKC_Ca_DAG_SBTAB_Findsim", "millimole/litre",
 "PKC_DAG_SBTAB_Findsim", "millimole/litre",
 "PKC_DAG_AA_SBTAB_Findsim", "millimole/litre",
 "PLA2_Ca_p_SBTAB_Findsim", "millimole/litre",
 "DAG_Ca_PLA2_p_SBTAB_Findsim", "millimole/litre",
 "PLA2_p_Ca_SBTAB_Findsim", "millimole/litre",
 "PLA2_p_SBTAB_Findsim", "millimole/litre",
 "Arachidonic_Acid_SBTAB_Findsim", "millimole/litre",
 "PLC_Ca_SBTAB_Findsim", "millimole/litre",
 "PLC_Gq_SBTAB_Findsim", "millimole/litre",
 "DAG_SBTAB_Findsim", "millimole/litre",
 "IP3_SBTAB_Findsim", "millimole/litre",
 "MAPK_p_p_SBTAB_Findsim", "millimole/litre",
 "craf_1_p_SBTAB_Findsim", "millimole/litre",
 "craf_1_p_p_SBTAB_Findsim", "millimole/litre",
 "MAPK_p_SBTAB_Findsim", "millimole/litre",
 "MAPKK_p_p_SBTAB_Findsim", "millimole/litre",
 "MAPKK_p_SBTAB_Findsim", "millimole/litre",
 "Raf_p_GTP_Ras_SBTAB_Findsim", "millimole/litre",
 "craf_1_p_ser259_SBTAB_Findsim", "millimole/litre",
 "GEF_p_SBTAB_Findsim", "millimole/litre",
 "GTP_Ras_SBTAB_Findsim", "millimole/litre",
 "GAP_p_SBTAB_Findsim", "millimole/litre",
 "inact_GEF_p_SBTAB_Findsim", "millimole/litre",
 "L_EGFR_SBTAB_Findsim", "millimole/litre",
 "Internal_L_EGFR_SBTAB_Findsim", "millimole/litre",
 "SHC_p_Sos_Grb2_SBTAB_Findsim", "millimole/litre",
 "SHC_p_SBTAB_Findsim", "millimole/litre",
 "Sos_p_Grb2_SBTAB_Findsim", "millimole/litre",
 "Sos_Grb2_SBTAB_Findsim", "millimole/litre",
 "Sos_p_SBTAB_Findsim", "millimole/litre",
 "SHC_p_Grb2_clx_SBTAB_Findsim", "millimole/litre",
 "PLC_g_p_SBTAB_Findsim", "millimole/litre",
 "Ca_PLC_g_SBTAB_Findsim", "millimole/litre",
 "Ca_PLC_g_p_SBTAB_Findsim", "millimole/litre",
 "PKC_act_raf_cplx_SBTAB_Findsim", "millimole/litre",
 "PKC_inact_GAP_cplx_SBTAB_Findsim", "millimole/litre",
 "PKC_act_GEF_cplx_SBTAB_Findsim", "millimole/litre",
 "kenz_cplx_SBTAB_Findsim", "millimole/litre",
 "kenz_cplx_1_SBTAB_Findsim", "millimole/litre",
 "kenz_cplx_2_SBTAB_Findsim", "millimole/litre",
 "kenz_cplx_3_SBTAB_Findsim", "millimole/litre",
 "kenz_cplx_4_SBTAB_Findsim", "millimole/litre",
 "PLC_Ca_cplx_SBTAB_Findsim", "millimole/litre",
 "PLCb_Ca_Gq_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPK_p_p_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPK_p_p_feedback_cplx_SBTAB_Findsim", "millimole/litre",
 "phosph_Sos_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPKKtyr_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPKKthr_cplx_SBTAB_Findsim", "millimole/litre",
 "Raf_p_GTP_Ras_1_cplx_SBTAB_Findsim", "millimole/litre",
 "Raf_p_GTP_Ras_2_cplx_SBTAB_Findsim", "millimole/litre",
 "basal_GEF_activity_cplx_SBTAB_Findsim", "millimole/litre",
 "GEF_p_act_Ras_cplx_SBTAB_Findsim", "millimole/litre",
 "GAP_inact_Ras_cplx_SBTAB_Findsim", "millimole/litre",
 "CaM_GEF_act_Ras_cplx_SBTAB_Findsim", "millimole/litre",
 "Ca_PLC_g_phospho_cplx_SBTAB_Findsim", "millimole/litre",
 "SHC_phospho_cplx_SBTAB_Findsim", "millimole/litre",
 "Sos_Ras_GEF_cplx_SBTAB_Findsim", "millimole/litre",
 "PLC_g_phospho_cplx_SBTAB_Findsim", "millimole/litre",
 "MKP1_tyr_deph_cplx_SBTAB_Findsim", "millimole/litre",
 "MKP1_thr_deph_cplx_SBTAB_Findsim", "millimole/litre",
 "craf_dephospho_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPKK_dephospho_cplx_SBTAB_Findsim", "millimole/litre",
 "MAPKK_dephospho_ser_cplx_SBTAB_Findsim", "millimole/litre",
 "craf_p_p_dephospho_cplx_SBTAB_Findsim", "millimole/litre",
 "deph_raf_ser259_cplx_SBTAB_Findsim", "millimole/litre",
 0,0
};
 static double Arachidonic_Acid0 = 0;
 static double Ca_PLC_g_phospho_cplx0 = 0;
 static double CaM_GEF_act_Ras_cplx0 = 0;
 static double Ca_PLC_g_p0 = 0;
 static double Ca_PLC_g0 = 0;
 static double DAG0 = 0;
 static double DAG_Ca_PLA2_p0 = 0;
 static double GAP_inact_Ras_cplx0 = 0;
 static double GEF_p_act_Ras_cplx0 = 0;
 static double GAP_p0 = 0;
 static double GTP_Ras0 = 0;
 static double GEF_p0 = 0;
 static double Internal_L_EGFR0 = 0;
 static double IP30 = 0;
 static double L_EGFR0 = 0;
 static double MAPKK_dephospho_ser_cplx0 = 0;
 static double MAPKK_dephospho_cplx0 = 0;
 static double MKP1_thr_deph_cplx0 = 0;
 static double MKP1_tyr_deph_cplx0 = 0;
 static double MAPKKthr_cplx0 = 0;
 static double MAPKKtyr_cplx0 = 0;
 static double MAPK_p_p_feedback_cplx0 = 0;
 static double MAPK_p_p_cplx0 = 0;
 static double MAPKK_p0 = 0;
 static double MAPKK_p_p0 = 0;
 static double MAPK_p0 = 0;
 static double MAPK_p_p0 = 0;
 static double PLC_g_phospho_cplx0 = 0;
 static double PLCb_Ca_Gq_cplx0 = 0;
 static double PLC_Ca_cplx0 = 0;
 static double PKC_act_GEF_cplx0 = 0;
 static double PKC_inact_GAP_cplx0 = 0;
 static double PKC_act_raf_cplx0 = 0;
 static double PLC_g_p0 = 0;
 static double PLC_Gq0 = 0;
 static double PLC_Ca0 = 0;
 static double PLA2_p0 = 0;
 static double PLA2_p_Ca0 = 0;
 static double PLA2_Ca_p0 = 0;
 static double PKC_DAG_AA0 = 0;
 static double PKC_DAG0 = 0;
 static double PKC_Ca_DAG0 = 0;
 static double PKC_AA_p0 = 0;
 static double PKC_basal_p0 = 0;
 static double PKC_DAG_memb_p0 = 0;
 static double PKC_Ca_memb_p0 = 0;
 static double PKC_Ca_AA_p0 = 0;
 static double PKC_DAG_AA_p0 = 0;
 static double PKC_Ca0 = 0;
 static double Raf_p_GTP_Ras_2_cplx0 = 0;
 static double Raf_p_GTP_Ras_1_cplx0 = 0;
 static double Raf_p_GTP_Ras0 = 0;
 static double Sos_Ras_GEF_cplx0 = 0;
 static double SHC_phospho_cplx0 = 0;
 static double SHC_p_Grb2_clx0 = 0;
 static double Sos_p0 = 0;
 static double Sos_Grb20 = 0;
 static double Sos_p_Grb20 = 0;
 static double SHC_p0 = 0;
 static double SHC_p_Sos_Grb20 = 0;
 static double basal_GEF_activity_cplx0 = 0;
 static double craf_p_p_dephospho_cplx0 = 0;
 static double craf_dephospho_cplx0 = 0;
 static double craf_1_p_ser2590 = 0;
 static double craf_1_p_p0 = 0;
 static double craf_1_p0 = 0;
 static double delta_t = 0.01;
 static double deph_raf_ser259_cplx0 = 0;
 static double inact_GEF_p0 = 0;
 static double kenz_cplx_40 = 0;
 static double kenz_cplx_30 = 0;
 static double kenz_cplx_20 = 0;
 static double kenz_cplx_10 = 0;
 static double kenz_cplx0 = 0;
 static double phosph_Sos_cplx0 = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "kf_R1_SBTAB_Findsim", &kf_R1_SBTAB_Findsim,
 "kr_R1_SBTAB_Findsim", &kr_R1_SBTAB_Findsim,
 "kf_R2_SBTAB_Findsim", &kf_R2_SBTAB_Findsim,
 "kr_R2_SBTAB_Findsim", &kr_R2_SBTAB_Findsim,
 "kf_R3_SBTAB_Findsim", &kf_R3_SBTAB_Findsim,
 "kr_R3_SBTAB_Findsim", &kr_R3_SBTAB_Findsim,
 "kf_R4_SBTAB_Findsim", &kf_R4_SBTAB_Findsim,
 "kr_R4_SBTAB_Findsim", &kr_R4_SBTAB_Findsim,
 "kf_R5_SBTAB_Findsim", &kf_R5_SBTAB_Findsim,
 "kr_R5_SBTAB_Findsim", &kr_R5_SBTAB_Findsim,
 "kf_R6_SBTAB_Findsim", &kf_R6_SBTAB_Findsim,
 "kr_R6_SBTAB_Findsim", &kr_R6_SBTAB_Findsim,
 "kf_R7_SBTAB_Findsim", &kf_R7_SBTAB_Findsim,
 "kr_R7_SBTAB_Findsim", &kr_R7_SBTAB_Findsim,
 "kf_R8_SBTAB_Findsim", &kf_R8_SBTAB_Findsim,
 "kr_R8_SBTAB_Findsim", &kr_R8_SBTAB_Findsim,
 "kf_R9_SBTAB_Findsim", &kf_R9_SBTAB_Findsim,
 "kr_R9_SBTAB_Findsim", &kr_R9_SBTAB_Findsim,
 "kf_R10_SBTAB_Findsim", &kf_R10_SBTAB_Findsim,
 "kr_R10_SBTAB_Findsim", &kr_R10_SBTAB_Findsim,
 "kf_R11_SBTAB_Findsim", &kf_R11_SBTAB_Findsim,
 "kr_R11_SBTAB_Findsim", &kr_R11_SBTAB_Findsim,
 "kf_R12_SBTAB_Findsim", &kf_R12_SBTAB_Findsim,
 "kr_R12_SBTAB_Findsim", &kr_R12_SBTAB_Findsim,
 "kf_R13_SBTAB_Findsim", &kf_R13_SBTAB_Findsim,
 "kf_R14_SBTAB_Findsim", &kf_R14_SBTAB_Findsim,
 "kr_R14_SBTAB_Findsim", &kr_R14_SBTAB_Findsim,
 "kf_R15_SBTAB_Findsim", &kf_R15_SBTAB_Findsim,
 "kf_R16_SBTAB_Findsim", &kf_R16_SBTAB_Findsim,
 "kr_R16_SBTAB_Findsim", &kr_R16_SBTAB_Findsim,
 "kf_R17_SBTAB_Findsim", &kf_R17_SBTAB_Findsim,
 "kf_R18_SBTAB_Findsim", &kf_R18_SBTAB_Findsim,
 "kf_R19_SBTAB_Findsim", &kf_R19_SBTAB_Findsim,
 "kr_R19_SBTAB_Findsim", &kr_R19_SBTAB_Findsim,
 "kf_R20_SBTAB_Findsim", &kf_R20_SBTAB_Findsim,
 "kr_R20_SBTAB_Findsim", &kr_R20_SBTAB_Findsim,
 "kf_R21_SBTAB_Findsim", &kf_R21_SBTAB_Findsim,
 "kf_R22_SBTAB_Findsim", &kf_R22_SBTAB_Findsim,
 "kf_R23_SBTAB_Findsim", &kf_R23_SBTAB_Findsim,
 "kf_R24_SBTAB_Findsim", &kf_R24_SBTAB_Findsim,
 "kf_R25_SBTAB_Findsim", &kf_R25_SBTAB_Findsim,
 "kr_R25_SBTAB_Findsim", &kr_R25_SBTAB_Findsim,
 "kf_R26_SBTAB_Findsim", &kf_R26_SBTAB_Findsim,
 "kr_R26_SBTAB_Findsim", &kr_R26_SBTAB_Findsim,
 "kf_R27_SBTAB_Findsim", &kf_R27_SBTAB_Findsim,
 "kf_R28_SBTAB_Findsim", &kf_R28_SBTAB_Findsim,
 "kr_R28_SBTAB_Findsim", &kr_R28_SBTAB_Findsim,
 "kf_R29_SBTAB_Findsim", &kf_R29_SBTAB_Findsim,
 "kr_R29_SBTAB_Findsim", &kr_R29_SBTAB_Findsim,
 "kf_R30_SBTAB_Findsim", &kf_R30_SBTAB_Findsim,
 "kf_R31_SBTAB_Findsim", &kf_R31_SBTAB_Findsim,
 "kr_R31_SBTAB_Findsim", &kr_R31_SBTAB_Findsim,
 "kf_R32_SBTAB_Findsim", &kf_R32_SBTAB_Findsim,
 "kr_R32_SBTAB_Findsim", &kr_R32_SBTAB_Findsim,
 "kf_R33_SBTAB_Findsim", &kf_R33_SBTAB_Findsim,
 "kr_R33_SBTAB_Findsim", &kr_R33_SBTAB_Findsim,
 "kf_R34_SBTAB_Findsim", &kf_R34_SBTAB_Findsim,
 "kr_R34_SBTAB_Findsim", &kr_R34_SBTAB_Findsim,
 "kf_R35_SBTAB_Findsim", &kf_R35_SBTAB_Findsim,
 "kf_R36_SBTAB_Findsim", &kf_R36_SBTAB_Findsim,
 "kf_R37_SBTAB_Findsim", &kf_R37_SBTAB_Findsim,
 "kr_R37_SBTAB_Findsim", &kr_R37_SBTAB_Findsim,
 "kf_R38_SBTAB_Findsim", &kf_R38_SBTAB_Findsim,
 "kf_R39_SBTAB_Findsim", &kf_R39_SBTAB_Findsim,
 "kr_R39_SBTAB_Findsim", &kr_R39_SBTAB_Findsim,
 "kf_R40_SBTAB_Findsim", &kf_R40_SBTAB_Findsim,
 "kf_R41_SBTAB_Findsim", &kf_R41_SBTAB_Findsim,
 "kr_R41_SBTAB_Findsim", &kr_R41_SBTAB_Findsim,
 "kf_R42_SBTAB_Findsim", &kf_R42_SBTAB_Findsim,
 "kf_R43_SBTAB_Findsim", &kf_R43_SBTAB_Findsim,
 "kr_R43_SBTAB_Findsim", &kr_R43_SBTAB_Findsim,
 "kf_R44_SBTAB_Findsim", &kf_R44_SBTAB_Findsim,
 "kf_R45_SBTAB_Findsim", &kf_R45_SBTAB_Findsim,
 "kr_R45_SBTAB_Findsim", &kr_R45_SBTAB_Findsim,
 "kf_R46_SBTAB_Findsim", &kf_R46_SBTAB_Findsim,
 "kf_R47_SBTAB_Findsim", &kf_R47_SBTAB_Findsim,
 "kr_R47_SBTAB_Findsim", &kr_R47_SBTAB_Findsim,
 "kf_R48_SBTAB_Findsim", &kf_R48_SBTAB_Findsim,
 "kf_R49_SBTAB_Findsim", &kf_R49_SBTAB_Findsim,
 "kr_R49_SBTAB_Findsim", &kr_R49_SBTAB_Findsim,
 "kf_R50_SBTAB_Findsim", &kf_R50_SBTAB_Findsim,
 "kf_R51_SBTAB_Findsim", &kf_R51_SBTAB_Findsim,
 "kr_R51_SBTAB_Findsim", &kr_R51_SBTAB_Findsim,
 "kf_R52_SBTAB_Findsim", &kf_R52_SBTAB_Findsim,
 "kf_R53_SBTAB_Findsim", &kf_R53_SBTAB_Findsim,
 "kr_R53_SBTAB_Findsim", &kr_R53_SBTAB_Findsim,
 "kf_R54_SBTAB_Findsim", &kf_R54_SBTAB_Findsim,
 "kf_R55_SBTAB_Findsim", &kf_R55_SBTAB_Findsim,
 "kr_R55_SBTAB_Findsim", &kr_R55_SBTAB_Findsim,
 "kf_R56_SBTAB_Findsim", &kf_R56_SBTAB_Findsim,
 "kf_R57_SBTAB_Findsim", &kf_R57_SBTAB_Findsim,
 "kr_R57_SBTAB_Findsim", &kr_R57_SBTAB_Findsim,
 "kf_R58_SBTAB_Findsim", &kf_R58_SBTAB_Findsim,
 "kf_R59_SBTAB_Findsim", &kf_R59_SBTAB_Findsim,
 "kr_R59_SBTAB_Findsim", &kr_R59_SBTAB_Findsim,
 "kf_R60_SBTAB_Findsim", &kf_R60_SBTAB_Findsim,
 "kf_R61_SBTAB_Findsim", &kf_R61_SBTAB_Findsim,
 "kr_R61_SBTAB_Findsim", &kr_R61_SBTAB_Findsim,
 "kf_R62_SBTAB_Findsim", &kf_R62_SBTAB_Findsim,
 "kf_R63_SBTAB_Findsim", &kf_R63_SBTAB_Findsim,
 "kr_R63_SBTAB_Findsim", &kr_R63_SBTAB_Findsim,
 "kf_R64_SBTAB_Findsim", &kf_R64_SBTAB_Findsim,
 "kf_R65_SBTAB_Findsim", &kf_R65_SBTAB_Findsim,
 "kr_R65_SBTAB_Findsim", &kr_R65_SBTAB_Findsim,
 "kf_R66_SBTAB_Findsim", &kf_R66_SBTAB_Findsim,
 "kf_R67_SBTAB_Findsim", &kf_R67_SBTAB_Findsim,
 "kr_R67_SBTAB_Findsim", &kr_R67_SBTAB_Findsim,
 "kf_R68_SBTAB_Findsim", &kf_R68_SBTAB_Findsim,
 "kf_R69_SBTAB_Findsim", &kf_R69_SBTAB_Findsim,
 "kr_R69_SBTAB_Findsim", &kr_R69_SBTAB_Findsim,
 "kf_R70_SBTAB_Findsim", &kf_R70_SBTAB_Findsim,
 "kf_R71_SBTAB_Findsim", &kf_R71_SBTAB_Findsim,
 "kr_R71_SBTAB_Findsim", &kr_R71_SBTAB_Findsim,
 "kf_R72_SBTAB_Findsim", &kf_R72_SBTAB_Findsim,
 "kf_R73_SBTAB_Findsim", &kf_R73_SBTAB_Findsim,
 "kr_R73_SBTAB_Findsim", &kr_R73_SBTAB_Findsim,
 "kf_R74_SBTAB_Findsim", &kf_R74_SBTAB_Findsim,
 "kf_R75_SBTAB_Findsim", &kf_R75_SBTAB_Findsim,
 "kr_R75_SBTAB_Findsim", &kr_R75_SBTAB_Findsim,
 "kf_R76_SBTAB_Findsim", &kf_R76_SBTAB_Findsim,
 "kf_R77_SBTAB_Findsim", &kf_R77_SBTAB_Findsim,
 "kr_R77_SBTAB_Findsim", &kr_R77_SBTAB_Findsim,
 "kf_R78_SBTAB_Findsim", &kf_R78_SBTAB_Findsim,
 "kf_R79_SBTAB_Findsim", &kf_R79_SBTAB_Findsim,
 "kr_R79_SBTAB_Findsim", &kr_R79_SBTAB_Findsim,
 "kf_R80_SBTAB_Findsim", &kf_R80_SBTAB_Findsim,
 "kf_R81_SBTAB_Findsim", &kf_R81_SBTAB_Findsim,
 "kr_R81_SBTAB_Findsim", &kr_R81_SBTAB_Findsim,
 "kf_R82_SBTAB_Findsim", &kf_R82_SBTAB_Findsim,
 "kf_R83_SBTAB_Findsim", &kf_R83_SBTAB_Findsim,
 "kr_R83_SBTAB_Findsim", &kr_R83_SBTAB_Findsim,
 "kf_R84_SBTAB_Findsim", &kf_R84_SBTAB_Findsim,
 "kf_R85_SBTAB_Findsim", &kf_R85_SBTAB_Findsim,
 "kr_R85_SBTAB_Findsim", &kr_R85_SBTAB_Findsim,
 "kf_R86_SBTAB_Findsim", &kf_R86_SBTAB_Findsim,
 "kr_R86_SBTAB_Findsim", &kr_R86_SBTAB_Findsim,
 "kf_R87_SBTAB_Findsim", &kf_R87_SBTAB_Findsim,
 "kr_R87_SBTAB_Findsim", &kr_R87_SBTAB_Findsim,
 "kf_R88_SBTAB_Findsim", &kf_R88_SBTAB_Findsim,
 "kf_R89_SBTAB_Findsim", &kf_R89_SBTAB_Findsim,
 "kr_R89_SBTAB_Findsim", &kr_R89_SBTAB_Findsim,
 "kf_R90_SBTAB_Findsim", &kf_R90_SBTAB_Findsim,
 "kf_R91_SBTAB_Findsim", &kf_R91_SBTAB_Findsim,
 "kr_R91_SBTAB_Findsim", &kr_R91_SBTAB_Findsim,
 "kf_R92_SBTAB_Findsim", &kf_R92_SBTAB_Findsim,
 "kf_R93_SBTAB_Findsim", &kf_R93_SBTAB_Findsim,
 "kr_R93_SBTAB_Findsim", &kr_R93_SBTAB_Findsim,
 "kf_R94_SBTAB_Findsim", &kf_R94_SBTAB_Findsim,
 "kf_R95_SBTAB_Findsim", &kf_R95_SBTAB_Findsim,
 "kr_R95_SBTAB_Findsim", &kr_R95_SBTAB_Findsim,
 "kf_R96_SBTAB_Findsim", &kf_R96_SBTAB_Findsim,
 "kf_R97_SBTAB_Findsim", &kf_R97_SBTAB_Findsim,
 "kr_R97_SBTAB_Findsim", &kr_R97_SBTAB_Findsim,
 "kf_R98_SBTAB_Findsim", &kf_R98_SBTAB_Findsim,
 "kf_R99_SBTAB_Findsim", &kf_R99_SBTAB_Findsim,
 "kr_R99_SBTAB_Findsim", &kr_R99_SBTAB_Findsim,
 "kf_R100_SBTAB_Findsim", &kf_R100_SBTAB_Findsim,
 "kf_R101_SBTAB_Findsim", &kf_R101_SBTAB_Findsim,
 "kr_R101_SBTAB_Findsim", &kr_R101_SBTAB_Findsim,
 "kf_R102_SBTAB_Findsim", &kf_R102_SBTAB_Findsim,
 "PPhosphatase2A_ConservedConst_SBTAB_Findsim", &PPhosphatase2A_ConservedConst_SBTAB_Findsim,
 "MKP_1_ConservedConst_SBTAB_Findsim", &MKP_1_ConservedConst_SBTAB_Findsim,
 "PLCg_basal_ConservedConst_SBTAB_Findsim", &PLCg_basal_ConservedConst_SBTAB_Findsim,
 "PLC_g_ConservedConst_SBTAB_Findsim", &PLC_g_ConservedConst_SBTAB_Findsim,
 "Grb2_ConservedConst_SBTAB_Findsim", &Grb2_ConservedConst_SBTAB_Findsim,
 "SHC_ConservedConst_SBTAB_Findsim", &SHC_ConservedConst_SBTAB_Findsim,
 "Sos_ConservedConst_SBTAB_Findsim", &Sos_ConservedConst_SBTAB_Findsim,
 "EGFR_ConservedConst_SBTAB_Findsim", &EGFR_ConservedConst_SBTAB_Findsim,
 "CaM_GEF_ConservedConst_SBTAB_Findsim", &CaM_GEF_ConservedConst_SBTAB_Findsim,
 "GAP_ConservedConst_SBTAB_Findsim", &GAP_ConservedConst_SBTAB_Findsim,
 "inact_GEF_ConservedConst_SBTAB_Findsim", &inact_GEF_ConservedConst_SBTAB_Findsim,
 "GDP_Ras_ConservedConst_SBTAB_Findsim", &GDP_Ras_ConservedConst_SBTAB_Findsim,
 "MAPKK_ConservedConst_SBTAB_Findsim", &MAPKK_ConservedConst_SBTAB_Findsim,
 "craf_1_ConservedConst_SBTAB_Findsim", &craf_1_ConservedConst_SBTAB_Findsim,
 "MAPK_ConservedConst_SBTAB_Findsim", &MAPK_ConservedConst_SBTAB_Findsim,
 "PLC_Ca_Gq_ConservedConst_SBTAB_Findsim", &PLC_Ca_Gq_ConservedConst_SBTAB_Findsim,
 "PLC_ConservedConst_SBTAB_Findsim", &PLC_ConservedConst_SBTAB_Findsim,
 "PIP2_Ca_PLA2_p_ConservedConst_SBTAB_Findsim", &PIP2_Ca_PLA2_p_ConservedConst_SBTAB_Findsim,
 "PIP2_PLA2_p_ConservedConst_SBTAB_Findsim", &PIP2_PLA2_p_ConservedConst_SBTAB_Findsim,
 "PLA2_cytosolic_ConservedConst_SBTAB_Findsim", &PLA2_cytosolic_ConservedConst_SBTAB_Findsim,
 "PKC_cytosolic_ConservedConst_SBTAB_Findsim", &PKC_cytosolic_ConservedConst_SBTAB_Findsim,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(Prop*);
static void  nrn_init(_NrnThread*, _Memb_list*, int);
static void nrn_state(_NrnThread*, _Memb_list*, int);
 static void nrn_cur(_NrnThread*, _Memb_list*, int);
static void  nrn_jacob(_NrnThread*, _Memb_list*, int);
 
static int _ode_count(int);
static void _ode_map(int, double**, double**, double*, Datum*, double*, int);
static void _ode_spec(_NrnThread*, _Memb_list*, int);
static void _ode_matsol(_NrnThread*, _Memb_list*, int);
 
#define _cvode_ieq _ppvar[0]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"SBTAB_Findsim",
 0,
 "PKC_active_SBTAB_Findsim",
 "PKC_active1_SBTAB_Findsim",
 "APC_SBTAB_Findsim",
 "Inositol_SBTAB_Findsim",
 "PC_SBTAB_Findsim",
 "PIP2_SBTAB_Findsim",
 "EGF_SBTAB_Findsim",
 "Ca_SBTAB_Findsim",
 "PPhosphatase2A_SBTAB_Findsim",
 "MKP_1_SBTAB_Findsim",
 "PLCg_basal_SBTAB_Findsim",
 "PLC_g_SBTAB_Findsim",
 "Grb2_SBTAB_Findsim",
 "SHC_SBTAB_Findsim",
 "Sos_SBTAB_Findsim",
 "EGFR_SBTAB_Findsim",
 "CaM_GEF_SBTAB_Findsim",
 "GAP_SBTAB_Findsim",
 "inact_GEF_SBTAB_Findsim",
 "GDP_Ras_SBTAB_Findsim",
 "MAPKK_SBTAB_Findsim",
 "craf_1_SBTAB_Findsim",
 "MAPK_SBTAB_Findsim",
 "PLC_Ca_Gq_SBTAB_Findsim",
 "PLC_SBTAB_Findsim",
 "PIP2_Ca_PLA2_p_SBTAB_Findsim",
 "PIP2_PLA2_p_SBTAB_Findsim",
 "PLA2_cytosolic_SBTAB_Findsim",
 "PKC_cytosolic_SBTAB_Findsim",
 "pERK1_2_ratio1_SBTAB_Findsim",
 "MAPK_out_SBTAB_Findsim",
 "MAPK_p_out_SBTAB_Findsim",
 "MAPK_p_p_out_SBTAB_Findsim",
 "MAPK_p_p_cplx_out_SBTAB_Findsim",
 "MAPK_p_p_feedback_cplx_out_SBTAB_Findsim",
 "pERK1_2_ratio2_SBTAB_Findsim",
 0,
 "PKC_Ca_SBTAB_Findsim",
 "PKC_DAG_AA_p_SBTAB_Findsim",
 "PKC_Ca_AA_p_SBTAB_Findsim",
 "PKC_Ca_memb_p_SBTAB_Findsim",
 "PKC_DAG_memb_p_SBTAB_Findsim",
 "PKC_basal_p_SBTAB_Findsim",
 "PKC_AA_p_SBTAB_Findsim",
 "PKC_Ca_DAG_SBTAB_Findsim",
 "PKC_DAG_SBTAB_Findsim",
 "PKC_DAG_AA_SBTAB_Findsim",
 "PLA2_Ca_p_SBTAB_Findsim",
 "DAG_Ca_PLA2_p_SBTAB_Findsim",
 "PLA2_p_Ca_SBTAB_Findsim",
 "PLA2_p_SBTAB_Findsim",
 "Arachidonic_Acid_SBTAB_Findsim",
 "PLC_Ca_SBTAB_Findsim",
 "PLC_Gq_SBTAB_Findsim",
 "DAG_SBTAB_Findsim",
 "IP3_SBTAB_Findsim",
 "MAPK_p_p_SBTAB_Findsim",
 "craf_1_p_SBTAB_Findsim",
 "craf_1_p_p_SBTAB_Findsim",
 "MAPK_p_SBTAB_Findsim",
 "MAPKK_p_p_SBTAB_Findsim",
 "MAPKK_p_SBTAB_Findsim",
 "Raf_p_GTP_Ras_SBTAB_Findsim",
 "craf_1_p_ser259_SBTAB_Findsim",
 "GEF_p_SBTAB_Findsim",
 "GTP_Ras_SBTAB_Findsim",
 "GAP_p_SBTAB_Findsim",
 "inact_GEF_p_SBTAB_Findsim",
 "L_EGFR_SBTAB_Findsim",
 "Internal_L_EGFR_SBTAB_Findsim",
 "SHC_p_Sos_Grb2_SBTAB_Findsim",
 "SHC_p_SBTAB_Findsim",
 "Sos_p_Grb2_SBTAB_Findsim",
 "Sos_Grb2_SBTAB_Findsim",
 "Sos_p_SBTAB_Findsim",
 "SHC_p_Grb2_clx_SBTAB_Findsim",
 "PLC_g_p_SBTAB_Findsim",
 "Ca_PLC_g_SBTAB_Findsim",
 "Ca_PLC_g_p_SBTAB_Findsim",
 "PKC_act_raf_cplx_SBTAB_Findsim",
 "PKC_inact_GAP_cplx_SBTAB_Findsim",
 "PKC_act_GEF_cplx_SBTAB_Findsim",
 "kenz_cplx_SBTAB_Findsim",
 "kenz_cplx_1_SBTAB_Findsim",
 "kenz_cplx_2_SBTAB_Findsim",
 "kenz_cplx_3_SBTAB_Findsim",
 "kenz_cplx_4_SBTAB_Findsim",
 "PLC_Ca_cplx_SBTAB_Findsim",
 "PLCb_Ca_Gq_cplx_SBTAB_Findsim",
 "MAPK_p_p_cplx_SBTAB_Findsim",
 "MAPK_p_p_feedback_cplx_SBTAB_Findsim",
 "phosph_Sos_cplx_SBTAB_Findsim",
 "MAPKKtyr_cplx_SBTAB_Findsim",
 "MAPKKthr_cplx_SBTAB_Findsim",
 "Raf_p_GTP_Ras_1_cplx_SBTAB_Findsim",
 "Raf_p_GTP_Ras_2_cplx_SBTAB_Findsim",
 "basal_GEF_activity_cplx_SBTAB_Findsim",
 "GEF_p_act_Ras_cplx_SBTAB_Findsim",
 "GAP_inact_Ras_cplx_SBTAB_Findsim",
 "CaM_GEF_act_Ras_cplx_SBTAB_Findsim",
 "Ca_PLC_g_phospho_cplx_SBTAB_Findsim",
 "SHC_phospho_cplx_SBTAB_Findsim",
 "Sos_Ras_GEF_cplx_SBTAB_Findsim",
 "PLC_g_phospho_cplx_SBTAB_Findsim",
 "MKP1_tyr_deph_cplx_SBTAB_Findsim",
 "MKP1_thr_deph_cplx_SBTAB_Findsim",
 "craf_dephospho_cplx_SBTAB_Findsim",
 "MAPKK_dephospho_cplx_SBTAB_Findsim",
 "MAPKK_dephospho_ser_cplx_SBTAB_Findsim",
 "craf_p_p_dephospho_cplx_SBTAB_Findsim",
 "deph_raf_ser259_cplx_SBTAB_Findsim",
 0,
 0};
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 289, _prop);
 	/*initialize range parameters*/
 	_prop->param = _p;
 	_prop->param_size = 289;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 1, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _SBTAB_Findsim_reg() {
	int _vectorized = 1;
  _initlists();
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 1);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
 #if NMODL_TEXT
  hoc_reg_nmodl_text(_mechtype, nmodl_file_text);
  hoc_reg_nmodl_filename(_mechtype, nmodl_filename);
#endif
  hoc_register_prop_size(_mechtype, 289, 1);
  hoc_register_dparam_semantics(_mechtype, 0, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 SBTAB_Findsim C:/Users/kadpaj/OneDrive - KI.SE/Skrivbordet/Models/Subcellular_workflow/NEURON/mod/SBTAB_Findsim.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "SBTAB_Findsim";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int assign_calculated_values(_threadargsproto_);
static int observables_func(_threadargsproto_);
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[74], _dlist1[74];
 static int ode(_threadargsproto_);
 
static int  assign_calculated_values ( _threadargsproto_ ) {
   time = t ;
   PPhosphatase2A = PPhosphatase2A_ConservedConst - ( craf_dephospho_cplx + MAPKK_dephospho_cplx + MAPKK_dephospho_ser_cplx + craf_p_p_dephospho_cplx + deph_raf_ser259_cplx ) ;
   MKP_1 = MKP_1_ConservedConst - ( MKP1_tyr_deph_cplx + MKP1_thr_deph_cplx ) ;
   PLCg_basal = PLCg_basal_ConservedConst - ( PLC_g_phospho_cplx ) ;
   PLC_g = PLC_g_ConservedConst - ( PLC_g_p + Ca_PLC_g + Ca_PLC_g_p + Ca_PLC_g_phospho_cplx + PLC_g_phospho_cplx ) ;
   Grb2 = Grb2_ConservedConst - ( SHC_p_Grb2_clx - Sos_p - Sos - phosph_Sos_cplx ) ;
   SHC = SHC_ConservedConst - ( SHC_p + SHC_p_Grb2_clx + SHC_phospho_cplx - Sos_p_Grb2 - Sos_Grb2 - Sos_p - Sos - phosph_Sos_cplx ) ;
   Sos = Sos_ConservedConst - ( SHC_p_Sos_Grb2 + Sos_p_Grb2 + Sos_Grb2 + Sos_p + phosph_Sos_cplx + Sos_Ras_GEF_cplx ) ;
   EGFR = EGFR_ConservedConst - ( L_EGFR + Internal_L_EGFR + Ca_PLC_g_phospho_cplx + SHC_phospho_cplx ) ;
   CaM_GEF = CaM_GEF_ConservedConst - ( CaM_GEF_act_Ras_cplx ) ;
   GAP = GAP_ConservedConst - ( GAP_p + PKC_inact_GAP_cplx + GAP_inact_Ras_cplx ) ;
   inact_GEF = inact_GEF_ConservedConst - ( GEF_p + inact_GEF_p + PKC_act_GEF_cplx + basal_GEF_activity_cplx + GEF_p_act_Ras_cplx ) ;
   GDP_Ras = GDP_Ras_ConservedConst - ( Raf_p_GTP_Ras + GTP_Ras + Raf_p_GTP_Ras_1_cplx + Raf_p_GTP_Ras_2_cplx + basal_GEF_activity_cplx + GEF_p_act_Ras_cplx + GAP_inact_Ras_cplx + CaM_GEF_act_Ras_cplx + Sos_Ras_GEF_cplx ) ;
   MAPKK = MAPKK_ConservedConst - ( MAPKK_p_p + MAPKK_p + MAPKKtyr_cplx + MAPKKthr_cplx + Raf_p_GTP_Ras_1_cplx + Raf_p_GTP_Ras_2_cplx + MAPKK_dephospho_cplx + MAPKK_dephospho_ser_cplx ) ;
   craf_1 = craf_1_ConservedConst - ( craf_1_p + craf_1_p_p + craf_1_p_ser259 + PKC_act_raf_cplx + MAPK_p_p_feedback_cplx + craf_dephospho_cplx + craf_p_p_dephospho_cplx + deph_raf_ser259_cplx - GTP_Ras - GDP_Ras - basal_GEF_activity_cplx - GEF_p_act_Ras_cplx - GAP_inact_Ras_cplx - CaM_GEF_act_Ras_cplx - Sos_Ras_GEF_cplx ) ;
   MAPK = MAPK_ConservedConst - ( MAPK_p_p + MAPK_p + MAPK_p_p_cplx + MAPK_p_p_feedback_cplx + phosph_Sos_cplx + MAPKKtyr_cplx + MAPKKthr_cplx + MKP1_tyr_deph_cplx + MKP1_thr_deph_cplx ) ;
   PLC_Ca_Gq = PLC_Ca_Gq_ConservedConst - ( PLC_Gq + PLCb_Ca_Gq_cplx ) ;
   PLC = PLC_ConservedConst - ( PLC_Ca + PLC_Ca_cplx ) ;
   PIP2_Ca_PLA2_p = PIP2_Ca_PLA2_p_ConservedConst - ( kenz_cplx_2 ) ;
   PIP2_PLA2_p = PIP2_PLA2_p_ConservedConst - ( kenz_cplx_1 ) ;
   PLA2_cytosolic = PLA2_cytosolic_ConservedConst - ( PLA2_Ca_p + DAG_Ca_PLA2_p + PLA2_p_Ca + PLA2_p + kenz_cplx + kenz_cplx_3 + kenz_cplx_4 + MAPK_p_p_cplx ) ;
   PKC_cytosolic = PKC_cytosolic_ConservedConst - ( PKC_Ca + PKC_DAG_AA_p + PKC_Ca_AA_p + PKC_Ca_memb_p + PKC_DAG_memb_p + PKC_basal_p + PKC_AA_p + PKC_Ca_DAG + PKC_DAG + PKC_DAG_AA ) ;
   PKC_active = PKC_DAG_AA_p + PKC_Ca_memb_p + PKC_Ca_AA_p + PKC_DAG_memb_p + PKC_basal_p + PKC_AA_p ;
   PKC_active1 = 0.0 ;
   APC = 0.030001 ;
   Inositol = 0.0 ;
   PC = 0.0 ;
   PIP2 = 0.007 ;
   EGF = 0.0 ;
   Ca = 8e-05 ;
   ReactionFlux0 = kf_R1 * Ca * PKC_cytosolic - kr_R1 * PKC_Ca ;
   ReactionFlux1 = kf_R2 * DAG * PKC_Ca - kr_R2 * PKC_Ca_DAG ;
   ReactionFlux2 = kf_R3 * PKC_Ca - kr_R3 * PKC_Ca_memb_p ;
   ReactionFlux3 = kf_R4 * PKC_Ca_DAG - kr_R4 * PKC_DAG_memb_p ;
   ReactionFlux4 = kf_R5 * Arachidonic_Acid * PKC_Ca - kr_R5 * PKC_Ca_AA_p ;
   ReactionFlux5 = kf_R6 * PKC_DAG_AA - kr_R6 * PKC_DAG_AA_p ;
   ReactionFlux6 = kf_R7 * PKC_cytosolic - kr_R7 * PKC_basal_p ;
   ReactionFlux7 = kf_R8 * PKC_cytosolic * Arachidonic_Acid - kr_R8 * PKC_AA_p ;
   ReactionFlux8 = kf_R9 * PKC_cytosolic * DAG - kr_R9 * PKC_DAG ;
   ReactionFlux9 = kf_R10 * Arachidonic_Acid * PKC_DAG - kr_R10 * PKC_DAG_AA ;
   ReactionFlux10 = kf_R11 * Ca * PLA2_cytosolic - kr_R11 * PLA2_Ca_p ;
   ReactionFlux11 = kf_R12 * PLA2_Ca_p * DAG - kr_R12 * DAG_Ca_PLA2_p ;
   ReactionFlux12 = kf_R13 * Arachidonic_Acid ;
   ReactionFlux13 = kf_R14 * Ca * PLA2_p - kr_R14 * PLA2_p_Ca ;
   ReactionFlux14 = kf_R15 * PLA2_p ;
   ReactionFlux15 = kf_R16 * PLC * Ca - kr_R16 * PLC_Ca ;
   ReactionFlux16 = kf_R17 * IP3 ;
   ReactionFlux17 = kf_R18 * DAG ;
   ReactionFlux18 = kf_R19 * PLC_Gq * Ca - kr_R19 * PLC_Ca_Gq ;
   ReactionFlux19 = kf_R20 * GTP_Ras * craf_1_p - kr_R20 * Raf_p_GTP_Ras ;
   ReactionFlux20 = kf_R21 * GEF_p ;
   ReactionFlux21 = kf_R22 * GTP_Ras ;
   ReactionFlux22 = kf_R23 * GAP_p ;
   ReactionFlux23 = kf_R24 * inact_GEF_p ;
   ReactionFlux24 = kf_R25 * EGFR * EGF - kr_R25 * L_EGFR ;
   ReactionFlux25 = kf_R26 * L_EGFR - kr_R26 * Internal_L_EGFR ;
   ReactionFlux26 = kf_R27 * SHC_p ;
   ReactionFlux27 = kf_R28 * Sos_Grb2 * SHC_p - kr_R28 * SHC_p_Sos_Grb2 ;
   ReactionFlux28 = kf_R29 * Grb2 * Sos_p - kr_R29 * Sos_p_Grb2 ;
   ReactionFlux29 = kf_R30 * Sos_p ;
   ReactionFlux30 = kf_R31 * Grb2 * Sos - kr_R31 * Sos_Grb2 ;
   ReactionFlux31 = kf_R32 * Grb2 * SHC_p - kr_R32 * SHC_p_Grb2_clx ;
   ReactionFlux32 = kf_R33 * Ca * PLC_g - kr_R33 * Ca_PLC_g ;
   ReactionFlux33 = kf_R34 * Ca * PLC_g_p - kr_R34 * Ca_PLC_g_p ;
   ReactionFlux34 = kf_R35 * Ca_PLC_g_p ;
   ReactionFlux35 = kf_R36 * PLC_g_p ;
   ReactionFlux36 = kf_R37 * craf_1 * PKC_active - kr_R37 * PKC_act_raf_cplx ;
   ReactionFlux37 = kf_R38 * PKC_act_raf_cplx ;
   ReactionFlux38 = kf_R39 * GAP * PKC_active - kr_R39 * PKC_inact_GAP_cplx ;
   ReactionFlux39 = kf_R40 * PKC_inact_GAP_cplx ;
   ReactionFlux40 = kf_R41 * inact_GEF * PKC_active - kr_R41 * PKC_act_GEF_cplx ;
   ReactionFlux41 = kf_R42 * PKC_act_GEF_cplx ;
   ReactionFlux42 = kf_R43 * PLA2_Ca_p * APC - kr_R43 * kenz_cplx ;
   ReactionFlux43 = kf_R44 * kenz_cplx ;
   ReactionFlux44 = kf_R45 * APC * PIP2_PLA2_p - kr_R45 * kenz_cplx_1 ;
   ReactionFlux45 = kf_R46 * kenz_cplx_1 ;
   ReactionFlux46 = kf_R47 * APC * PIP2_Ca_PLA2_p - kr_R47 * kenz_cplx_2 ;
   ReactionFlux47 = kf_R48 * kenz_cplx_2 ;
   ReactionFlux48 = kf_R49 * APC * DAG_Ca_PLA2_p - kr_R49 * kenz_cplx_3 ;
   ReactionFlux49 = kf_R50 * kenz_cplx_3 ;
   ReactionFlux50 = kf_R51 * APC * PLA2_p_Ca - kr_R51 * kenz_cplx_4 ;
   ReactionFlux51 = kf_R52 * kenz_cplx_4 ;
   ReactionFlux52 = kf_R53 * PIP2 * PLC_Ca - kr_R53 * PLC_Ca_cplx ;
   ReactionFlux53 = kf_R54 * PLC_Ca_cplx ;
   ReactionFlux54 = kf_R55 * PIP2 * PLC_Ca_Gq - kr_R55 * PLCb_Ca_Gq_cplx ;
   ReactionFlux55 = kf_R56 * PLCb_Ca_Gq_cplx ;
   ReactionFlux56 = kf_R57 * MAPK_p_p * PLA2_cytosolic - kr_R57 * MAPK_p_p_cplx ;
   ReactionFlux57 = kf_R58 * MAPK_p_p_cplx ;
   ReactionFlux58 = kf_R59 * MAPK_p_p * craf_1_p - kr_R59 * MAPK_p_p_feedback_cplx ;
   ReactionFlux59 = kf_R60 * MAPK_p_p_feedback_cplx ;
   ReactionFlux60 = kf_R61 * MAPK_p_p * Sos - kr_R61 * phosph_Sos_cplx ;
   ReactionFlux61 = kf_R62 * phosph_Sos_cplx ;
   ReactionFlux62 = kf_R63 * MAPKK_p_p * MAPK - kr_R63 * MAPKKtyr_cplx ;
   ReactionFlux63 = kf_R64 * MAPKKtyr_cplx ;
   ReactionFlux64 = kf_R65 * MAPKK_p_p * MAPK_p - kr_R65 * MAPKKthr_cplx ;
   ReactionFlux65 = kf_R66 * MAPKKthr_cplx ;
   ReactionFlux66 = kf_R67 * MAPKK * Raf_p_GTP_Ras - kr_R67 * Raf_p_GTP_Ras_1_cplx ;
   ReactionFlux67 = kf_R68 * Raf_p_GTP_Ras_1_cplx ;
   ReactionFlux68 = kf_R69 * MAPKK_p * Raf_p_GTP_Ras - kr_R69 * Raf_p_GTP_Ras_2_cplx ;
   ReactionFlux69 = kf_R70 * Raf_p_GTP_Ras_2_cplx ;
   ReactionFlux70 = kf_R71 * inact_GEF * GDP_Ras - kr_R71 * basal_GEF_activity_cplx ;
   ReactionFlux71 = kf_R72 * basal_GEF_activity_cplx ;
   ReactionFlux72 = kf_R73 * GEF_p * GDP_Ras - kr_R73 * GEF_p_act_Ras_cplx ;
   ReactionFlux73 = kf_R74 * GEF_p_act_Ras_cplx ;
   ReactionFlux74 = kf_R75 * GAP * GTP_Ras - kr_R75 * GAP_inact_Ras_cplx ;
   ReactionFlux75 = kf_R76 * GAP_inact_Ras_cplx ;
   ReactionFlux76 = kf_R77 * GDP_Ras * CaM_GEF - kr_R77 * CaM_GEF_act_Ras_cplx ;
   ReactionFlux77 = kf_R78 * CaM_GEF_act_Ras_cplx ;
   ReactionFlux78 = kf_R79 * L_EGFR * Ca_PLC_g - kr_R79 * Ca_PLC_g_phospho_cplx ;
   ReactionFlux79 = kf_R80 * Ca_PLC_g_phospho_cplx ;
   ReactionFlux80 = kf_R81 * L_EGFR * SHC - kr_R81 * SHC_phospho_cplx ;
   ReactionFlux81 = kf_R82 * SHC_phospho_cplx ;
   ReactionFlux82 = kf_R83 * SHC_p_Sos_Grb2 * GDP_Ras - kr_R83 * Sos_Ras_GEF_cplx ;
   ReactionFlux83 = kf_R84 * Sos_Ras_GEF_cplx ;
   ReactionFlux84 = ( kf_R85 * PIP2 * Ca_PLC_g / ( kr_R85 + PIP2 ) ) ;
   ReactionFlux85 = ( kf_R86 * PIP2 * Ca_PLC_g_p / ( kr_R86 + PIP2 ) ) ;
   ReactionFlux86 = kf_R87 * PLCg_basal * PLC_g - kr_R87 * PLC_g_phospho_cplx ;
   ReactionFlux87 = kf_R88 * PLC_g_phospho_cplx ;
   ReactionFlux88 = kf_R89 * MKP_1 * MAPK_p - kr_R89 * MKP1_tyr_deph_cplx ;
   ReactionFlux89 = kf_R90 * MKP1_tyr_deph_cplx ;
   ReactionFlux90 = kf_R91 * MAPK_p_p * MKP_1 - kr_R91 * MKP1_thr_deph_cplx ;
   ReactionFlux91 = kf_R92 * MKP1_thr_deph_cplx ;
   ReactionFlux92 = kf_R93 * craf_1_p * PPhosphatase2A - kr_R93 * craf_dephospho_cplx ;
   ReactionFlux93 = kf_R94 * craf_dephospho_cplx ;
   ReactionFlux94 = kf_R95 * MAPKK_p_p * PPhosphatase2A - kr_R95 * MAPKK_dephospho_cplx ;
   ReactionFlux95 = kf_R96 * MAPKK_dephospho_cplx ;
   ReactionFlux96 = kf_R97 * MAPKK_p * PPhosphatase2A - kr_R97 * MAPKK_dephospho_ser_cplx ;
   ReactionFlux97 = kf_R98 * MAPKK_dephospho_ser_cplx ;
   ReactionFlux98 = kf_R99 * craf_1_p_p * PPhosphatase2A - kr_R99 * craf_p_p_dephospho_cplx ;
   ReactionFlux99 = kf_R100 * craf_p_p_dephospho_cplx ;
   ReactionFlux100 = kf_R101 * craf_1_p_ser259 * PPhosphatase2A - kr_R101 * deph_raf_ser259_cplx ;
   ReactionFlux101 = kf_R102 * deph_raf_ser259_cplx ;
    return 0; }
 
static void _hoc_assign_calculated_values(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r = 1.;
 assign_calculated_values ( _p, _ppvar, _thread, _nt );
 hoc_retpushx(_r);
}
 
/*CVODE*/
 static int _ode_spec1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset = 0; {
   DPKC_Ca = ReactionFlux0 - ReactionFlux1 - ReactionFlux2 - ReactionFlux4 ;
   DPKC_DAG_AA_p = ReactionFlux5 ;
   DPKC_Ca_AA_p = ReactionFlux4 ;
   DPKC_Ca_memb_p = ReactionFlux2 ;
   DPKC_DAG_memb_p = ReactionFlux3 ;
   DPKC_basal_p = ReactionFlux6 ;
   DPKC_AA_p = ReactionFlux7 ;
   DPKC_Ca_DAG = ReactionFlux1 - ReactionFlux3 ;
   DPKC_DAG = ReactionFlux8 - ReactionFlux9 ;
   DPKC_DAG_AA = - ReactionFlux5 + ReactionFlux9 ;
   DPLA2_Ca_p = ReactionFlux10 - ReactionFlux11 - ReactionFlux42 + ReactionFlux43 ;
   DDAG_Ca_PLA2_p = ReactionFlux11 - ReactionFlux48 + ReactionFlux49 ;
   DPLA2_p_Ca = ReactionFlux13 - ReactionFlux50 + ReactionFlux51 ;
   DPLA2_p = - ReactionFlux13 - ReactionFlux14 + ReactionFlux57 ;
   DArachidonic_Acid = - ReactionFlux4 - ReactionFlux7 - ReactionFlux9 - ReactionFlux12 + ReactionFlux43 + ReactionFlux45 + ReactionFlux47 + ReactionFlux49 + ReactionFlux51 ;
   DPLC_Ca = ReactionFlux15 - ReactionFlux52 + ReactionFlux53 ;
   DPLC_Gq = - ReactionFlux18 ;
   DDAG = - ReactionFlux1 - ReactionFlux8 - ReactionFlux11 - ReactionFlux17 + ReactionFlux53 + ReactionFlux55 + ReactionFlux84 + ReactionFlux85 ;
   DIP3 = - ReactionFlux16 + ReactionFlux53 + ReactionFlux55 + ReactionFlux84 + ReactionFlux85 ;
   DMAPK_p_p = - ReactionFlux56 + ReactionFlux57 - ReactionFlux58 + ReactionFlux59 - ReactionFlux60 + ReactionFlux61 + ReactionFlux65 - ReactionFlux90 ;
   Dcraf_1_p = - ReactionFlux19 + ReactionFlux37 - ReactionFlux58 - ReactionFlux92 + ReactionFlux99 ;
   Dcraf_1_p_p = ReactionFlux59 - ReactionFlux98 ;
   DMAPK_p = ReactionFlux63 - ReactionFlux64 - ReactionFlux88 + ReactionFlux91 ;
   DMAPKK_p_p = - ReactionFlux62 + ReactionFlux63 - ReactionFlux64 + ReactionFlux65 + ReactionFlux69 - ReactionFlux94 ;
   DMAPKK_p = ReactionFlux67 - ReactionFlux68 + ReactionFlux95 - ReactionFlux96 ;
   DRaf_p_GTP_Ras = ReactionFlux19 - ReactionFlux66 + ReactionFlux67 - ReactionFlux68 + ReactionFlux69 ;
   Dcraf_1_p_ser259 = - ReactionFlux100 ;
   DGEF_p = - ReactionFlux20 + ReactionFlux41 - ReactionFlux72 + ReactionFlux73 ;
   DGTP_Ras = - ReactionFlux19 - ReactionFlux21 + ReactionFlux71 + ReactionFlux73 - ReactionFlux74 + ReactionFlux77 + ReactionFlux83 ;
   DGAP_p = - ReactionFlux22 + ReactionFlux39 ;
   Dinact_GEF_p = - ReactionFlux23 ;
   DL_EGFR = ReactionFlux24 - ReactionFlux25 - ReactionFlux78 + ReactionFlux79 - ReactionFlux80 + ReactionFlux81 ;
   DInternal_L_EGFR = ReactionFlux25 ;
   DSHC_p_Sos_Grb2 = ReactionFlux27 - ReactionFlux82 + ReactionFlux83 ;
   DSHC_p = - ReactionFlux26 - ReactionFlux27 - ReactionFlux31 + ReactionFlux81 ;
   DSos_p_Grb2 = ReactionFlux28 ;
   DSos_Grb2 = - ReactionFlux27 + ReactionFlux30 ;
   DSos_p = - ReactionFlux28 - ReactionFlux29 + ReactionFlux61 ;
   DSHC_p_Grb2_clx = ReactionFlux31 ;
   DPLC_g_p = - ReactionFlux33 - ReactionFlux35 + ReactionFlux87 ;
   DCa_PLC_g = ReactionFlux32 + ReactionFlux34 - ReactionFlux78 + ReactionFlux84 - ReactionFlux84 ;
   DCa_PLC_g_p = ReactionFlux33 - ReactionFlux34 + ReactionFlux79 + ReactionFlux85 - ReactionFlux85 ;
   DPKC_act_raf_cplx = ReactionFlux36 - ReactionFlux37 ;
   DPKC_inact_GAP_cplx = ReactionFlux38 - ReactionFlux39 ;
   DPKC_act_GEF_cplx = ReactionFlux40 - ReactionFlux41 ;
   Dkenz_cplx = ReactionFlux42 - ReactionFlux43 ;
   Dkenz_cplx_1 = ReactionFlux44 - ReactionFlux45 ;
   Dkenz_cplx_2 = ReactionFlux46 - ReactionFlux47 ;
   Dkenz_cplx_3 = ReactionFlux48 - ReactionFlux49 ;
   Dkenz_cplx_4 = ReactionFlux50 - ReactionFlux51 ;
   DPLC_Ca_cplx = ReactionFlux52 - ReactionFlux53 ;
   DPLCb_Ca_Gq_cplx = ReactionFlux54 - ReactionFlux55 ;
   DMAPK_p_p_cplx = ReactionFlux56 - ReactionFlux57 ;
   DMAPK_p_p_feedback_cplx = ReactionFlux58 - ReactionFlux59 ;
   Dphosph_Sos_cplx = ReactionFlux60 - ReactionFlux61 ;
   DMAPKKtyr_cplx = ReactionFlux62 - ReactionFlux63 ;
   DMAPKKthr_cplx = ReactionFlux64 - ReactionFlux65 ;
   DRaf_p_GTP_Ras_1_cplx = ReactionFlux66 - ReactionFlux67 ;
   DRaf_p_GTP_Ras_2_cplx = ReactionFlux68 - ReactionFlux69 ;
   Dbasal_GEF_activity_cplx = ReactionFlux70 - ReactionFlux71 ;
   DGEF_p_act_Ras_cplx = ReactionFlux72 - ReactionFlux73 ;
   DGAP_inact_Ras_cplx = ReactionFlux74 - ReactionFlux75 ;
   DCaM_GEF_act_Ras_cplx = ReactionFlux76 - ReactionFlux77 ;
   DCa_PLC_g_phospho_cplx = ReactionFlux78 - ReactionFlux79 ;
   DSHC_phospho_cplx = ReactionFlux80 - ReactionFlux81 ;
   DSos_Ras_GEF_cplx = ReactionFlux82 - ReactionFlux83 ;
   DPLC_g_phospho_cplx = ReactionFlux86 - ReactionFlux87 ;
   DMKP1_tyr_deph_cplx = ReactionFlux88 - ReactionFlux89 ;
   DMKP1_thr_deph_cplx = ReactionFlux90 - ReactionFlux91 ;
   Dcraf_dephospho_cplx = ReactionFlux92 - ReactionFlux93 ;
   DMAPKK_dephospho_cplx = ReactionFlux94 - ReactionFlux95 ;
   DMAPKK_dephospho_ser_cplx = ReactionFlux96 - ReactionFlux97 ;
   Dcraf_p_p_dephospho_cplx = ReactionFlux98 - ReactionFlux99 ;
   Ddeph_raf_ser259_cplx = ReactionFlux100 - ReactionFlux101 ;
   }
 return _reset;
}
 static int _ode_matsol1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
 DPKC_Ca = DPKC_Ca  / (1. - dt*( 0.0 )) ;
 DPKC_DAG_AA_p = DPKC_DAG_AA_p  / (1. - dt*( 0.0 )) ;
 DPKC_Ca_AA_p = DPKC_Ca_AA_p  / (1. - dt*( 0.0 )) ;
 DPKC_Ca_memb_p = DPKC_Ca_memb_p  / (1. - dt*( 0.0 )) ;
 DPKC_DAG_memb_p = DPKC_DAG_memb_p  / (1. - dt*( 0.0 )) ;
 DPKC_basal_p = DPKC_basal_p  / (1. - dt*( 0.0 )) ;
 DPKC_AA_p = DPKC_AA_p  / (1. - dt*( 0.0 )) ;
 DPKC_Ca_DAG = DPKC_Ca_DAG  / (1. - dt*( 0.0 )) ;
 DPKC_DAG = DPKC_DAG  / (1. - dt*( 0.0 )) ;
 DPKC_DAG_AA = DPKC_DAG_AA  / (1. - dt*( 0.0 )) ;
 DPLA2_Ca_p = DPLA2_Ca_p  / (1. - dt*( 0.0 )) ;
 DDAG_Ca_PLA2_p = DDAG_Ca_PLA2_p  / (1. - dt*( 0.0 )) ;
 DPLA2_p_Ca = DPLA2_p_Ca  / (1. - dt*( 0.0 )) ;
 DPLA2_p = DPLA2_p  / (1. - dt*( 0.0 )) ;
 DArachidonic_Acid = DArachidonic_Acid  / (1. - dt*( 0.0 )) ;
 DPLC_Ca = DPLC_Ca  / (1. - dt*( 0.0 )) ;
 DPLC_Gq = DPLC_Gq  / (1. - dt*( 0.0 )) ;
 DDAG = DDAG  / (1. - dt*( 0.0 )) ;
 DIP3 = DIP3  / (1. - dt*( 0.0 )) ;
 DMAPK_p_p = DMAPK_p_p  / (1. - dt*( 0.0 )) ;
 Dcraf_1_p = Dcraf_1_p  / (1. - dt*( 0.0 )) ;
 Dcraf_1_p_p = Dcraf_1_p_p  / (1. - dt*( 0.0 )) ;
 DMAPK_p = DMAPK_p  / (1. - dt*( 0.0 )) ;
 DMAPKK_p_p = DMAPKK_p_p  / (1. - dt*( 0.0 )) ;
 DMAPKK_p = DMAPKK_p  / (1. - dt*( 0.0 )) ;
 DRaf_p_GTP_Ras = DRaf_p_GTP_Ras  / (1. - dt*( 0.0 )) ;
 Dcraf_1_p_ser259 = Dcraf_1_p_ser259  / (1. - dt*( 0.0 )) ;
 DGEF_p = DGEF_p  / (1. - dt*( 0.0 )) ;
 DGTP_Ras = DGTP_Ras  / (1. - dt*( 0.0 )) ;
 DGAP_p = DGAP_p  / (1. - dt*( 0.0 )) ;
 Dinact_GEF_p = Dinact_GEF_p  / (1. - dt*( 0.0 )) ;
 DL_EGFR = DL_EGFR  / (1. - dt*( 0.0 )) ;
 DInternal_L_EGFR = DInternal_L_EGFR  / (1. - dt*( 0.0 )) ;
 DSHC_p_Sos_Grb2 = DSHC_p_Sos_Grb2  / (1. - dt*( 0.0 )) ;
 DSHC_p = DSHC_p  / (1. - dt*( 0.0 )) ;
 DSos_p_Grb2 = DSos_p_Grb2  / (1. - dt*( 0.0 )) ;
 DSos_Grb2 = DSos_Grb2  / (1. - dt*( 0.0 )) ;
 DSos_p = DSos_p  / (1. - dt*( 0.0 )) ;
 DSHC_p_Grb2_clx = DSHC_p_Grb2_clx  / (1. - dt*( 0.0 )) ;
 DPLC_g_p = DPLC_g_p  / (1. - dt*( 0.0 )) ;
 DCa_PLC_g = DCa_PLC_g  / (1. - dt*( 0.0 )) ;
 DCa_PLC_g_p = DCa_PLC_g_p  / (1. - dt*( 0.0 )) ;
 DPKC_act_raf_cplx = DPKC_act_raf_cplx  / (1. - dt*( 0.0 )) ;
 DPKC_inact_GAP_cplx = DPKC_inact_GAP_cplx  / (1. - dt*( 0.0 )) ;
 DPKC_act_GEF_cplx = DPKC_act_GEF_cplx  / (1. - dt*( 0.0 )) ;
 Dkenz_cplx = Dkenz_cplx  / (1. - dt*( 0.0 )) ;
 Dkenz_cplx_1 = Dkenz_cplx_1  / (1. - dt*( 0.0 )) ;
 Dkenz_cplx_2 = Dkenz_cplx_2  / (1. - dt*( 0.0 )) ;
 Dkenz_cplx_3 = Dkenz_cplx_3  / (1. - dt*( 0.0 )) ;
 Dkenz_cplx_4 = Dkenz_cplx_4  / (1. - dt*( 0.0 )) ;
 DPLC_Ca_cplx = DPLC_Ca_cplx  / (1. - dt*( 0.0 )) ;
 DPLCb_Ca_Gq_cplx = DPLCb_Ca_Gq_cplx  / (1. - dt*( 0.0 )) ;
 DMAPK_p_p_cplx = DMAPK_p_p_cplx  / (1. - dt*( 0.0 )) ;
 DMAPK_p_p_feedback_cplx = DMAPK_p_p_feedback_cplx  / (1. - dt*( 0.0 )) ;
 Dphosph_Sos_cplx = Dphosph_Sos_cplx  / (1. - dt*( 0.0 )) ;
 DMAPKKtyr_cplx = DMAPKKtyr_cplx  / (1. - dt*( 0.0 )) ;
 DMAPKKthr_cplx = DMAPKKthr_cplx  / (1. - dt*( 0.0 )) ;
 DRaf_p_GTP_Ras_1_cplx = DRaf_p_GTP_Ras_1_cplx  / (1. - dt*( 0.0 )) ;
 DRaf_p_GTP_Ras_2_cplx = DRaf_p_GTP_Ras_2_cplx  / (1. - dt*( 0.0 )) ;
 Dbasal_GEF_activity_cplx = Dbasal_GEF_activity_cplx  / (1. - dt*( 0.0 )) ;
 DGEF_p_act_Ras_cplx = DGEF_p_act_Ras_cplx  / (1. - dt*( 0.0 )) ;
 DGAP_inact_Ras_cplx = DGAP_inact_Ras_cplx  / (1. - dt*( 0.0 )) ;
 DCaM_GEF_act_Ras_cplx = DCaM_GEF_act_Ras_cplx  / (1. - dt*( 0.0 )) ;
 DCa_PLC_g_phospho_cplx = DCa_PLC_g_phospho_cplx  / (1. - dt*( 0.0 )) ;
 DSHC_phospho_cplx = DSHC_phospho_cplx  / (1. - dt*( 0.0 )) ;
 DSos_Ras_GEF_cplx = DSos_Ras_GEF_cplx  / (1. - dt*( 0.0 )) ;
 DPLC_g_phospho_cplx = DPLC_g_phospho_cplx  / (1. - dt*( 0.0 )) ;
 DMKP1_tyr_deph_cplx = DMKP1_tyr_deph_cplx  / (1. - dt*( 0.0 )) ;
 DMKP1_thr_deph_cplx = DMKP1_thr_deph_cplx  / (1. - dt*( 0.0 )) ;
 Dcraf_dephospho_cplx = Dcraf_dephospho_cplx  / (1. - dt*( 0.0 )) ;
 DMAPKK_dephospho_cplx = DMAPKK_dephospho_cplx  / (1. - dt*( 0.0 )) ;
 DMAPKK_dephospho_ser_cplx = DMAPKK_dephospho_ser_cplx  / (1. - dt*( 0.0 )) ;
 Dcraf_p_p_dephospho_cplx = Dcraf_p_p_dephospho_cplx  / (1. - dt*( 0.0 )) ;
 Ddeph_raf_ser259_cplx = Ddeph_raf_ser259_cplx  / (1. - dt*( 0.0 )) ;
  return 0;
}
 /*END CVODE*/
 static int ode (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) { {
    PKC_Ca = PKC_Ca - dt*(- ( ReactionFlux0 - ReactionFlux1 - ReactionFlux2 - ReactionFlux4 ) ) ;
    PKC_DAG_AA_p = PKC_DAG_AA_p - dt*(- ( ReactionFlux5 ) ) ;
    PKC_Ca_AA_p = PKC_Ca_AA_p - dt*(- ( ReactionFlux4 ) ) ;
    PKC_Ca_memb_p = PKC_Ca_memb_p - dt*(- ( ReactionFlux2 ) ) ;
    PKC_DAG_memb_p = PKC_DAG_memb_p - dt*(- ( ReactionFlux3 ) ) ;
    PKC_basal_p = PKC_basal_p - dt*(- ( ReactionFlux6 ) ) ;
    PKC_AA_p = PKC_AA_p - dt*(- ( ReactionFlux7 ) ) ;
    PKC_Ca_DAG = PKC_Ca_DAG - dt*(- ( ReactionFlux1 - ReactionFlux3 ) ) ;
    PKC_DAG = PKC_DAG - dt*(- ( ReactionFlux8 - ReactionFlux9 ) ) ;
    PKC_DAG_AA = PKC_DAG_AA - dt*(- ( - ReactionFlux5 + ReactionFlux9 ) ) ;
    PLA2_Ca_p = PLA2_Ca_p - dt*(- ( ReactionFlux10 - ReactionFlux11 - ReactionFlux42 + ReactionFlux43 ) ) ;
    DAG_Ca_PLA2_p = DAG_Ca_PLA2_p - dt*(- ( ReactionFlux11 - ReactionFlux48 + ReactionFlux49 ) ) ;
    PLA2_p_Ca = PLA2_p_Ca - dt*(- ( ReactionFlux13 - ReactionFlux50 + ReactionFlux51 ) ) ;
    PLA2_p = PLA2_p - dt*(- ( - ReactionFlux13 - ReactionFlux14 + ReactionFlux57 ) ) ;
    Arachidonic_Acid = Arachidonic_Acid - dt*(- ( - ReactionFlux4 - ReactionFlux7 - ReactionFlux9 - ReactionFlux12 + ReactionFlux43 + ReactionFlux45 + ReactionFlux47 + ReactionFlux49 + ReactionFlux51 ) ) ;
    PLC_Ca = PLC_Ca - dt*(- ( ReactionFlux15 - ReactionFlux52 + ReactionFlux53 ) ) ;
    PLC_Gq = PLC_Gq - dt*(- ( - ReactionFlux18 ) ) ;
    DAG = DAG - dt*(- ( - ReactionFlux1 - ReactionFlux8 - ReactionFlux11 - ReactionFlux17 + ReactionFlux53 + ReactionFlux55 + ReactionFlux84 + ReactionFlux85 ) ) ;
    IP3 = IP3 - dt*(- ( - ReactionFlux16 + ReactionFlux53 + ReactionFlux55 + ReactionFlux84 + ReactionFlux85 ) ) ;
    MAPK_p_p = MAPK_p_p - dt*(- ( - ReactionFlux56 + ReactionFlux57 - ReactionFlux58 + ReactionFlux59 - ReactionFlux60 + ReactionFlux61 + ReactionFlux65 - ReactionFlux90 ) ) ;
    craf_1_p = craf_1_p - dt*(- ( - ReactionFlux19 + ReactionFlux37 - ReactionFlux58 - ReactionFlux92 + ReactionFlux99 ) ) ;
    craf_1_p_p = craf_1_p_p - dt*(- ( ReactionFlux59 - ReactionFlux98 ) ) ;
    MAPK_p = MAPK_p - dt*(- ( ReactionFlux63 - ReactionFlux64 - ReactionFlux88 + ReactionFlux91 ) ) ;
    MAPKK_p_p = MAPKK_p_p - dt*(- ( - ReactionFlux62 + ReactionFlux63 - ReactionFlux64 + ReactionFlux65 + ReactionFlux69 - ReactionFlux94 ) ) ;
    MAPKK_p = MAPKK_p - dt*(- ( ReactionFlux67 - ReactionFlux68 + ReactionFlux95 - ReactionFlux96 ) ) ;
    Raf_p_GTP_Ras = Raf_p_GTP_Ras - dt*(- ( ReactionFlux19 - ReactionFlux66 + ReactionFlux67 - ReactionFlux68 + ReactionFlux69 ) ) ;
    craf_1_p_ser259 = craf_1_p_ser259 - dt*(- ( - ReactionFlux100 ) ) ;
    GEF_p = GEF_p - dt*(- ( - ReactionFlux20 + ReactionFlux41 - ReactionFlux72 + ReactionFlux73 ) ) ;
    GTP_Ras = GTP_Ras - dt*(- ( - ReactionFlux19 - ReactionFlux21 + ReactionFlux71 + ReactionFlux73 - ReactionFlux74 + ReactionFlux77 + ReactionFlux83 ) ) ;
    GAP_p = GAP_p - dt*(- ( - ReactionFlux22 + ReactionFlux39 ) ) ;
    inact_GEF_p = inact_GEF_p - dt*(- ( - ReactionFlux23 ) ) ;
    L_EGFR = L_EGFR - dt*(- ( ReactionFlux24 - ReactionFlux25 - ReactionFlux78 + ReactionFlux79 - ReactionFlux80 + ReactionFlux81 ) ) ;
    Internal_L_EGFR = Internal_L_EGFR - dt*(- ( ReactionFlux25 ) ) ;
    SHC_p_Sos_Grb2 = SHC_p_Sos_Grb2 - dt*(- ( ReactionFlux27 - ReactionFlux82 + ReactionFlux83 ) ) ;
    SHC_p = SHC_p - dt*(- ( - ReactionFlux26 - ReactionFlux27 - ReactionFlux31 + ReactionFlux81 ) ) ;
    Sos_p_Grb2 = Sos_p_Grb2 - dt*(- ( ReactionFlux28 ) ) ;
    Sos_Grb2 = Sos_Grb2 - dt*(- ( - ReactionFlux27 + ReactionFlux30 ) ) ;
    Sos_p = Sos_p - dt*(- ( - ReactionFlux28 - ReactionFlux29 + ReactionFlux61 ) ) ;
    SHC_p_Grb2_clx = SHC_p_Grb2_clx - dt*(- ( ReactionFlux31 ) ) ;
    PLC_g_p = PLC_g_p - dt*(- ( - ReactionFlux33 - ReactionFlux35 + ReactionFlux87 ) ) ;
    Ca_PLC_g = Ca_PLC_g - dt*(- ( ReactionFlux32 + ReactionFlux34 - ReactionFlux78 + ReactionFlux84 - ReactionFlux84 ) ) ;
    Ca_PLC_g_p = Ca_PLC_g_p - dt*(- ( ReactionFlux33 - ReactionFlux34 + ReactionFlux79 + ReactionFlux85 - ReactionFlux85 ) ) ;
    PKC_act_raf_cplx = PKC_act_raf_cplx - dt*(- ( ReactionFlux36 - ReactionFlux37 ) ) ;
    PKC_inact_GAP_cplx = PKC_inact_GAP_cplx - dt*(- ( ReactionFlux38 - ReactionFlux39 ) ) ;
    PKC_act_GEF_cplx = PKC_act_GEF_cplx - dt*(- ( ReactionFlux40 - ReactionFlux41 ) ) ;
    kenz_cplx = kenz_cplx - dt*(- ( ReactionFlux42 - ReactionFlux43 ) ) ;
    kenz_cplx_1 = kenz_cplx_1 - dt*(- ( ReactionFlux44 - ReactionFlux45 ) ) ;
    kenz_cplx_2 = kenz_cplx_2 - dt*(- ( ReactionFlux46 - ReactionFlux47 ) ) ;
    kenz_cplx_3 = kenz_cplx_3 - dt*(- ( ReactionFlux48 - ReactionFlux49 ) ) ;
    kenz_cplx_4 = kenz_cplx_4 - dt*(- ( ReactionFlux50 - ReactionFlux51 ) ) ;
    PLC_Ca_cplx = PLC_Ca_cplx - dt*(- ( ReactionFlux52 - ReactionFlux53 ) ) ;
    PLCb_Ca_Gq_cplx = PLCb_Ca_Gq_cplx - dt*(- ( ReactionFlux54 - ReactionFlux55 ) ) ;
    MAPK_p_p_cplx = MAPK_p_p_cplx - dt*(- ( ReactionFlux56 - ReactionFlux57 ) ) ;
    MAPK_p_p_feedback_cplx = MAPK_p_p_feedback_cplx - dt*(- ( ReactionFlux58 - ReactionFlux59 ) ) ;
    phosph_Sos_cplx = phosph_Sos_cplx - dt*(- ( ReactionFlux60 - ReactionFlux61 ) ) ;
    MAPKKtyr_cplx = MAPKKtyr_cplx - dt*(- ( ReactionFlux62 - ReactionFlux63 ) ) ;
    MAPKKthr_cplx = MAPKKthr_cplx - dt*(- ( ReactionFlux64 - ReactionFlux65 ) ) ;
    Raf_p_GTP_Ras_1_cplx = Raf_p_GTP_Ras_1_cplx - dt*(- ( ReactionFlux66 - ReactionFlux67 ) ) ;
    Raf_p_GTP_Ras_2_cplx = Raf_p_GTP_Ras_2_cplx - dt*(- ( ReactionFlux68 - ReactionFlux69 ) ) ;
    basal_GEF_activity_cplx = basal_GEF_activity_cplx - dt*(- ( ReactionFlux70 - ReactionFlux71 ) ) ;
    GEF_p_act_Ras_cplx = GEF_p_act_Ras_cplx - dt*(- ( ReactionFlux72 - ReactionFlux73 ) ) ;
    GAP_inact_Ras_cplx = GAP_inact_Ras_cplx - dt*(- ( ReactionFlux74 - ReactionFlux75 ) ) ;
    CaM_GEF_act_Ras_cplx = CaM_GEF_act_Ras_cplx - dt*(- ( ReactionFlux76 - ReactionFlux77 ) ) ;
    Ca_PLC_g_phospho_cplx = Ca_PLC_g_phospho_cplx - dt*(- ( ReactionFlux78 - ReactionFlux79 ) ) ;
    SHC_phospho_cplx = SHC_phospho_cplx - dt*(- ( ReactionFlux80 - ReactionFlux81 ) ) ;
    Sos_Ras_GEF_cplx = Sos_Ras_GEF_cplx - dt*(- ( ReactionFlux82 - ReactionFlux83 ) ) ;
    PLC_g_phospho_cplx = PLC_g_phospho_cplx - dt*(- ( ReactionFlux86 - ReactionFlux87 ) ) ;
    MKP1_tyr_deph_cplx = MKP1_tyr_deph_cplx - dt*(- ( ReactionFlux88 - ReactionFlux89 ) ) ;
    MKP1_thr_deph_cplx = MKP1_thr_deph_cplx - dt*(- ( ReactionFlux90 - ReactionFlux91 ) ) ;
    craf_dephospho_cplx = craf_dephospho_cplx - dt*(- ( ReactionFlux92 - ReactionFlux93 ) ) ;
    MAPKK_dephospho_cplx = MAPKK_dephospho_cplx - dt*(- ( ReactionFlux94 - ReactionFlux95 ) ) ;
    MAPKK_dephospho_ser_cplx = MAPKK_dephospho_ser_cplx - dt*(- ( ReactionFlux96 - ReactionFlux97 ) ) ;
    craf_p_p_dephospho_cplx = craf_p_p_dephospho_cplx - dt*(- ( ReactionFlux98 - ReactionFlux99 ) ) ;
    deph_raf_ser259_cplx = deph_raf_ser259_cplx - dt*(- ( ReactionFlux100 - ReactionFlux101 ) ) ;
   }
  return 0;
}
 
static int  observables_func ( _threadargsproto_ ) {
   pERK1_2_ratio1 = ( MAPK_p + MAPK_p_p + MAPK_p_p_cplx + MAPK_p_p_feedback_cplx ) ;
   MAPK_out = MAPK ;
   MAPK_p_out = MAPK_p ;
   MAPK_p_p_out = MAPK_p_p ;
   MAPK_p_p_cplx_out = MAPK_p_p_cplx ;
   MAPK_p_p_feedback_cplx_out = MAPK_p_p_feedback_cplx ;
   pERK1_2_ratio2 = ( MAPK_p + MAPK_p_p + MAPK_p_p_cplx + MAPK_p_p_feedback_cplx ) ;
    return 0; }
 
static void _hoc_observables_func(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r = 1.;
 observables_func ( _p, _ppvar, _thread, _nt );
 hoc_retpushx(_r);
}
 
static int _ode_count(int _type){ return 74;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
     _ode_spec1 (_p, _ppvar, _thread, _nt);
 }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 74; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static void _ode_matsol_instance1(_threadargsproto_) {
 _ode_matsol1 (_p, _ppvar, _thread, _nt);
 }
 
static void _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
 _ode_matsol_instance1(_threadargs_);
 }}

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
  Arachidonic_Acid = Arachidonic_Acid0;
  Ca_PLC_g_phospho_cplx = Ca_PLC_g_phospho_cplx0;
  CaM_GEF_act_Ras_cplx = CaM_GEF_act_Ras_cplx0;
  Ca_PLC_g_p = Ca_PLC_g_p0;
  Ca_PLC_g = Ca_PLC_g0;
  DAG = DAG0;
  DAG_Ca_PLA2_p = DAG_Ca_PLA2_p0;
  GAP_inact_Ras_cplx = GAP_inact_Ras_cplx0;
  GEF_p_act_Ras_cplx = GEF_p_act_Ras_cplx0;
  GAP_p = GAP_p0;
  GTP_Ras = GTP_Ras0;
  GEF_p = GEF_p0;
  Internal_L_EGFR = Internal_L_EGFR0;
  IP3 = IP30;
  L_EGFR = L_EGFR0;
  MAPKK_dephospho_ser_cplx = MAPKK_dephospho_ser_cplx0;
  MAPKK_dephospho_cplx = MAPKK_dephospho_cplx0;
  MKP1_thr_deph_cplx = MKP1_thr_deph_cplx0;
  MKP1_tyr_deph_cplx = MKP1_tyr_deph_cplx0;
  MAPKKthr_cplx = MAPKKthr_cplx0;
  MAPKKtyr_cplx = MAPKKtyr_cplx0;
  MAPK_p_p_feedback_cplx = MAPK_p_p_feedback_cplx0;
  MAPK_p_p_cplx = MAPK_p_p_cplx0;
  MAPKK_p = MAPKK_p0;
  MAPKK_p_p = MAPKK_p_p0;
  MAPK_p = MAPK_p0;
  MAPK_p_p = MAPK_p_p0;
  PLC_g_phospho_cplx = PLC_g_phospho_cplx0;
  PLCb_Ca_Gq_cplx = PLCb_Ca_Gq_cplx0;
  PLC_Ca_cplx = PLC_Ca_cplx0;
  PKC_act_GEF_cplx = PKC_act_GEF_cplx0;
  PKC_inact_GAP_cplx = PKC_inact_GAP_cplx0;
  PKC_act_raf_cplx = PKC_act_raf_cplx0;
  PLC_g_p = PLC_g_p0;
  PLC_Gq = PLC_Gq0;
  PLC_Ca = PLC_Ca0;
  PLA2_p = PLA2_p0;
  PLA2_p_Ca = PLA2_p_Ca0;
  PLA2_Ca_p = PLA2_Ca_p0;
  PKC_DAG_AA = PKC_DAG_AA0;
  PKC_DAG = PKC_DAG0;
  PKC_Ca_DAG = PKC_Ca_DAG0;
  PKC_AA_p = PKC_AA_p0;
  PKC_basal_p = PKC_basal_p0;
  PKC_DAG_memb_p = PKC_DAG_memb_p0;
  PKC_Ca_memb_p = PKC_Ca_memb_p0;
  PKC_Ca_AA_p = PKC_Ca_AA_p0;
  PKC_DAG_AA_p = PKC_DAG_AA_p0;
  PKC_Ca = PKC_Ca0;
  Raf_p_GTP_Ras_2_cplx = Raf_p_GTP_Ras_2_cplx0;
  Raf_p_GTP_Ras_1_cplx = Raf_p_GTP_Ras_1_cplx0;
  Raf_p_GTP_Ras = Raf_p_GTP_Ras0;
  Sos_Ras_GEF_cplx = Sos_Ras_GEF_cplx0;
  SHC_phospho_cplx = SHC_phospho_cplx0;
  SHC_p_Grb2_clx = SHC_p_Grb2_clx0;
  Sos_p = Sos_p0;
  Sos_Grb2 = Sos_Grb20;
  Sos_p_Grb2 = Sos_p_Grb20;
  SHC_p = SHC_p0;
  SHC_p_Sos_Grb2 = SHC_p_Sos_Grb20;
  basal_GEF_activity_cplx = basal_GEF_activity_cplx0;
  craf_p_p_dephospho_cplx = craf_p_p_dephospho_cplx0;
  craf_dephospho_cplx = craf_dephospho_cplx0;
  craf_1_p_ser259 = craf_1_p_ser2590;
  craf_1_p_p = craf_1_p_p0;
  craf_1_p = craf_1_p0;
  deph_raf_ser259_cplx = deph_raf_ser259_cplx0;
  inact_GEF_p = inact_GEF_p0;
  kenz_cplx_4 = kenz_cplx_40;
  kenz_cplx_3 = kenz_cplx_30;
  kenz_cplx_2 = kenz_cplx_20;
  kenz_cplx_1 = kenz_cplx_10;
  kenz_cplx = kenz_cplx0;
  phosph_Sos_cplx = phosph_Sos_cplx0;
 {
   PKC_Ca = 0.0 ;
   PKC_DAG_AA_p = 0.0 ;
   PKC_Ca_AA_p = 0.0 ;
   PKC_Ca_memb_p = 0.0 ;
   PKC_DAG_memb_p = 0.0 ;
   PKC_basal_p = 2e-05 ;
   PKC_AA_p = 0.0 ;
   PKC_Ca_DAG = 0.0 ;
   PKC_DAG = 0.0 ;
   PKC_DAG_AA = 0.0 ;
   PLA2_Ca_p = 0.0 ;
   DAG_Ca_PLA2_p = 0.0 ;
   PLA2_p_Ca = 0.0 ;
   PLA2_p = 0.0 ;
   Arachidonic_Acid = 0.0 ;
   PLC_Ca = 0.0 ;
   PLC_Gq = 0.0 ;
   DAG = 0.0 ;
   IP3 = 0.00073 ;
   MAPK_p_p = 0.0 ;
   craf_1_p = 0.0 ;
   craf_1_p_p = 0.0 ;
   MAPK_p = 0.0 ;
   MAPKK_p_p = 0.0 ;
   MAPKK_p = 0.0 ;
   Raf_p_GTP_Ras = 0.0 ;
   craf_1_p_ser259 = 0.0 ;
   GEF_p = 0.0 ;
   GTP_Ras = 0.0 ;
   GAP_p = 0.0 ;
   inact_GEF_p = 0.0 ;
   L_EGFR = 0.0 ;
   Internal_L_EGFR = 0.0 ;
   SHC_p_Sos_Grb2 = 0.0 ;
   SHC_p = 0.0 ;
   Sos_p_Grb2 = 0.0 ;
   Sos_Grb2 = 0.0 ;
   Sos_p = 0.0 ;
   SHC_p_Grb2_clx = 0.0 ;
   PLC_g_p = 0.0 ;
   Ca_PLC_g = 0.0 ;
   Ca_PLC_g_p = 0.0 ;
   PKC_act_raf_cplx = 0.0 ;
   PKC_inact_GAP_cplx = 0.0 ;
   PKC_act_GEF_cplx = 0.0 ;
   kenz_cplx = 0.0 ;
   kenz_cplx_1 = 0.0 ;
   kenz_cplx_2 = 0.0 ;
   kenz_cplx_3 = 0.0 ;
   kenz_cplx_4 = 0.0 ;
   PLC_Ca_cplx = 0.0 ;
   PLCb_Ca_Gq_cplx = 0.0 ;
   MAPK_p_p_cplx = 0.0 ;
   MAPK_p_p_feedback_cplx = 0.0 ;
   phosph_Sos_cplx = 0.0 ;
   MAPKKtyr_cplx = 0.0 ;
   MAPKKthr_cplx = 0.0 ;
   Raf_p_GTP_Ras_1_cplx = 0.0 ;
   Raf_p_GTP_Ras_2_cplx = 0.0 ;
   basal_GEF_activity_cplx = 0.0 ;
   GEF_p_act_Ras_cplx = 0.0 ;
   GAP_inact_Ras_cplx = 0.0 ;
   CaM_GEF_act_Ras_cplx = 0.0 ;
   Ca_PLC_g_phospho_cplx = 0.0 ;
   SHC_phospho_cplx = 0.0 ;
   Sos_Ras_GEF_cplx = 0.0 ;
   PLC_g_phospho_cplx = 0.0 ;
   MKP1_tyr_deph_cplx = 0.0 ;
   MKP1_thr_deph_cplx = 0.0 ;
   craf_dephospho_cplx = 0.0 ;
   MAPKK_dephospho_cplx = 0.0 ;
   MAPKK_dephospho_ser_cplx = 0.0 ;
   craf_p_p_dephospho_cplx = 0.0 ;
   deph_raf_ser259_cplx = 0.0 ;
   }
 
}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
 initmodel(_p, _ppvar, _thread, _nt);
}
}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _v){double _current=0.;v=_v;{
} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 
}
 
}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}
 
}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v = 0.0; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v=_v;
{
 {   ode(_p, _ppvar, _thread, _nt);
  } {
   assign_calculated_values ( _threadargs_ ) ;
   }
}}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(PKC_Ca) - _p;  _dlist1[0] = &(DPKC_Ca) - _p;
 _slist1[1] = &(PKC_DAG_AA_p) - _p;  _dlist1[1] = &(DPKC_DAG_AA_p) - _p;
 _slist1[2] = &(PKC_Ca_AA_p) - _p;  _dlist1[2] = &(DPKC_Ca_AA_p) - _p;
 _slist1[3] = &(PKC_Ca_memb_p) - _p;  _dlist1[3] = &(DPKC_Ca_memb_p) - _p;
 _slist1[4] = &(PKC_DAG_memb_p) - _p;  _dlist1[4] = &(DPKC_DAG_memb_p) - _p;
 _slist1[5] = &(PKC_basal_p) - _p;  _dlist1[5] = &(DPKC_basal_p) - _p;
 _slist1[6] = &(PKC_AA_p) - _p;  _dlist1[6] = &(DPKC_AA_p) - _p;
 _slist1[7] = &(PKC_Ca_DAG) - _p;  _dlist1[7] = &(DPKC_Ca_DAG) - _p;
 _slist1[8] = &(PKC_DAG) - _p;  _dlist1[8] = &(DPKC_DAG) - _p;
 _slist1[9] = &(PKC_DAG_AA) - _p;  _dlist1[9] = &(DPKC_DAG_AA) - _p;
 _slist1[10] = &(PLA2_Ca_p) - _p;  _dlist1[10] = &(DPLA2_Ca_p) - _p;
 _slist1[11] = &(DAG_Ca_PLA2_p) - _p;  _dlist1[11] = &(DDAG_Ca_PLA2_p) - _p;
 _slist1[12] = &(PLA2_p_Ca) - _p;  _dlist1[12] = &(DPLA2_p_Ca) - _p;
 _slist1[13] = &(PLA2_p) - _p;  _dlist1[13] = &(DPLA2_p) - _p;
 _slist1[14] = &(Arachidonic_Acid) - _p;  _dlist1[14] = &(DArachidonic_Acid) - _p;
 _slist1[15] = &(PLC_Ca) - _p;  _dlist1[15] = &(DPLC_Ca) - _p;
 _slist1[16] = &(PLC_Gq) - _p;  _dlist1[16] = &(DPLC_Gq) - _p;
 _slist1[17] = &(DAG) - _p;  _dlist1[17] = &(DDAG) - _p;
 _slist1[18] = &(IP3) - _p;  _dlist1[18] = &(DIP3) - _p;
 _slist1[19] = &(MAPK_p_p) - _p;  _dlist1[19] = &(DMAPK_p_p) - _p;
 _slist1[20] = &(craf_1_p) - _p;  _dlist1[20] = &(Dcraf_1_p) - _p;
 _slist1[21] = &(craf_1_p_p) - _p;  _dlist1[21] = &(Dcraf_1_p_p) - _p;
 _slist1[22] = &(MAPK_p) - _p;  _dlist1[22] = &(DMAPK_p) - _p;
 _slist1[23] = &(MAPKK_p_p) - _p;  _dlist1[23] = &(DMAPKK_p_p) - _p;
 _slist1[24] = &(MAPKK_p) - _p;  _dlist1[24] = &(DMAPKK_p) - _p;
 _slist1[25] = &(Raf_p_GTP_Ras) - _p;  _dlist1[25] = &(DRaf_p_GTP_Ras) - _p;
 _slist1[26] = &(craf_1_p_ser259) - _p;  _dlist1[26] = &(Dcraf_1_p_ser259) - _p;
 _slist1[27] = &(GEF_p) - _p;  _dlist1[27] = &(DGEF_p) - _p;
 _slist1[28] = &(GTP_Ras) - _p;  _dlist1[28] = &(DGTP_Ras) - _p;
 _slist1[29] = &(GAP_p) - _p;  _dlist1[29] = &(DGAP_p) - _p;
 _slist1[30] = &(inact_GEF_p) - _p;  _dlist1[30] = &(Dinact_GEF_p) - _p;
 _slist1[31] = &(L_EGFR) - _p;  _dlist1[31] = &(DL_EGFR) - _p;
 _slist1[32] = &(Internal_L_EGFR) - _p;  _dlist1[32] = &(DInternal_L_EGFR) - _p;
 _slist1[33] = &(SHC_p_Sos_Grb2) - _p;  _dlist1[33] = &(DSHC_p_Sos_Grb2) - _p;
 _slist1[34] = &(SHC_p) - _p;  _dlist1[34] = &(DSHC_p) - _p;
 _slist1[35] = &(Sos_p_Grb2) - _p;  _dlist1[35] = &(DSos_p_Grb2) - _p;
 _slist1[36] = &(Sos_Grb2) - _p;  _dlist1[36] = &(DSos_Grb2) - _p;
 _slist1[37] = &(Sos_p) - _p;  _dlist1[37] = &(DSos_p) - _p;
 _slist1[38] = &(SHC_p_Grb2_clx) - _p;  _dlist1[38] = &(DSHC_p_Grb2_clx) - _p;
 _slist1[39] = &(PLC_g_p) - _p;  _dlist1[39] = &(DPLC_g_p) - _p;
 _slist1[40] = &(Ca_PLC_g) - _p;  _dlist1[40] = &(DCa_PLC_g) - _p;
 _slist1[41] = &(Ca_PLC_g_p) - _p;  _dlist1[41] = &(DCa_PLC_g_p) - _p;
 _slist1[42] = &(PKC_act_raf_cplx) - _p;  _dlist1[42] = &(DPKC_act_raf_cplx) - _p;
 _slist1[43] = &(PKC_inact_GAP_cplx) - _p;  _dlist1[43] = &(DPKC_inact_GAP_cplx) - _p;
 _slist1[44] = &(PKC_act_GEF_cplx) - _p;  _dlist1[44] = &(DPKC_act_GEF_cplx) - _p;
 _slist1[45] = &(kenz_cplx) - _p;  _dlist1[45] = &(Dkenz_cplx) - _p;
 _slist1[46] = &(kenz_cplx_1) - _p;  _dlist1[46] = &(Dkenz_cplx_1) - _p;
 _slist1[47] = &(kenz_cplx_2) - _p;  _dlist1[47] = &(Dkenz_cplx_2) - _p;
 _slist1[48] = &(kenz_cplx_3) - _p;  _dlist1[48] = &(Dkenz_cplx_3) - _p;
 _slist1[49] = &(kenz_cplx_4) - _p;  _dlist1[49] = &(Dkenz_cplx_4) - _p;
 _slist1[50] = &(PLC_Ca_cplx) - _p;  _dlist1[50] = &(DPLC_Ca_cplx) - _p;
 _slist1[51] = &(PLCb_Ca_Gq_cplx) - _p;  _dlist1[51] = &(DPLCb_Ca_Gq_cplx) - _p;
 _slist1[52] = &(MAPK_p_p_cplx) - _p;  _dlist1[52] = &(DMAPK_p_p_cplx) - _p;
 _slist1[53] = &(MAPK_p_p_feedback_cplx) - _p;  _dlist1[53] = &(DMAPK_p_p_feedback_cplx) - _p;
 _slist1[54] = &(phosph_Sos_cplx) - _p;  _dlist1[54] = &(Dphosph_Sos_cplx) - _p;
 _slist1[55] = &(MAPKKtyr_cplx) - _p;  _dlist1[55] = &(DMAPKKtyr_cplx) - _p;
 _slist1[56] = &(MAPKKthr_cplx) - _p;  _dlist1[56] = &(DMAPKKthr_cplx) - _p;
 _slist1[57] = &(Raf_p_GTP_Ras_1_cplx) - _p;  _dlist1[57] = &(DRaf_p_GTP_Ras_1_cplx) - _p;
 _slist1[58] = &(Raf_p_GTP_Ras_2_cplx) - _p;  _dlist1[58] = &(DRaf_p_GTP_Ras_2_cplx) - _p;
 _slist1[59] = &(basal_GEF_activity_cplx) - _p;  _dlist1[59] = &(Dbasal_GEF_activity_cplx) - _p;
 _slist1[60] = &(GEF_p_act_Ras_cplx) - _p;  _dlist1[60] = &(DGEF_p_act_Ras_cplx) - _p;
 _slist1[61] = &(GAP_inact_Ras_cplx) - _p;  _dlist1[61] = &(DGAP_inact_Ras_cplx) - _p;
 _slist1[62] = &(CaM_GEF_act_Ras_cplx) - _p;  _dlist1[62] = &(DCaM_GEF_act_Ras_cplx) - _p;
 _slist1[63] = &(Ca_PLC_g_phospho_cplx) - _p;  _dlist1[63] = &(DCa_PLC_g_phospho_cplx) - _p;
 _slist1[64] = &(SHC_phospho_cplx) - _p;  _dlist1[64] = &(DSHC_phospho_cplx) - _p;
 _slist1[65] = &(Sos_Ras_GEF_cplx) - _p;  _dlist1[65] = &(DSos_Ras_GEF_cplx) - _p;
 _slist1[66] = &(PLC_g_phospho_cplx) - _p;  _dlist1[66] = &(DPLC_g_phospho_cplx) - _p;
 _slist1[67] = &(MKP1_tyr_deph_cplx) - _p;  _dlist1[67] = &(DMKP1_tyr_deph_cplx) - _p;
 _slist1[68] = &(MKP1_thr_deph_cplx) - _p;  _dlist1[68] = &(DMKP1_thr_deph_cplx) - _p;
 _slist1[69] = &(craf_dephospho_cplx) - _p;  _dlist1[69] = &(Dcraf_dephospho_cplx) - _p;
 _slist1[70] = &(MAPKK_dephospho_cplx) - _p;  _dlist1[70] = &(DMAPKK_dephospho_cplx) - _p;
 _slist1[71] = &(MAPKK_dephospho_ser_cplx) - _p;  _dlist1[71] = &(DMAPKK_dephospho_ser_cplx) - _p;
 _slist1[72] = &(craf_p_p_dephospho_cplx) - _p;  _dlist1[72] = &(Dcraf_p_p_dephospho_cplx) - _p;
 _slist1[73] = &(deph_raf_ser259_cplx) - _p;  _dlist1[73] = &(Ddeph_raf_ser259_cplx) - _p;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "SBTAB_Findsim.mod";
static const char* nmodl_file_text = 
  "TITLE SBTAB_Findsim\n"
  "COMMENT\n"
  "	automatically generated from an SBtab file\n"
  "	date: Tue Feb  9 15:23:52 2021\n"
  "ENDCOMMENT\n"
  "NEURON {\n"
  "	SUFFIX SBTAB_Findsim : OR perhaps POINT_PROCESS ?\n"
  "	RANGE pERK1_2_ratio1 : output\n"
  "	RANGE MAPK_out : output\n"
  "	RANGE MAPK_p_out : output\n"
  "	RANGE MAPK_p_p_out : output\n"
  "	RANGE MAPK_p_p_cplx_out : output\n"
  "	RANGE MAPK_p_p_feedback_cplx_out : output\n"
  "	RANGE pERK1_2_ratio2 : output\n"
  "	RANGE PKC_active, PKC_active1, APC, Inositol, PC, PIP2, EGF, Ca : assigned\n"
  "	RANGE PKC_Ca : compound\n"
  "	RANGE PKC_DAG_AA_p : compound\n"
  "	RANGE PKC_Ca_AA_p : compound\n"
  "	RANGE PKC_Ca_memb_p : compound\n"
  "	RANGE PKC_DAG_memb_p : compound\n"
  "	RANGE PKC_basal_p : compound\n"
  "	RANGE PKC_AA_p : compound\n"
  "	RANGE PKC_Ca_DAG : compound\n"
  "	RANGE PKC_DAG : compound\n"
  "	RANGE PKC_DAG_AA : compound\n"
  "	RANGE PKC_cytosolic : compound\n"
  "	RANGE PLA2_cytosolic : compound\n"
  "	RANGE PLA2_Ca_p : compound\n"
  "	RANGE PIP2_PLA2_p : compound\n"
  "	RANGE PIP2_Ca_PLA2_p : compound\n"
  "	RANGE DAG_Ca_PLA2_p : compound\n"
  "	RANGE PLA2_p_Ca : compound\n"
  "	RANGE PLA2_p : compound\n"
  "	RANGE Arachidonic_Acid : compound\n"
  "	RANGE PLC : compound\n"
  "	RANGE PLC_Ca : compound\n"
  "	RANGE PLC_Ca_Gq : compound\n"
  "	RANGE PLC_Gq : compound\n"
  "	RANGE DAG : compound\n"
  "	RANGE IP3 : compound\n"
  "	RANGE MAPK_p_p : compound\n"
  "	RANGE craf_1 : compound\n"
  "	RANGE craf_1_p : compound\n"
  "	RANGE MAPKK : compound\n"
  "	RANGE MAPK : compound\n"
  "	RANGE craf_1_p_p : compound\n"
  "	RANGE MAPK_p : compound\n"
  "	RANGE MAPKK_p_p : compound\n"
  "	RANGE MAPKK_p : compound\n"
  "	RANGE Raf_p_GTP_Ras : compound\n"
  "	RANGE craf_1_p_ser259 : compound\n"
  "	RANGE inact_GEF : compound\n"
  "	RANGE GEF_p : compound\n"
  "	RANGE GTP_Ras : compound\n"
  "	RANGE GDP_Ras : compound\n"
  "	RANGE GAP_p : compound\n"
  "	RANGE GAP : compound\n"
  "	RANGE inact_GEF_p : compound\n"
  "	RANGE CaM_GEF : compound\n"
  "	RANGE EGFR : compound\n"
  "	RANGE L_EGFR : compound\n"
  "	RANGE Internal_L_EGFR : compound\n"
  "	RANGE SHC_p_Sos_Grb2 : compound\n"
  "	RANGE SHC : compound\n"
  "	RANGE SHC_p : compound\n"
  "	RANGE Sos_p_Grb2 : compound\n"
  "	RANGE Grb2 : compound\n"
  "	RANGE Sos_Grb2 : compound\n"
  "	RANGE Sos_p : compound\n"
  "	RANGE Sos : compound\n"
  "	RANGE SHC_p_Grb2_clx : compound\n"
  "	RANGE PLC_g : compound\n"
  "	RANGE PLC_g_p : compound\n"
  "	RANGE Ca_PLC_g : compound\n"
  "	RANGE Ca_PLC_g_p : compound\n"
  "	RANGE PLCg_basal : compound\n"
  "	RANGE MKP_1 : compound\n"
  "	RANGE PPhosphatase2A : compound\n"
  "	RANGE PKC_act_raf_cplx : compound\n"
  "	RANGE PKC_inact_GAP_cplx : compound\n"
  "	RANGE PKC_act_GEF_cplx : compound\n"
  "	RANGE kenz_cplx : compound\n"
  "	RANGE kenz_cplx_1 : compound\n"
  "	RANGE kenz_cplx_2 : compound\n"
  "	RANGE kenz_cplx_3 : compound\n"
  "	RANGE kenz_cplx_4 : compound\n"
  "	RANGE PLC_Ca_cplx : compound\n"
  "	RANGE PLCb_Ca_Gq_cplx : compound\n"
  "	RANGE MAPK_p_p_cplx : compound\n"
  "	RANGE MAPK_p_p_feedback_cplx : compound\n"
  "	RANGE phosph_Sos_cplx : compound\n"
  "	RANGE MAPKKtyr_cplx : compound\n"
  "	RANGE MAPKKthr_cplx : compound\n"
  "	RANGE Raf_p_GTP_Ras_1_cplx : compound\n"
  "	RANGE Raf_p_GTP_Ras_2_cplx : compound\n"
  "	RANGE basal_GEF_activity_cplx : compound\n"
  "	RANGE GEF_p_act_Ras_cplx : compound\n"
  "	RANGE GAP_inact_Ras_cplx : compound\n"
  "	RANGE CaM_GEF_act_Ras_cplx : compound\n"
  "	RANGE Ca_PLC_g_phospho_cplx : compound\n"
  "	RANGE SHC_phospho_cplx : compound\n"
  "	RANGE Sos_Ras_GEF_cplx : compound\n"
  "	RANGE PLC_g_phospho_cplx : compound\n"
  "	RANGE MKP1_tyr_deph_cplx : compound\n"
  "	RANGE MKP1_thr_deph_cplx : compound\n"
  "	RANGE craf_dephospho_cplx : compound\n"
  "	RANGE MAPKK_dephospho_cplx : compound\n"
  "	RANGE MAPKK_dephospho_ser_cplx : compound\n"
  "	RANGE craf_p_p_dephospho_cplx : compound\n"
  "	RANGE deph_raf_ser259_cplx : compound\n"
  ": USEION ca READ cai VALENCE 2 : sth. like this may be needed for ions you have in your model\n"
  "}\n"
  "CONSTANT {\n"
  "}\n"
  "PARAMETER {\n"
  "	kf_R1 = 599.929 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R1 = 0.5 (/second): a kinetic parameter\n"
  "	kf_R2 = 7.99982 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R2 = 8.63475 (/second): a kinetic parameter\n"
  "	kf_R3 = 1.27049 (/second): a kinetic parameter\n"
  "	kr_R3 = 3.5026 (/second): a kinetic parameter\n"
  "	kf_R4 = 1 (/second): a kinetic parameter\n"
  "	kr_R4 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R5 = 1.20001 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R5 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R6 = 2 (/second): a kinetic parameter\n"
  "	kr_R6 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R7 = 1 (/second): a kinetic parameter\n"
  "	kr_R7 = 50.0035 (/second): a kinetic parameter\n"
  "	kf_R8 = 0.12 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R8 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R9 = 0.599998 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R9 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R10 = 18.0011 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R10 = 2 (/second): a kinetic parameter\n"
  "	kf_R11 = 1000 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R11 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R12 = 2.99999 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R12 = 4 (/second): a kinetic parameter\n"
  "	kf_R13 = 0.4 (/second): a kinetic parameter\n"
  "	kf_R14 = 5999.29 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R14 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R15 = 0.17 (/second): a kinetic parameter\n"
  "	kf_R16 = 2999.85 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R16 = 1 (/second): a kinetic parameter\n"
  "	kf_R17 = 2.5 (/second): a kinetic parameter\n"
  "	kf_R18 = 0.15 (/second): a kinetic parameter\n"
  "	kf_R19 = 29998.5 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R19 = 1 (/second): a kinetic parameter\n"
  "	kf_R20 = 10000 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R20 = 0.5 (/second): a kinetic parameter\n"
  "	kf_R21 = 1 (/second): a kinetic parameter\n"
  "	kf_R22 = 0.0001 (/second): a kinetic parameter\n"
  "	kf_R23 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R24 = 1 (/second): a kinetic parameter\n"
  "	kf_R25 = 4199.52 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R25 = 0.25 (/second): a kinetic parameter\n"
  "	kf_R26 = 0.00199986 (/second): a kinetic parameter\n"
  "	kr_R26 = 0.000329989 (/second): a kinetic parameter\n"
  "	kf_R27 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R28 = 500.035 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R28 = 0.1 (/second): a kinetic parameter\n"
  "	kf_R29 = 24.9977 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R29 = 0.0167996 (/second): a kinetic parameter\n"
  "	kf_R30 = 0.001 (/second): a kinetic parameter\n"
  "	kf_R31 = 24.9977 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R31 = 0.0167996 (/second): a kinetic parameter\n"
  "	kf_R32 = 1000 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R32 = 1 (/second): a kinetic parameter\n"
  "	kf_R33 = 180011 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R33 = 10 (/second): a kinetic parameter\n"
  "	kf_R34 = 12000.5 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R34 = 10 (/second): a kinetic parameter\n"
  "	kf_R35 = 0.0500035 (/second): a kinetic parameter\n"
  "	kf_R36 = 0.0700003 (/second): a kinetic parameter\n"
  "	kf_R37 = 949.73 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R37 = 15.9993 (/second): a kinetic parameter\n"
  "	kf_R38 = 4 (/second): a kinetic parameter\n"
  "	kf_R39 = 5657.18 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R39 = 15.9993 (/second): a kinetic parameter\n"
  "	kf_R40 = 4 (/second): a kinetic parameter\n"
  "	kf_R41 = 5657.18 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R41 = 15.9993 (/second): a kinetic parameter\n"
  "	kf_R42 = 4 (/second): a kinetic parameter\n"
  "	kf_R43 = 1272.62 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R43 = 21.6023 (/second): a kinetic parameter\n"
  "	kf_R44 = 5.39995 (/second): a kinetic parameter\n"
  "	kf_R45 = 2601.96 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R45 = 44.157 (/second): a kinetic parameter\n"
  "	kf_R46 = 11.0408 (/second): a kinetic parameter\n"
  "	kf_R47 = 8483.99 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R47 = 144.012 (/second): a kinetic parameter\n"
  "	kf_R48 = 35.9998 (/second): a kinetic parameter\n"
  "	kf_R49 = 14141.6 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R49 = 239.994 (/second): a kinetic parameter\n"
  "	kf_R50 = 60.0067 (/second): a kinetic parameter\n"
  "	kf_R51 = 28281.3 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R51 = 479.954 (/second): a kinetic parameter\n"
  "	kf_R52 = 120.005 (/second): a kinetic parameter\n"
  "	kf_R53 = 2375.75 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R53 = 40.0037 (/second): a kinetic parameter\n"
  "	kf_R54 = 10 (/second): a kinetic parameter\n"
  "	kf_R55 = 45248.1 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R55 = 191.999 (/second): a kinetic parameter\n"
  "	kf_R56 = 47.9954 (/second): a kinetic parameter\n"
  "	kf_R57 = 3677.05 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R57 = 80.0018 (/second): a kinetic parameter\n"
  "	kf_R58 = 19.9986 (/second): a kinetic parameter\n"
  "	kf_R59 = 1838.23 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R59 = 40.0037 (/second): a kinetic parameter\n"
  "	kf_R60 = 10 (/second): a kinetic parameter\n"
  "	kf_R61 = 18382.3 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R61 = 40.0037 (/second): a kinetic parameter\n"
  "	kf_R62 = 10 (/second): a kinetic parameter\n"
  "	kf_R63 = 15272.1 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R63 = 0.599998 (/second): a kinetic parameter\n"
  "	kf_R64 = 0.15 (/second): a kinetic parameter\n"
  "	kf_R65 = 15272.1 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R65 = 0.599998 (/second): a kinetic parameter\n"
  "	kf_R66 = 0.15 (/second): a kinetic parameter\n"
  "	kf_R67 = 8887.92 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R67 = 1.2 (/second): a kinetic parameter\n"
  "	kf_R68 = 0.299999 (/second): a kinetic parameter\n"
  "	kf_R69 = 8887.92 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R69 = 1.2 (/second): a kinetic parameter\n"
  "	kf_R70 = 0.299999 (/second): a kinetic parameter\n"
  "	kf_R71 = 9.47196 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R71 = 0.0800018 (/second): a kinetic parameter\n"
  "	kf_R72 = 0.0199986 (/second): a kinetic parameter\n"
  "	kf_R73 = 186.681 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R73 = 0.0800018 (/second): a kinetic parameter\n"
  "	kf_R74 = 0.0199986 (/second): a kinetic parameter\n"
  "	kf_R75 = 46655.2 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R75 = 40.0037 (/second): a kinetic parameter\n"
  "	kf_R76 = 10 (/second): a kinetic parameter\n"
  "	kf_R77 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R77 = 0.8 (/second): a kinetic parameter\n"
  "	kf_R78 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R79 = 2828.13 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R79 = 0.8 (/second): a kinetic parameter\n"
  "	kf_R80 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R81 = 1131.36 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R81 = 0.8 (/second): a kinetic parameter\n"
  "	kf_R82 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R83 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R83 = 0.8 (/second): a kinetic parameter\n"
  "	kf_R84 = 0.2 (/second): a kinetic parameter\n"
  "	kf_R85 = 0.0972299 (/second): a kinetic parameter\n"
  "	kr_R85 = 13.9991 (millimole/liter): a kinetic parameter\n"
  "	kf_R86 = 0.0197925 (/second): a kinetic parameter\n"
  "	kr_R86 = 57.0033 (millimole/liter): a kinetic parameter\n"
  "	kf_R87 = 7972.6 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R87 = 2 (/second): a kinetic parameter\n"
  "	kf_R88 = 0.5 (/second): a kinetic parameter\n"
  "	kf_R89 = 2714.56 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R89 = 15.9993 (/second): a kinetic parameter\n"
  "	kf_R90 = 4 (/second): a kinetic parameter\n"
  "	kf_R91 = 2714.56 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R91 = 15.9993 (/second): a kinetic parameter\n"
  "	kf_R92 = 4 (/second): a kinetic parameter\n"
  "	kf_R93 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R93 = 24.9977 (/second): a kinetic parameter\n"
  "	kf_R94 = 5.99998 (/second): a kinetic parameter\n"
  "	kf_R95 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R95 = 24.9977 (/second): a kinetic parameter\n"
  "	kf_R96 = 5.99998 (/second): a kinetic parameter\n"
  "	kf_R97 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R97 = 24.9977 (/second): a kinetic parameter\n"
  "	kf_R98 = 5.99998 (/second): a kinetic parameter\n"
  "	kf_R99 = 1866.81 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R99 = 24.9977 (/second): a kinetic parameter\n"
  "	kf_R100 = 5.99998 (/second): a kinetic parameter\n"
  "	kf_R101 = 1806.34 (liter/millimole-second): a kinetic parameter\n"
  "	kr_R101 = 23.9994 (/second): a kinetic parameter\n"
  "	kf_R102 = 5.99998 (/second): a kinetic parameter\n"
  "	PPhosphatase2A_ConservedConst = 0.00026001 : the total amount of a conserved sub-set of states\n"
  "	MKP_1_ConservedConst = 2e-05 : the total amount of a conserved sub-set of states\n"
  "	PLCg_basal_ConservedConst = 7.0002e-07 : the total amount of a conserved sub-set of states\n"
  "	PLC_g_ConservedConst = 0.00082001 : the total amount of a conserved sub-set of states\n"
  "	Grb2_ConservedConst = 0.0009 : the total amount of a conserved sub-set of states\n"
  "	SHC_ConservedConst = 0.00040001 : the total amount of a conserved sub-set of states\n"
  "	Sos_ConservedConst = 0.0001 : the total amount of a conserved sub-set of states\n"
  "	EGFR_ConservedConst = 0.00016666 : the total amount of a conserved sub-set of states\n"
  "	CaM_GEF_ConservedConst = 0 : the total amount of a conserved sub-set of states\n"
  "	GAP_ConservedConst = 2e-05 : the total amount of a conserved sub-set of states\n"
  "	inact_GEF_ConservedConst = 0.0001 : the total amount of a conserved sub-set of states\n"
  "	GDP_Ras_ConservedConst = 0.0005 : the total amount of a conserved sub-set of states\n"
  "	MAPKK_ConservedConst = 0.00018001 : the total amount of a conserved sub-set of states\n"
  "	craf_1_ConservedConst = -0.0003 : the total amount of a conserved sub-set of states\n"
  "	MAPK_ConservedConst = 0.00036 : the total amount of a conserved sub-set of states\n"
  "	PLC_Ca_Gq_ConservedConst = 0 : the total amount of a conserved sub-set of states\n"
  "	PLC_ConservedConst = 0.0008 : the total amount of a conserved sub-set of states\n"
  "	PIP2_Ca_PLA2_p_ConservedConst = 0 : the total amount of a conserved sub-set of states\n"
  "	PIP2_PLA2_p_ConservedConst = 0 : the total amount of a conserved sub-set of states\n"
  "	PLA2_cytosolic_ConservedConst = 0.0004 : the total amount of a conserved sub-set of states\n"
  "	PKC_cytosolic_ConservedConst = 0.00102 : the total amount of a conserved sub-set of states\n"
  "}\n"
  "ASSIGNED {\n"
  "	time (millisecond) : alias for t\n"
  "	PKC_active : a pre-defined algebraic expression\n"
  "	PKC_active1 : a pre-defined algebraic expression\n"
  "	APC : a pre-defined algebraic expression\n"
  "	Inositol : a pre-defined algebraic expression\n"
  "	PC : a pre-defined algebraic expression\n"
  "	PIP2 : a pre-defined algebraic expression\n"
  "	EGF : a pre-defined algebraic expression\n"
  "	Ca : a pre-defined algebraic expression\n"
  "	ReactionFlux0 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux1 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux2 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux3 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux4 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux5 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux6 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux7 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux8 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux9 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux10 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux11 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux12 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux13 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux14 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux15 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux16 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux17 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux18 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux19 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux20 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux21 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux22 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux23 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux24 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux25 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux26 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux27 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux28 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux29 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux30 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux31 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux32 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux33 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux34 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux35 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux36 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux37 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux38 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux39 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux40 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux41 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux42 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux43 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux44 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux45 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux46 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux47 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux48 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux49 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux50 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux51 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux52 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux53 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux54 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux55 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux56 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux57 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux58 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux59 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux60 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux61 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux62 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux63 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux64 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux65 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux66 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux67 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux68 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux69 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux70 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux71 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux72 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux73 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux74 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux75 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux76 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux77 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux78 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux79 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux80 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux81 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux82 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux83 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux84 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux85 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux86 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux87 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux88 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux89 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux90 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux91 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux92 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux93 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux94 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux95 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux96 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux97 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux98 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux99 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux100 : a flux, for use in DERIVATIVE mechanism\n"
  "	ReactionFlux101 : a flux, for use in DERIVATIVE mechanism\n"
  "	PPhosphatase2A : computed from conservation law\n"
  "	MKP_1 : computed from conservation law\n"
  "	PLCg_basal : computed from conservation law\n"
  "	PLC_g : computed from conservation law\n"
  "	Grb2 : computed from conservation law\n"
  "	SHC : computed from conservation law\n"
  "	Sos : computed from conservation law\n"
  "	EGFR : computed from conservation law\n"
  "	CaM_GEF : computed from conservation law\n"
  "	GAP : computed from conservation law\n"
  "	inact_GEF : computed from conservation law\n"
  "	GDP_Ras : computed from conservation law\n"
  "	MAPKK : computed from conservation law\n"
  "	craf_1 : computed from conservation law\n"
  "	MAPK : computed from conservation law\n"
  "	PLC_Ca_Gq : computed from conservation law\n"
  "	PLC : computed from conservation law\n"
  "	PIP2_Ca_PLA2_p : computed from conservation law\n"
  "	PIP2_PLA2_p : computed from conservation law\n"
  "	PLA2_cytosolic : computed from conservation law\n"
  "	PKC_cytosolic : computed from conservation law\n"
  "	pERK1_2_ratio1 : an observable\n"
  "	MAPK_out : an observable\n"
  "	MAPK_p_out : an observable\n"
  "	MAPK_p_p_out : an observable\n"
  "	MAPK_p_p_cplx_out : an observable\n"
  "	MAPK_p_p_feedback_cplx_out : an observable\n"
  "	pERK1_2_ratio2 : an observable\n"
  "}\n"
  "PROCEDURE assign_calculated_values() {\n"
  "	time = t : an alias for the time variable, if needed.\n"
  "	PPhosphatase2A = PPhosphatase2A_ConservedConst - (craf_dephospho_cplx+MAPKK_dephospho_cplx+MAPKK_dephospho_ser_cplx+craf_p_p_dephospho_cplx+deph_raf_ser259_cplx) : conservation law\n"
  "	MKP_1 = MKP_1_ConservedConst - (MKP1_tyr_deph_cplx+MKP1_thr_deph_cplx) : conservation law\n"
  "	PLCg_basal = PLCg_basal_ConservedConst - (PLC_g_phospho_cplx) : conservation law\n"
  "	PLC_g = PLC_g_ConservedConst - (PLC_g_p+Ca_PLC_g+Ca_PLC_g_p+Ca_PLC_g_phospho_cplx+PLC_g_phospho_cplx) : conservation law\n"
  "	Grb2 = Grb2_ConservedConst - (SHC_p_Grb2_clx-Sos_p-Sos-phosph_Sos_cplx) : conservation law\n"
  "	SHC = SHC_ConservedConst - (SHC_p+SHC_p_Grb2_clx+SHC_phospho_cplx-Sos_p_Grb2-Sos_Grb2-Sos_p-Sos-phosph_Sos_cplx) : conservation law\n"
  "	Sos = Sos_ConservedConst - (SHC_p_Sos_Grb2+Sos_p_Grb2+Sos_Grb2+Sos_p+phosph_Sos_cplx+Sos_Ras_GEF_cplx) : conservation law\n"
  "	EGFR = EGFR_ConservedConst - (L_EGFR+Internal_L_EGFR+Ca_PLC_g_phospho_cplx+SHC_phospho_cplx) : conservation law\n"
  "	CaM_GEF = CaM_GEF_ConservedConst - (CaM_GEF_act_Ras_cplx) : conservation law\n"
  "	GAP = GAP_ConservedConst - (GAP_p+PKC_inact_GAP_cplx+GAP_inact_Ras_cplx) : conservation law\n"
  "	inact_GEF = inact_GEF_ConservedConst - (GEF_p+inact_GEF_p+PKC_act_GEF_cplx+basal_GEF_activity_cplx+GEF_p_act_Ras_cplx) : conservation law\n"
  "	GDP_Ras = GDP_Ras_ConservedConst - (Raf_p_GTP_Ras+GTP_Ras+Raf_p_GTP_Ras_1_cplx+Raf_p_GTP_Ras_2_cplx+basal_GEF_activity_cplx+GEF_p_act_Ras_cplx+GAP_inact_Ras_cplx+CaM_GEF_act_Ras_cplx+Sos_Ras_GEF_cplx) : conservation law\n"
  "	MAPKK = MAPKK_ConservedConst - (MAPKK_p_p+MAPKK_p+MAPKKtyr_cplx+MAPKKthr_cplx+Raf_p_GTP_Ras_1_cplx+Raf_p_GTP_Ras_2_cplx+MAPKK_dephospho_cplx+MAPKK_dephospho_ser_cplx) : conservation law\n"
  "	craf_1 = craf_1_ConservedConst - (craf_1_p+craf_1_p_p+craf_1_p_ser259+PKC_act_raf_cplx+MAPK_p_p_feedback_cplx+craf_dephospho_cplx+craf_p_p_dephospho_cplx+deph_raf_ser259_cplx-GTP_Ras-GDP_Ras-basal_GEF_activity_cplx-GEF_p_act_Ras_cplx-GAP_inact_Ras_cplx-CaM_GEF_act_Ras_cplx-Sos_Ras_GEF_cplx) : conservation law\n"
  "	MAPK = MAPK_ConservedConst - (MAPK_p_p+MAPK_p+MAPK_p_p_cplx+MAPK_p_p_feedback_cplx+phosph_Sos_cplx+MAPKKtyr_cplx+MAPKKthr_cplx+MKP1_tyr_deph_cplx+MKP1_thr_deph_cplx) : conservation law\n"
  "	PLC_Ca_Gq = PLC_Ca_Gq_ConservedConst - (PLC_Gq+PLCb_Ca_Gq_cplx) : conservation law\n"
  "	PLC = PLC_ConservedConst - (PLC_Ca+PLC_Ca_cplx) : conservation law\n"
  "	PIP2_Ca_PLA2_p = PIP2_Ca_PLA2_p_ConservedConst - (kenz_cplx_2) : conservation law\n"
  "	PIP2_PLA2_p = PIP2_PLA2_p_ConservedConst - (kenz_cplx_1) : conservation law\n"
  "	PLA2_cytosolic = PLA2_cytosolic_ConservedConst - (PLA2_Ca_p+DAG_Ca_PLA2_p+PLA2_p_Ca+PLA2_p+kenz_cplx+kenz_cplx_3+kenz_cplx_4+MAPK_p_p_cplx) : conservation law\n"
  "	PKC_cytosolic = PKC_cytosolic_ConservedConst - (PKC_Ca+PKC_DAG_AA_p+PKC_Ca_AA_p+PKC_Ca_memb_p+PKC_DAG_memb_p+PKC_basal_p+PKC_AA_p+PKC_Ca_DAG+PKC_DAG+PKC_DAG_AA) : conservation law\n"
  "	PKC_active = PKC_DAG_AA_p+PKC_Ca_memb_p+PKC_Ca_AA_p+PKC_DAG_memb_p+PKC_basal_p+PKC_AA_p : assignment for expression Ex0\n"
  "	PKC_active1 = 0 : assignment for expression S11\n"
  "	APC = 0.030001 : assignment for expression S17\n"
  "	Inositol = 0 : assignment for expression S22\n"
  "	PC = 0 : assignment for expression S26\n"
  "	PIP2 = 0.007 : assignment for expression S29\n"
  "	EGF = 0 : assignment for expression S51\n"
  "	Ca = 8e-05 : assignment for expression S69\n"
  "	ReactionFlux0 = kf_R1 * Ca * PKC_cytosolic-kr_R1 * PKC_Ca : flux expression R0\n"
  "	ReactionFlux1 = kf_R2 * DAG * PKC_Ca-kr_R2 * PKC_Ca_DAG : flux expression R1\n"
  "	ReactionFlux2 = kf_R3 * PKC_Ca-kr_R3 * PKC_Ca_memb_p : flux expression R2\n"
  "	ReactionFlux3 = kf_R4 * PKC_Ca_DAG-kr_R4 * PKC_DAG_memb_p : flux expression R3\n"
  "	ReactionFlux4 = kf_R5 * Arachidonic_Acid * PKC_Ca-kr_R5 * PKC_Ca_AA_p : flux expression R4\n"
  "	ReactionFlux5 = kf_R6 * PKC_DAG_AA-kr_R6 * PKC_DAG_AA_p : flux expression R5\n"
  "	ReactionFlux6 = kf_R7 * PKC_cytosolic-kr_R7 * PKC_basal_p : flux expression R6\n"
  "	ReactionFlux7 = kf_R8 * PKC_cytosolic * Arachidonic_Acid-kr_R8 * PKC_AA_p : flux expression R7\n"
  "	ReactionFlux8 = kf_R9 * PKC_cytosolic * DAG-kr_R9 * PKC_DAG : flux expression R8\n"
  "	ReactionFlux9 = kf_R10 * Arachidonic_Acid * PKC_DAG-kr_R10 * PKC_DAG_AA : flux expression R9\n"
  "	ReactionFlux10 = kf_R11 * Ca * PLA2_cytosolic-kr_R11 * PLA2_Ca_p : flux expression R10\n"
  "	ReactionFlux11 = kf_R12 * PLA2_Ca_p * DAG-kr_R12 * DAG_Ca_PLA2_p : flux expression R11\n"
  "	ReactionFlux12 = kf_R13 * Arachidonic_Acid : flux expression R12\n"
  "	ReactionFlux13 = kf_R14 * Ca * PLA2_p-kr_R14 * PLA2_p_Ca : flux expression R13\n"
  "	ReactionFlux14 = kf_R15 * PLA2_p : flux expression R14\n"
  "	ReactionFlux15 = kf_R16 * PLC * Ca-kr_R16 * PLC_Ca : flux expression R15\n"
  "	ReactionFlux16 = kf_R17 * IP3 : flux expression R16\n"
  "	ReactionFlux17 = kf_R18 * DAG : flux expression R17\n"
  "	ReactionFlux18 = kf_R19 * PLC_Gq * Ca-kr_R19 * PLC_Ca_Gq : flux expression R18\n"
  "	ReactionFlux19 = kf_R20 * GTP_Ras * craf_1_p-kr_R20 * Raf_p_GTP_Ras : flux expression R19\n"
  "	ReactionFlux20 = kf_R21 * GEF_p : flux expression R20\n"
  "	ReactionFlux21 = kf_R22 * GTP_Ras : flux expression R21\n"
  "	ReactionFlux22 = kf_R23 * GAP_p : flux expression R22\n"
  "	ReactionFlux23 = kf_R24 * inact_GEF_p : flux expression R23\n"
  "	ReactionFlux24 = kf_R25 * EGFR * EGF-kr_R25 * L_EGFR : flux expression R24\n"
  "	ReactionFlux25 = kf_R26 * L_EGFR-kr_R26 * Internal_L_EGFR : flux expression R25\n"
  "	ReactionFlux26 = kf_R27 * SHC_p : flux expression R26\n"
  "	ReactionFlux27 = kf_R28 * Sos_Grb2 * SHC_p-kr_R28 * SHC_p_Sos_Grb2 : flux expression R27\n"
  "	ReactionFlux28 = kf_R29 * Grb2 * Sos_p-kr_R29 * Sos_p_Grb2 : flux expression R28\n"
  "	ReactionFlux29 = kf_R30 * Sos_p : flux expression R29\n"
  "	ReactionFlux30 = kf_R31 * Grb2 * Sos-kr_R31 * Sos_Grb2 : flux expression R30\n"
  "	ReactionFlux31 = kf_R32 * Grb2 * SHC_p-kr_R32 * SHC_p_Grb2_clx : flux expression R31\n"
  "	ReactionFlux32 = kf_R33 * Ca * PLC_g-kr_R33 * Ca_PLC_g : flux expression R32\n"
  "	ReactionFlux33 = kf_R34 * Ca * PLC_g_p-kr_R34 * Ca_PLC_g_p : flux expression R33\n"
  "	ReactionFlux34 = kf_R35 * Ca_PLC_g_p : flux expression R34\n"
  "	ReactionFlux35 = kf_R36 * PLC_g_p : flux expression R35\n"
  "	ReactionFlux36 = kf_R37 * craf_1 * PKC_active-kr_R37 * PKC_act_raf_cplx : flux expression R36\n"
  "	ReactionFlux37 = kf_R38 * PKC_act_raf_cplx : flux expression R37\n"
  "	ReactionFlux38 = kf_R39 * GAP * PKC_active-kr_R39 * PKC_inact_GAP_cplx : flux expression R38\n"
  "	ReactionFlux39 = kf_R40 * PKC_inact_GAP_cplx : flux expression R39\n"
  "	ReactionFlux40 = kf_R41 * inact_GEF * PKC_active-kr_R41 * PKC_act_GEF_cplx : flux expression R40\n"
  "	ReactionFlux41 = kf_R42 * PKC_act_GEF_cplx : flux expression R41\n"
  "	ReactionFlux42 = kf_R43 * PLA2_Ca_p * APC-kr_R43 * kenz_cplx : flux expression R42\n"
  "	ReactionFlux43 = kf_R44 * kenz_cplx : flux expression R43\n"
  "	ReactionFlux44 = kf_R45 * APC * PIP2_PLA2_p-kr_R45 * kenz_cplx_1 : flux expression R44\n"
  "	ReactionFlux45 = kf_R46 * kenz_cplx_1 : flux expression R45\n"
  "	ReactionFlux46 = kf_R47 * APC * PIP2_Ca_PLA2_p-kr_R47 * kenz_cplx_2 : flux expression R46\n"
  "	ReactionFlux47 = kf_R48 * kenz_cplx_2 : flux expression R47\n"
  "	ReactionFlux48 = kf_R49 * APC * DAG_Ca_PLA2_p-kr_R49 * kenz_cplx_3 : flux expression R48\n"
  "	ReactionFlux49 = kf_R50 * kenz_cplx_3 : flux expression R49\n"
  "	ReactionFlux50 = kf_R51 * APC * PLA2_p_Ca-kr_R51 * kenz_cplx_4 : flux expression R50\n"
  "	ReactionFlux51 = kf_R52 * kenz_cplx_4 : flux expression R51\n"
  "	ReactionFlux52 = kf_R53 * PIP2 * PLC_Ca-kr_R53 * PLC_Ca_cplx : flux expression R52\n"
  "	ReactionFlux53 = kf_R54 * PLC_Ca_cplx : flux expression R53\n"
  "	ReactionFlux54 = kf_R55 * PIP2 * PLC_Ca_Gq-kr_R55 * PLCb_Ca_Gq_cplx : flux expression R54\n"
  "	ReactionFlux55 = kf_R56 * PLCb_Ca_Gq_cplx : flux expression R55\n"
  "	ReactionFlux56 = kf_R57 * MAPK_p_p * PLA2_cytosolic-kr_R57 * MAPK_p_p_cplx : flux expression R56\n"
  "	ReactionFlux57 = kf_R58 * MAPK_p_p_cplx : flux expression R57\n"
  "	ReactionFlux58 = kf_R59 * MAPK_p_p * craf_1_p-kr_R59 * MAPK_p_p_feedback_cplx : flux expression R58\n"
  "	ReactionFlux59 = kf_R60 * MAPK_p_p_feedback_cplx : flux expression R59\n"
  "	ReactionFlux60 = kf_R61 * MAPK_p_p * Sos-kr_R61 * phosph_Sos_cplx : flux expression R60\n"
  "	ReactionFlux61 = kf_R62 * phosph_Sos_cplx : flux expression R61\n"
  "	ReactionFlux62 = kf_R63 * MAPKK_p_p * MAPK-kr_R63 * MAPKKtyr_cplx : flux expression R62\n"
  "	ReactionFlux63 = kf_R64 * MAPKKtyr_cplx : flux expression R63\n"
  "	ReactionFlux64 = kf_R65 * MAPKK_p_p * MAPK_p-kr_R65 * MAPKKthr_cplx : flux expression R64\n"
  "	ReactionFlux65 = kf_R66 * MAPKKthr_cplx : flux expression R65\n"
  "	ReactionFlux66 = kf_R67 * MAPKK * Raf_p_GTP_Ras-kr_R67 * Raf_p_GTP_Ras_1_cplx : flux expression R66\n"
  "	ReactionFlux67 = kf_R68 * Raf_p_GTP_Ras_1_cplx : flux expression R67\n"
  "	ReactionFlux68 = kf_R69 * MAPKK_p * Raf_p_GTP_Ras-kr_R69 * Raf_p_GTP_Ras_2_cplx : flux expression R68\n"
  "	ReactionFlux69 = kf_R70 * Raf_p_GTP_Ras_2_cplx : flux expression R69\n"
  "	ReactionFlux70 = kf_R71 * inact_GEF * GDP_Ras-kr_R71 * basal_GEF_activity_cplx : flux expression R70\n"
  "	ReactionFlux71 = kf_R72 * basal_GEF_activity_cplx : flux expression R71\n"
  "	ReactionFlux72 = kf_R73 * GEF_p * GDP_Ras-kr_R73 * GEF_p_act_Ras_cplx : flux expression R72\n"
  "	ReactionFlux73 = kf_R74 * GEF_p_act_Ras_cplx : flux expression R73\n"
  "	ReactionFlux74 = kf_R75 * GAP * GTP_Ras-kr_R75 * GAP_inact_Ras_cplx : flux expression R74\n"
  "	ReactionFlux75 = kf_R76 * GAP_inact_Ras_cplx : flux expression R75\n"
  "	ReactionFlux76 = kf_R77 * GDP_Ras * CaM_GEF-kr_R77 * CaM_GEF_act_Ras_cplx : flux expression R76\n"
  "	ReactionFlux77 = kf_R78 * CaM_GEF_act_Ras_cplx : flux expression R77\n"
  "	ReactionFlux78 = kf_R79 * L_EGFR * Ca_PLC_g-kr_R79 * Ca_PLC_g_phospho_cplx : flux expression R78\n"
  "	ReactionFlux79 = kf_R80 * Ca_PLC_g_phospho_cplx : flux expression R79\n"
  "	ReactionFlux80 = kf_R81 * L_EGFR * SHC-kr_R81 * SHC_phospho_cplx : flux expression R80\n"
  "	ReactionFlux81 = kf_R82 * SHC_phospho_cplx : flux expression R81\n"
  "	ReactionFlux82 = kf_R83 * SHC_p_Sos_Grb2 * GDP_Ras-kr_R83 * Sos_Ras_GEF_cplx : flux expression R82\n"
  "	ReactionFlux83 = kf_R84 * Sos_Ras_GEF_cplx : flux expression R83\n"
  "	ReactionFlux84 = (kf_R85*PIP2*Ca_PLC_g/(kr_R85+PIP2)) : flux expression R84\n"
  "	ReactionFlux85 = (kf_R86*PIP2*Ca_PLC_g_p/(kr_R86+PIP2)) : flux expression R85\n"
  "	ReactionFlux86 = kf_R87 * PLCg_basal * PLC_g-kr_R87 * PLC_g_phospho_cplx : flux expression R86\n"
  "	ReactionFlux87 = kf_R88 * PLC_g_phospho_cplx : flux expression R87\n"
  "	ReactionFlux88 = kf_R89 * MKP_1 * MAPK_p-kr_R89 * MKP1_tyr_deph_cplx : flux expression R88\n"
  "	ReactionFlux89 = kf_R90 * MKP1_tyr_deph_cplx : flux expression R89\n"
  "	ReactionFlux90 = kf_R91 * MAPK_p_p * MKP_1-kr_R91 * MKP1_thr_deph_cplx : flux expression R90\n"
  "	ReactionFlux91 = kf_R92 * MKP1_thr_deph_cplx : flux expression R91\n"
  "	ReactionFlux92 = kf_R93 * craf_1_p * PPhosphatase2A-kr_R93 * craf_dephospho_cplx : flux expression R92\n"
  "	ReactionFlux93 = kf_R94 * craf_dephospho_cplx : flux expression R93\n"
  "	ReactionFlux94 = kf_R95 * MAPKK_p_p * PPhosphatase2A-kr_R95 * MAPKK_dephospho_cplx : flux expression R94\n"
  "	ReactionFlux95 = kf_R96 * MAPKK_dephospho_cplx : flux expression R95\n"
  "	ReactionFlux96 = kf_R97 * MAPKK_p * PPhosphatase2A-kr_R97 * MAPKK_dephospho_ser_cplx : flux expression R96\n"
  "	ReactionFlux97 = kf_R98 * MAPKK_dephospho_ser_cplx : flux expression R97\n"
  "	ReactionFlux98 = kf_R99 * craf_1_p_p * PPhosphatase2A-kr_R99 * craf_p_p_dephospho_cplx : flux expression R98\n"
  "	ReactionFlux99 = kf_R100 * craf_p_p_dephospho_cplx : flux expression R99\n"
  "	ReactionFlux100 = kf_R101 * craf_1_p_ser259 * PPhosphatase2A-kr_R101 * deph_raf_ser259_cplx : flux expression R100\n"
  "	ReactionFlux101 = kf_R102 * deph_raf_ser259_cplx : flux expression R101\n"
  "}\n"
  "STATE {\n"
  "	PKC_Ca (millimole/litre) : a state variable\n"
  "	PKC_DAG_AA_p (millimole/litre) : a state variable\n"
  "	PKC_Ca_AA_p (millimole/litre) : a state variable\n"
  "	PKC_Ca_memb_p (millimole/litre) : a state variable\n"
  "	PKC_DAG_memb_p (millimole/litre) : a state variable\n"
  "	PKC_basal_p (millimole/litre) : a state variable\n"
  "	PKC_AA_p (millimole/litre) : a state variable\n"
  "	PKC_Ca_DAG (millimole/litre) : a state variable\n"
  "	PKC_DAG (millimole/litre) : a state variable\n"
  "	PKC_DAG_AA (millimole/litre) : a state variable\n"
  "	: PKC_cytosolic is calculated via Conservation Law\n"
  "	: PLA2_cytosolic is calculated via Conservation Law\n"
  "	PLA2_Ca_p (millimole/litre) : a state variable\n"
  "	: PIP2_PLA2_p is calculated via Conservation Law\n"
  "	: PIP2_Ca_PLA2_p is calculated via Conservation Law\n"
  "	DAG_Ca_PLA2_p (millimole/litre) : a state variable\n"
  "	PLA2_p_Ca (millimole/litre) : a state variable\n"
  "	PLA2_p (millimole/litre) : a state variable\n"
  "	Arachidonic_Acid (millimole/litre) : a state variable\n"
  "	: PLC is calculated via Conservation Law\n"
  "	PLC_Ca (millimole/litre) : a state variable\n"
  "	: PLC_Ca_Gq is calculated via Conservation Law\n"
  "	PLC_Gq (millimole/litre) : a state variable\n"
  "	DAG (millimole/litre) : a state variable\n"
  "	IP3 (millimole/litre) : a state variable\n"
  "	MAPK_p_p (millimole/litre) : a state variable\n"
  "	: craf_1 is calculated via Conservation Law\n"
  "	craf_1_p (millimole/litre) : a state variable\n"
  "	: MAPKK is calculated via Conservation Law\n"
  "	: MAPK is calculated via Conservation Law\n"
  "	craf_1_p_p (millimole/litre) : a state variable\n"
  "	MAPK_p (millimole/litre) : a state variable\n"
  "	MAPKK_p_p (millimole/litre) : a state variable\n"
  "	MAPKK_p (millimole/litre) : a state variable\n"
  "	Raf_p_GTP_Ras (millimole/litre) : a state variable\n"
  "	craf_1_p_ser259 (millimole/litre) : a state variable\n"
  "	: inact_GEF is calculated via Conservation Law\n"
  "	GEF_p (millimole/litre) : a state variable\n"
  "	GTP_Ras (millimole/litre) : a state variable\n"
  "	: GDP_Ras is calculated via Conservation Law\n"
  "	GAP_p (millimole/litre) : a state variable\n"
  "	: GAP is calculated via Conservation Law\n"
  "	inact_GEF_p (millimole/litre) : a state variable\n"
  "	: CaM_GEF is calculated via Conservation Law\n"
  "	: EGFR is calculated via Conservation Law\n"
  "	L_EGFR (millimole/litre) : a state variable\n"
  "	Internal_L_EGFR (millimole/litre) : a state variable\n"
  "	SHC_p_Sos_Grb2 (millimole/litre) : a state variable\n"
  "	: SHC is calculated via Conservation Law\n"
  "	SHC_p (millimole/litre) : a state variable\n"
  "	Sos_p_Grb2 (millimole/litre) : a state variable\n"
  "	: Grb2 is calculated via Conservation Law\n"
  "	Sos_Grb2 (millimole/litre) : a state variable\n"
  "	Sos_p (millimole/litre) : a state variable\n"
  "	: Sos is calculated via Conservation Law\n"
  "	SHC_p_Grb2_clx (millimole/litre) : a state variable\n"
  "	: PLC_g is calculated via Conservation Law\n"
  "	PLC_g_p (millimole/litre) : a state variable\n"
  "	Ca_PLC_g (millimole/litre) : a state variable\n"
  "	Ca_PLC_g_p (millimole/litre) : a state variable\n"
  "	: PLCg_basal is calculated via Conservation Law\n"
  "	: MKP_1 is calculated via Conservation Law\n"
  "	: PPhosphatase2A is calculated via Conservation Law\n"
  "	PKC_act_raf_cplx (millimole/litre) : a state variable\n"
  "	PKC_inact_GAP_cplx (millimole/litre) : a state variable\n"
  "	PKC_act_GEF_cplx (millimole/litre) : a state variable\n"
  "	kenz_cplx (millimole/litre) : a state variable\n"
  "	kenz_cplx_1 (millimole/litre) : a state variable\n"
  "	kenz_cplx_2 (millimole/litre) : a state variable\n"
  "	kenz_cplx_3 (millimole/litre) : a state variable\n"
  "	kenz_cplx_4 (millimole/litre) : a state variable\n"
  "	PLC_Ca_cplx (millimole/litre) : a state variable\n"
  "	PLCb_Ca_Gq_cplx (millimole/litre) : a state variable\n"
  "	MAPK_p_p_cplx (millimole/litre) : a state variable\n"
  "	MAPK_p_p_feedback_cplx (millimole/litre) : a state variable\n"
  "	phosph_Sos_cplx (millimole/litre) : a state variable\n"
  "	MAPKKtyr_cplx (millimole/litre) : a state variable\n"
  "	MAPKKthr_cplx (millimole/litre) : a state variable\n"
  "	Raf_p_GTP_Ras_1_cplx (millimole/litre) : a state variable\n"
  "	Raf_p_GTP_Ras_2_cplx (millimole/litre) : a state variable\n"
  "	basal_GEF_activity_cplx (millimole/litre) : a state variable\n"
  "	GEF_p_act_Ras_cplx (millimole/litre) : a state variable\n"
  "	GAP_inact_Ras_cplx (millimole/litre) : a state variable\n"
  "	CaM_GEF_act_Ras_cplx (millimole/litre) : a state variable\n"
  "	Ca_PLC_g_phospho_cplx (millimole/litre) : a state variable\n"
  "	SHC_phospho_cplx (millimole/litre) : a state variable\n"
  "	Sos_Ras_GEF_cplx (millimole/litre) : a state variable\n"
  "	PLC_g_phospho_cplx (millimole/litre) : a state variable\n"
  "	MKP1_tyr_deph_cplx (millimole/litre) : a state variable\n"
  "	MKP1_thr_deph_cplx (millimole/litre) : a state variable\n"
  "	craf_dephospho_cplx (millimole/litre) : a state variable\n"
  "	MAPKK_dephospho_cplx (millimole/litre) : a state variable\n"
  "	MAPKK_dephospho_ser_cplx (millimole/litre) : a state variable\n"
  "	craf_p_p_dephospho_cplx (millimole/litre) : a state variable\n"
  "	deph_raf_ser259_cplx (millimole/litre) : a state variable\n"
  "}\n"
  "INITIAL {\n"
  "	 PKC_Ca = 0 : initial condition\n"
  "	 PKC_DAG_AA_p = 0 : initial condition\n"
  "	 PKC_Ca_AA_p = 0 : initial condition\n"
  "	 PKC_Ca_memb_p = 0 : initial condition\n"
  "	 PKC_DAG_memb_p = 0 : initial condition\n"
  "	 PKC_basal_p = 2e-05 : initial condition\n"
  "	 PKC_AA_p = 0 : initial condition\n"
  "	 PKC_Ca_DAG = 0 : initial condition\n"
  "	 PKC_DAG = 0 : initial condition\n"
  "	 PKC_DAG_AA = 0 : initial condition\n"
  "	: PKC_cytosolic cannot have initial values as it is determined by conservation law\n"
  "	: PLA2_cytosolic cannot have initial values as it is determined by conservation law\n"
  "	 PLA2_Ca_p = 0 : initial condition\n"
  "	: PIP2_PLA2_p cannot have initial values as it is determined by conservation law\n"
  "	: PIP2_Ca_PLA2_p cannot have initial values as it is determined by conservation law\n"
  "	 DAG_Ca_PLA2_p = 0 : initial condition\n"
  "	 PLA2_p_Ca = 0 : initial condition\n"
  "	 PLA2_p = 0 : initial condition\n"
  "	 Arachidonic_Acid = 0 : initial condition\n"
  "	: PLC cannot have initial values as it is determined by conservation law\n"
  "	 PLC_Ca = 0 : initial condition\n"
  "	: PLC_Ca_Gq cannot have initial values as it is determined by conservation law\n"
  "	 PLC_Gq = 0 : initial condition\n"
  "	 DAG = 0 : initial condition\n"
  "	 IP3 = 0.00073 : initial condition\n"
  "	 MAPK_p_p = 0 : initial condition\n"
  "	: craf_1 cannot have initial values as it is determined by conservation law\n"
  "	 craf_1_p = 0 : initial condition\n"
  "	: MAPKK cannot have initial values as it is determined by conservation law\n"
  "	: MAPK cannot have initial values as it is determined by conservation law\n"
  "	 craf_1_p_p = 0 : initial condition\n"
  "	 MAPK_p = 0 : initial condition\n"
  "	 MAPKK_p_p = 0 : initial condition\n"
  "	 MAPKK_p = 0 : initial condition\n"
  "	 Raf_p_GTP_Ras = 0 : initial condition\n"
  "	 craf_1_p_ser259 = 0 : initial condition\n"
  "	: inact_GEF cannot have initial values as it is determined by conservation law\n"
  "	 GEF_p = 0 : initial condition\n"
  "	 GTP_Ras = 0 : initial condition\n"
  "	: GDP_Ras cannot have initial values as it is determined by conservation law\n"
  "	 GAP_p = 0 : initial condition\n"
  "	: GAP cannot have initial values as it is determined by conservation law\n"
  "	 inact_GEF_p = 0 : initial condition\n"
  "	: CaM_GEF cannot have initial values as it is determined by conservation law\n"
  "	: EGFR cannot have initial values as it is determined by conservation law\n"
  "	 L_EGFR = 0 : initial condition\n"
  "	 Internal_L_EGFR = 0 : initial condition\n"
  "	 SHC_p_Sos_Grb2 = 0 : initial condition\n"
  "	: SHC cannot have initial values as it is determined by conservation law\n"
  "	 SHC_p = 0 : initial condition\n"
  "	 Sos_p_Grb2 = 0 : initial condition\n"
  "	: Grb2 cannot have initial values as it is determined by conservation law\n"
  "	 Sos_Grb2 = 0 : initial condition\n"
  "	 Sos_p = 0 : initial condition\n"
  "	: Sos cannot have initial values as it is determined by conservation law\n"
  "	 SHC_p_Grb2_clx = 0 : initial condition\n"
  "	: PLC_g cannot have initial values as it is determined by conservation law\n"
  "	 PLC_g_p = 0 : initial condition\n"
  "	 Ca_PLC_g = 0 : initial condition\n"
  "	 Ca_PLC_g_p = 0 : initial condition\n"
  "	: PLCg_basal cannot have initial values as it is determined by conservation law\n"
  "	: MKP_1 cannot have initial values as it is determined by conservation law\n"
  "	: PPhosphatase2A cannot have initial values as it is determined by conservation law\n"
  "	 PKC_act_raf_cplx = 0 : initial condition\n"
  "	 PKC_inact_GAP_cplx = 0 : initial condition\n"
  "	 PKC_act_GEF_cplx = 0 : initial condition\n"
  "	 kenz_cplx = 0 : initial condition\n"
  "	 kenz_cplx_1 = 0 : initial condition\n"
  "	 kenz_cplx_2 = 0 : initial condition\n"
  "	 kenz_cplx_3 = 0 : initial condition\n"
  "	 kenz_cplx_4 = 0 : initial condition\n"
  "	 PLC_Ca_cplx = 0 : initial condition\n"
  "	 PLCb_Ca_Gq_cplx = 0 : initial condition\n"
  "	 MAPK_p_p_cplx = 0 : initial condition\n"
  "	 MAPK_p_p_feedback_cplx = 0 : initial condition\n"
  "	 phosph_Sos_cplx = 0 : initial condition\n"
  "	 MAPKKtyr_cplx = 0 : initial condition\n"
  "	 MAPKKthr_cplx = 0 : initial condition\n"
  "	 Raf_p_GTP_Ras_1_cplx = 0 : initial condition\n"
  "	 Raf_p_GTP_Ras_2_cplx = 0 : initial condition\n"
  "	 basal_GEF_activity_cplx = 0 : initial condition\n"
  "	 GEF_p_act_Ras_cplx = 0 : initial condition\n"
  "	 GAP_inact_Ras_cplx = 0 : initial condition\n"
  "	 CaM_GEF_act_Ras_cplx = 0 : initial condition\n"
  "	 Ca_PLC_g_phospho_cplx = 0 : initial condition\n"
  "	 SHC_phospho_cplx = 0 : initial condition\n"
  "	 Sos_Ras_GEF_cplx = 0 : initial condition\n"
  "	 PLC_g_phospho_cplx = 0 : initial condition\n"
  "	 MKP1_tyr_deph_cplx = 0 : initial condition\n"
  "	 MKP1_thr_deph_cplx = 0 : initial condition\n"
  "	 craf_dephospho_cplx = 0 : initial condition\n"
  "	 MAPKK_dephospho_cplx = 0 : initial condition\n"
  "	 MAPKK_dephospho_ser_cplx = 0 : initial condition\n"
  "	 craf_p_p_dephospho_cplx = 0 : initial condition\n"
  "	 deph_raf_ser259_cplx = 0 : initial condition\n"
  "}\n"
  "BREAKPOINT {\n"
  "	SOLVE ode METHOD cnexp\n"
  "	assign_calculated_values() : procedure\n"
  "}\n"
  "DERIVATIVE ode {\n"
  "	PKC_Ca' = ReactionFlux0-ReactionFlux1-ReactionFlux2-ReactionFlux4 : affects compound with ID S0\n"
  "	PKC_DAG_AA_p' = ReactionFlux5 : affects compound with ID S1\n"
  "	PKC_Ca_AA_p' = ReactionFlux4 : affects compound with ID S2\n"
  "	PKC_Ca_memb_p' = ReactionFlux2 : affects compound with ID S3\n"
  "	PKC_DAG_memb_p' = ReactionFlux3 : affects compound with ID S4\n"
  "	PKC_basal_p' = ReactionFlux6 : affects compound with ID S5\n"
  "	PKC_AA_p' = ReactionFlux7 : affects compound with ID S6\n"
  "	PKC_Ca_DAG' = ReactionFlux1-ReactionFlux3 : affects compound with ID S7\n"
  "	PKC_DAG' = ReactionFlux8-ReactionFlux9 : affects compound with ID S8\n"
  "	PKC_DAG_AA' = -ReactionFlux5+ReactionFlux9 : affects compound with ID S9\n"
  "	: Compound PKC_cytosolic with ID S10 and initial condition 0.001 had derivative -ReactionFlux0-ReactionFlux6-ReactionFlux7-ReactionFlux8, but is calculated by conservation law.\n"
  "	: Compound PLA2_cytosolic with ID S12 and initial condition 0.0004 had derivative -ReactionFlux10+ReactionFlux14-ReactionFlux56, but is calculated by conservation law.\n"
  "	PLA2_Ca_p' = ReactionFlux10-ReactionFlux11-ReactionFlux42+ReactionFlux43 : affects compound with ID S13\n"
  "	: Compound PIP2_PLA2_p with ID S14 and initial condition 0 had derivative -ReactionFlux44+ReactionFlux45, but is calculated by conservation law.\n"
  "	: Compound PIP2_Ca_PLA2_p with ID S15 and initial condition 0 had derivative -ReactionFlux46+ReactionFlux47, but is calculated by conservation law.\n"
  "	DAG_Ca_PLA2_p' = ReactionFlux11-ReactionFlux48+ReactionFlux49 : affects compound with ID S16\n"
  "	PLA2_p_Ca' = ReactionFlux13-ReactionFlux50+ReactionFlux51 : affects compound with ID S18\n"
  "	PLA2_p' = -ReactionFlux13-ReactionFlux14+ReactionFlux57 : affects compound with ID S19\n"
  "	Arachidonic_Acid' = -ReactionFlux4-ReactionFlux7-ReactionFlux9-ReactionFlux12+ReactionFlux43+ReactionFlux45+ReactionFlux47+ReactionFlux49+ReactionFlux51 : affects compound with ID S20\n"
  "	: Compound PLC with ID S21 and initial condition 0.0008 had derivative -ReactionFlux15, but is calculated by conservation law.\n"
  "	PLC_Ca' = ReactionFlux15-ReactionFlux52+ReactionFlux53 : affects compound with ID S23\n"
  "	: Compound PLC_Ca_Gq with ID S24 and initial condition 0 had derivative +ReactionFlux18-ReactionFlux54+ReactionFlux55, but is calculated by conservation law.\n"
  "	PLC_Gq' = -ReactionFlux18 : affects compound with ID S25\n"
  "	DAG' = -ReactionFlux1-ReactionFlux8-ReactionFlux11-ReactionFlux17+ReactionFlux53+ReactionFlux55+ReactionFlux84+ReactionFlux85 : affects compound with ID S27\n"
  "	IP3' = -ReactionFlux16+ReactionFlux53+ReactionFlux55+ReactionFlux84+ReactionFlux85 : affects compound with ID S28\n"
  "	MAPK_p_p' = -ReactionFlux56+ReactionFlux57-ReactionFlux58+ReactionFlux59-ReactionFlux60+ReactionFlux61+ReactionFlux65-ReactionFlux90 : affects compound with ID S30\n"
  "	: Compound craf_1 with ID S31 and initial condition 0.0002 had derivative -ReactionFlux36+ReactionFlux93+ReactionFlux101, but is calculated by conservation law.\n"
  "	craf_1_p' = -ReactionFlux19+ReactionFlux37-ReactionFlux58-ReactionFlux92+ReactionFlux99 : affects compound with ID S32\n"
  "	: Compound MAPKK with ID S33 and initial condition 0.00018001 had derivative -ReactionFlux66+ReactionFlux97, but is calculated by conservation law.\n"
  "	: Compound MAPK with ID S34 and initial condition 0.00036 had derivative -ReactionFlux62+ReactionFlux89, but is calculated by conservation law.\n"
  "	craf_1_p_p' = ReactionFlux59-ReactionFlux98 : affects compound with ID S35\n"
  "	MAPK_p' = ReactionFlux63-ReactionFlux64-ReactionFlux88+ReactionFlux91 : affects compound with ID S36\n"
  "	MAPKK_p_p' = -ReactionFlux62+ReactionFlux63-ReactionFlux64+ReactionFlux65+ReactionFlux69-ReactionFlux94 : affects compound with ID S37\n"
  "	MAPKK_p' = ReactionFlux67-ReactionFlux68+ReactionFlux95-ReactionFlux96 : affects compound with ID S38\n"
  "	Raf_p_GTP_Ras' = ReactionFlux19-ReactionFlux66+ReactionFlux67-ReactionFlux68+ReactionFlux69 : affects compound with ID S39\n"
  "	craf_1_p_ser259' = -ReactionFlux100 : affects compound with ID S40\n"
  "	: Compound inact_GEF with ID S41 and initial condition 0.0001 had derivative +ReactionFlux20+ReactionFlux23-ReactionFlux40-ReactionFlux70+ReactionFlux71, but is calculated by conservation law.\n"
  "	GEF_p' = -ReactionFlux20+ReactionFlux41-ReactionFlux72+ReactionFlux73 : affects compound with ID S42\n"
  "	GTP_Ras' = -ReactionFlux19-ReactionFlux21+ReactionFlux71+ReactionFlux73-ReactionFlux74+ReactionFlux77+ReactionFlux83 : affects compound with ID S43\n"
  "	: Compound GDP_Ras with ID S44 and initial condition 0.0005 had derivative +ReactionFlux21-ReactionFlux70-ReactionFlux72+ReactionFlux75-ReactionFlux76-ReactionFlux82, but is calculated by conservation law.\n"
  "	GAP_p' = -ReactionFlux22+ReactionFlux39 : affects compound with ID S45\n"
  "	: Compound GAP with ID S46 and initial condition 2e-05 had derivative +ReactionFlux22-ReactionFlux38-ReactionFlux74+ReactionFlux75, but is calculated by conservation law.\n"
  "	inact_GEF_p' = -ReactionFlux23 : affects compound with ID S47\n"
  "	: Compound CaM_GEF with ID S48 and initial condition 0 had derivative -ReactionFlux76+ReactionFlux77, but is calculated by conservation law.\n"
  "	: Compound EGFR with ID S49 and initial condition 0.00016666 had derivative -ReactionFlux24, but is calculated by conservation law.\n"
  "	L_EGFR' = ReactionFlux24-ReactionFlux25-ReactionFlux78+ReactionFlux79-ReactionFlux80+ReactionFlux81 : affects compound with ID S50\n"
  "	Internal_L_EGFR' = ReactionFlux25 : affects compound with ID S52\n"
  "	SHC_p_Sos_Grb2' = ReactionFlux27-ReactionFlux82+ReactionFlux83 : affects compound with ID S53\n"
  "	: Compound SHC with ID S54 and initial condition 0.00050001 had derivative +ReactionFlux26-ReactionFlux80, but is calculated by conservation law.\n"
  "	SHC_p' = -ReactionFlux26-ReactionFlux27-ReactionFlux31+ReactionFlux81 : affects compound with ID S55\n"
  "	Sos_p_Grb2' = ReactionFlux28 : affects compound with ID S56\n"
  "	: Compound Grb2 with ID S57 and initial condition 0.001 had derivative -ReactionFlux28-ReactionFlux30-ReactionFlux31, but is calculated by conservation law.\n"
  "	Sos_Grb2' = -ReactionFlux27+ReactionFlux30 : affects compound with ID S58\n"
  "	Sos_p' = -ReactionFlux28-ReactionFlux29+ReactionFlux61 : affects compound with ID S59\n"
  "	: Compound Sos with ID S60 and initial condition 0.0001 had derivative +ReactionFlux29-ReactionFlux30-ReactionFlux60, but is calculated by conservation law.\n"
  "	SHC_p_Grb2_clx' = ReactionFlux31 : affects compound with ID S61\n"
  "	: Compound PLC_g with ID S62 and initial condition 0.00082001 had derivative -ReactionFlux32+ReactionFlux35-ReactionFlux86, but is calculated by conservation law.\n"
  "	PLC_g_p' = -ReactionFlux33-ReactionFlux35+ReactionFlux87 : affects compound with ID S63\n"
  "	Ca_PLC_g' = ReactionFlux32+ReactionFlux34-ReactionFlux78+ReactionFlux84-ReactionFlux84 : affects compound with ID S64\n"
  "	Ca_PLC_g_p' = ReactionFlux33-ReactionFlux34+ReactionFlux79+ReactionFlux85-ReactionFlux85 : affects compound with ID S65\n"
  "	: Compound PLCg_basal with ID S66 and initial condition 7.0002e-07 had derivative -ReactionFlux86+ReactionFlux87, but is calculated by conservation law.\n"
  "	: Compound MKP_1 with ID S67 and initial condition 2e-05 had derivative -ReactionFlux88+ReactionFlux89-ReactionFlux90+ReactionFlux91, but is calculated by conservation law.\n"
  "	: Compound PPhosphatase2A with ID S68 and initial condition 0.00026001 had derivative -ReactionFlux92+ReactionFlux93-ReactionFlux94+ReactionFlux95-ReactionFlux96+ReactionFlux97-ReactionFlux98+ReactionFlux99-ReactionFlux100+ReactionFlux101, but is calculated by conservation law.\n"
  "	PKC_act_raf_cplx' = ReactionFlux36-ReactionFlux37 : affects compound with ID S70\n"
  "	PKC_inact_GAP_cplx' = ReactionFlux38-ReactionFlux39 : affects compound with ID S71\n"
  "	PKC_act_GEF_cplx' = ReactionFlux40-ReactionFlux41 : affects compound with ID S72\n"
  "	kenz_cplx' = ReactionFlux42-ReactionFlux43 : affects compound with ID S73\n"
  "	kenz_cplx_1' = ReactionFlux44-ReactionFlux45 : affects compound with ID S74\n"
  "	kenz_cplx_2' = ReactionFlux46-ReactionFlux47 : affects compound with ID S75\n"
  "	kenz_cplx_3' = ReactionFlux48-ReactionFlux49 : affects compound with ID S76\n"
  "	kenz_cplx_4' = ReactionFlux50-ReactionFlux51 : affects compound with ID S77\n"
  "	PLC_Ca_cplx' = ReactionFlux52-ReactionFlux53 : affects compound with ID S78\n"
  "	PLCb_Ca_Gq_cplx' = ReactionFlux54-ReactionFlux55 : affects compound with ID S79\n"
  "	MAPK_p_p_cplx' = ReactionFlux56-ReactionFlux57 : affects compound with ID S80\n"
  "	MAPK_p_p_feedback_cplx' = ReactionFlux58-ReactionFlux59 : affects compound with ID S81\n"
  "	phosph_Sos_cplx' = ReactionFlux60-ReactionFlux61 : affects compound with ID S82\n"
  "	MAPKKtyr_cplx' = ReactionFlux62-ReactionFlux63 : affects compound with ID S83\n"
  "	MAPKKthr_cplx' = ReactionFlux64-ReactionFlux65 : affects compound with ID S84\n"
  "	Raf_p_GTP_Ras_1_cplx' = ReactionFlux66-ReactionFlux67 : affects compound with ID S85\n"
  "	Raf_p_GTP_Ras_2_cplx' = ReactionFlux68-ReactionFlux69 : affects compound with ID S86\n"
  "	basal_GEF_activity_cplx' = ReactionFlux70-ReactionFlux71 : affects compound with ID S87\n"
  "	GEF_p_act_Ras_cplx' = ReactionFlux72-ReactionFlux73 : affects compound with ID S88\n"
  "	GAP_inact_Ras_cplx' = ReactionFlux74-ReactionFlux75 : affects compound with ID S89\n"
  "	CaM_GEF_act_Ras_cplx' = ReactionFlux76-ReactionFlux77 : affects compound with ID S90\n"
  "	Ca_PLC_g_phospho_cplx' = ReactionFlux78-ReactionFlux79 : affects compound with ID S91\n"
  "	SHC_phospho_cplx' = ReactionFlux80-ReactionFlux81 : affects compound with ID S92\n"
  "	Sos_Ras_GEF_cplx' = ReactionFlux82-ReactionFlux83 : affects compound with ID S93\n"
  "	PLC_g_phospho_cplx' = ReactionFlux86-ReactionFlux87 : affects compound with ID S94\n"
  "	MKP1_tyr_deph_cplx' = ReactionFlux88-ReactionFlux89 : affects compound with ID S95\n"
  "	MKP1_thr_deph_cplx' = ReactionFlux90-ReactionFlux91 : affects compound with ID S96\n"
  "	craf_dephospho_cplx' = ReactionFlux92-ReactionFlux93 : affects compound with ID S97\n"
  "	MAPKK_dephospho_cplx' = ReactionFlux94-ReactionFlux95 : affects compound with ID S98\n"
  "	MAPKK_dephospho_ser_cplx' = ReactionFlux96-ReactionFlux97 : affects compound with ID S99\n"
  "	craf_p_p_dephospho_cplx' = ReactionFlux98-ReactionFlux99 : affects compound with ID S100\n"
  "	deph_raf_ser259_cplx' = ReactionFlux100-ReactionFlux101 : affects compound with ID S101\n"
  "}\n"
  "PROCEDURE observables_func() {\n"
  "	pERK1_2_ratio1 = (MAPK_p+MAPK_p_p+MAPK_p_p_cplx+MAPK_p_p_feedback_cplx) : Output ID Y0\n"
  "	MAPK_out = MAPK : Output ID Y1\n"
  "	MAPK_p_out = MAPK_p : Output ID Y2\n"
  "	MAPK_p_p_out = MAPK_p_p : Output ID Y3\n"
  "	MAPK_p_p_cplx_out = MAPK_p_p_cplx : Output ID Y4\n"
  "	MAPK_p_p_feedback_cplx_out = MAPK_p_p_feedback_cplx : Output ID Y5\n"
  "	pERK1_2_ratio2 = (MAPK_p+MAPK_p_p+MAPK_p_p_cplx+MAPK_p_p_feedback_cplx) : Output ID Y6\n"
  "}\n"
  ;
#endif
