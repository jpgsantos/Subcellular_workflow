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
 
#define nrn_init _nrn_init__cadyn_nmda
#define _nrn_initial _nrn_initial__cadyn_nmda
#define nrn_cur _nrn_cur__cadyn_nmda
#define _nrn_current _nrn_current__cadyn_nmda
#define nrn_jacob _nrn_jacob__cadyn_nmda
#define nrn_state _nrn_state__cadyn_nmda
#define _net_receive _net_receive__cadyn_nmda 
#define state state__cadyn_nmda 
 
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
#define drive _p[0]
#define cainf _p[1]
#define taur _p[2]
#define pump _p[3]
#define scale _p[4]
#define ca_nmdai _p[5]
#define Dca_nmdai _p[6]
#define ica_nmda _p[7]
#define drive_channel _p[8]
#define drive_pump _p[9]
#define v _p[10]
#define _g _p[11]
#define _ion_ica_nmda	*_ppvar[0]._pval
#define _ion_ca_nmdai	*_ppvar[1]._pval
#define _style_ca_nmda	*((int*)_ppvar[2]._pvoid)
 
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
 "setdata_cadyn_nmda", _hoc_setdata,
 0, 0
};
 /* declare global and static user variables */
#define depth depth_cadyn_nmda
 double depth = 0.1;
#define kd kd_cadyn_nmda
 double kd = 0.0001;
#define kt kt_cadyn_nmda
 double kt = 0.0001;
#define kb kb_cadyn_nmda
 double kb = 96;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "depth_cadyn_nmda", "um",
 "kt_cadyn_nmda", "mM/ms",
 "kd_cadyn_nmda", "mM",
 "drive_cadyn_nmda", "1",
 "cainf_cadyn_nmda", "mM",
 "taur_cadyn_nmda", "ms",
 0,0
};
 static double ca_nmdai0 = 0;
 static double delta_t = 0.01;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "depth_cadyn_nmda", &depth_cadyn_nmda,
 "kb_cadyn_nmda", &kb_cadyn_nmda,
 "kt_cadyn_nmda", &kt_cadyn_nmda,
 "kd_cadyn_nmda", &kd_cadyn_nmda,
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
 
