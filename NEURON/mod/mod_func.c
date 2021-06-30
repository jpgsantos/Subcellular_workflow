#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _Im_reg();
extern void _Nair_2016_reg();
extern void _SBTAB_Findsim_reg();
extern void _bk_reg();
extern void _cadyn_reg();
extern void _cadyn_nmda_reg();
extern void _cal12_reg();
extern void _cal13_reg();
extern void _caldyn_reg();
extern void _can_reg();
extern void _caq_reg();
extern void _car_reg();
extern void _cat32_reg();
extern void _cat33_reg();
extern void _cav32_reg();
extern void _cav33_reg();
extern void _gaba_reg();
extern void _glutamate_reg();
extern void _glutamate_phos_reg();
extern void _glutamate_phos_sat_reg();
extern void _glutamate_writes_ica_nmda_reg();
extern void _inhexpsyn_reg();
extern void _kaf_reg();
extern void _kas_reg();
extern void _kdr_reg();
extern void _kir_reg();
extern void _naf_reg();
extern void _pregen_reg();
extern void _sk_reg();
extern void _vecevent_reg();

void modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," Im.mod");
fprintf(stderr," Nair_2016.mod");
fprintf(stderr," SBTAB_Findsim.mod");
fprintf(stderr," bk.mod");
fprintf(stderr," cadyn.mod");
fprintf(stderr," cadyn_nmda.mod");
fprintf(stderr," cal12.mod");
fprintf(stderr," cal13.mod");
fprintf(stderr," caldyn.mod");
fprintf(stderr," can.mod");
fprintf(stderr," caq.mod");
fprintf(stderr," car.mod");
fprintf(stderr," cat32.mod");
fprintf(stderr," cat33.mod");
fprintf(stderr," cav32.mod");
fprintf(stderr," cav33.mod");
fprintf(stderr," gaba.mod");
fprintf(stderr," glutamate.mod");
fprintf(stderr," glutamate_phos.mod");
fprintf(stderr," glutamate_phos_sat.mod");
fprintf(stderr," glutamate_writes_ica_nmda.mod");
fprintf(stderr," inhexpsyn.mod");
fprintf(stderr," kaf.mod");
fprintf(stderr," kas.mod");
fprintf(stderr," kdr.mod");
fprintf(stderr," kir.mod");
fprintf(stderr," naf.mod");
fprintf(stderr," pregen.mod");
fprintf(stderr," sk.mod");
fprintf(stderr," vecevent.mod");
fprintf(stderr, "\n");
    }
_Im_reg();
_Nair_2016_reg();
_SBTAB_Findsim_reg();
_bk_reg();
_cadyn_reg();
_cadyn_nmda_reg();
_cal12_reg();
_cal13_reg();
_caldyn_reg();
_can_reg();
_caq_reg();
_car_reg();
_cat32_reg();
_cat33_reg();
_cav32_reg();
_cav33_reg();
_gaba_reg();
_glutamate_reg();
_glutamate_phos_reg();
_glutamate_phos_sat_reg();
_glutamate_writes_ica_nmda_reg();
_inhexpsyn_reg();
_kaf_reg();
_kas_reg();
_kdr_reg();
_kir_reg();
_naf_reg();
_pregen_reg();
_sk_reg();
_vecevent_reg();
}