#define _cvode_ieq _ppvar[3]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"cadyn_nmda",
 "drive_cadyn_nmda",
 "cainf_cadyn_nmda",
 "taur_cadyn_nmda",
 "pump_cadyn_nmda",
 "scale_cadyn_nmda",
 0,
 0,
 0,
 0};
 static Symbol* _ca_nmda_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 12, _prop);
 	/*initialize range parameters*/
 	drive = 10000;
 	cainf = 0.00013;
 	taur = 100;
 	pump = 0.02;
 	scale = 1;
 	_prop->param = _p;
 	_prop->param_size = 12;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 4, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_ca_nmda_sym);
 nrn_check_conc_write(_prop, prop_ion, 1);
 nrn_promote(prop_ion, 3, 0);
 	_ppvar[0]._pval = &prop_ion->param[3]; /* ica_nmda */
 	_ppvar[1]._pval = &prop_ion->param[1]; /* ca_nmdai */
 	_ppvar[2]._pvoid = (void*)(&(prop_ion->dparam[0]._i)); /* iontype for ca_nmda */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _cadyn_nmda_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("ca_nmda", 2.0);
 	_ca_nmda_sym = hoc_lookup("ca_nmda_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 1);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
 #if NMODL_TEXT
  hoc_reg_nmodl_text(_mechtype, nmodl_file_text);
  hoc_reg_nmodl_filename(_mechtype, nmodl_filename);
#endif
  hoc_register_prop_size(_mechtype, 12, 4);
  hoc_register_dparam_semantics(_mechtype, 0, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 1, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 2, "#ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "cvodeieq");
 	nrn_writes_conc(_mechtype, 0);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 cadyn_nmda C:/Users/kadpaj/OneDrive - KI.SE/Skrivbordet/Models/Subcellular_workflow/NEURON/mod/cadyn_nmda.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
 static double FARADAY = 96485.3;
static int _reset;
static char *modelname = "Calcium dynamics for NMDA calcium pool";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[1], _dlist1[1];
 static int state(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset = 0; {
   drive_channel = - scale * drive * ica_nmda / ( 2.0 * FARADAY * depth * ( 1.0 + kb ) ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     }
   drive_pump = - kt * ca_nmdai / ( ca_nmdai + kd ) ;
   Dca_nmdai = ( drive_channel + pump * drive_pump + 0.693147181 * ( cainf - ca_nmdai ) / taur ) ;
   }
 return _reset;
}
 static int _ode_matsol1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
 drive_channel = - scale * drive * ica_nmda / ( 2.0 * FARADAY * depth * ( 1.0 + kb ) ) ;
 if ( drive_channel <= 0. ) {
   drive_channel = 0. ;
   }
 drive_pump = - kt * ca_nmdai / ( ca_nmdai + kd ) ;
 Dca_nmdai = Dca_nmdai  / (1. - dt*( ( ( ( 0.693147181 )*( ( ( - 1.0 ) ) ) ) / taur ) )) ;
  return 0;
}
 /*END CVODE*/
 static int state (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) { {
   drive_channel = - scale * drive * ica_nmda / ( 2.0 * FARADAY * depth * ( 1.0 + kb ) ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     }
   drive_pump = - kt * ca_nmdai / ( ca_nmdai + kd ) ;
    ca_nmdai = ca_nmdai + (1. - exp(dt*(( ( ( 0.693147181 )*( ( ( - 1.0 ) ) ) ) / taur ))))*(- ( ( drive_channel + ( pump )*( drive_pump ) + ( ( 0.693147181 )*( ( cainf ) ) ) / taur ) ) / ( ( ( ( 0.693147181 )*( ( ( - 1.0 ) ) ) ) / taur ) ) - ca_nmdai) ;
   }
  return 0;
}
 
static int _ode_count(int _type){ return 1;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ica_nmda = _ion_ica_nmda;
  ca_nmdai = _ion_ca_nmdai;
  ca_nmdai = _ion_ca_nmdai;
     _ode_spec1 (_p, _ppvar, _thread, _nt);
  _ion_ca_nmdai = ca_nmdai;
 }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 1; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 	_pv[0] = &(_ion_ca_nmdai);
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
  ica_nmda = _ion_ica_nmda;
  ca_nmdai = _ion_ca_nmdai;
  ca_nmdai = _ion_ca_nmdai;
 _ode_matsol_instance1(_threadargs_);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_ca_nmda_sym, _ppvar, 0, 3);
   nrn_update_ion_pointer(_ca_nmda_sym, _ppvar, 1, 1);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
 {
   ca_nmdai = cainf ;
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
  ica_nmda = _ion_ica_nmda;
  ca_nmdai = _ion_ca_nmdai;
  ca_nmdai = _ion_ca_nmdai;
 initmodel(_p, _ppvar, _thread, _nt);
  _ion_ca_nmdai = ca_nmdai;
  nrn_wrote_conc(_ca_nmda_sym, (&(_ion_ca_nmdai)) - 1, _style_ca_nmda);
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
  ica_nmda = _ion_ica_nmda;
  ca_nmdai = _ion_ca_nmdai;
  ca_nmdai = _ion_ca_nmdai;
 {   state(_p, _ppvar, _thread, _nt);
  } {
   }
  _ion_ca_nmdai = ca_nmdai;
}}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(ca_nmdai) - _p;  _dlist1[0] = &(Dca_nmdai) - _p;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "cadyn_nmda.mod";
static const char* nmodl_file_text = 
  "TITLE Calcium dynamics for NMDA calcium pool\n"
  "\n"
  "NEURON {\n"
  "    SUFFIX cadyn_nmda\n"
  "    USEION ca_nmda READ ica_nmda, ca_nmdai WRITE ca_nmdai VALENCE 2\n"
  "    RANGE pump, cainf, taur, drive, scale\n"
  "}\n"
  "\n"
  "UNITS {\n"
  "    (molar) = (1/liter) \n"
  "    (mM) = (millimolar)\n"
  "    (um) = (micron)\n"
  "    (mA) = (milliamp)\n"
  "    (msM) = (ms mM)\n"
  "    FARADAY = (faraday) (coulomb)\n"
  "}\n"
  "\n"
  "PARAMETER {\n"
  "    drive = 10000 (1)\n"
  "    depth = 0.1 (um)\n"
  "    cainf = 130e-6 (mM)\n"
  "    taur = 100 (ms)\n"
  "    kb = 96 : 200 in soma\n"
  "    kt = 1e-4 (mM/ms)\n"
  "    kd = 1e-4 (mM)\n"
  "    pump = 0.02\n"
  "    scale = 1\n"
  "}\n"
  "\n"
  "STATE { ca_nmdai (mM) }\n"
  "\n"
  "INITIAL { ca_nmdai = cainf }\n"
  "\n"
  "ASSIGNED {\n"
  "    ica_nmda (mA/cm2)\n"
  "    drive_channel (mM/ms)\n"
  "    drive_pump (mM/ms)\n"
  "}\n"
  "    \n"
  "BREAKPOINT {\n"
  "    SOLVE state METHOD cnexp\n"
  "}\n"
  "\n"
  "DERIVATIVE state { \n"
  "    drive_channel = -scale*drive*ica_nmda/(2*FARADAY*depth*(1+kb))\n"
  "    if (drive_channel <= 0.) { drive_channel = 0. }\n"
  "    drive_pump = -kt*ca_nmdai/(ca_nmdai+kd)\n"
  "    ca_nmdai' = (drive_channel+pump*drive_pump+0.693147181*(cainf-ca_nmdai)/taur)\n"
  "}\n"
  "\n"
  "COMMENT\n"
  "\n"
  "Original model by Wolf (2005) and Destexhe (1992).\n"
  "\n"
  "Ca shell parameters by Evans (2012), with kb but without pump.\n"
  "\n"
  "NEURON implementation by Alexander Kozlov <akozlov@nada.kth.se>.\n"
  "\n"
  "ENDCOMMENT\n"
  ;
#endif
