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
 
#define nrn_init _nrn_init__glutamate_ica_nmda
#define _nrn_initial _nrn_initial__glutamate_ica_nmda
#define nrn_cur _nrn_cur__glutamate_ica_nmda
#define _nrn_current _nrn_current__glutamate_ica_nmda
#define nrn_jacob _nrn_jacob__glutamate_ica_nmda
#define nrn_state _nrn_state__glutamate_ica_nmda
#define _net_receive _net_receive__glutamate_ica_nmda 
#define state state__glutamate_ica_nmda 
 
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
#define erev_ampa _p[0]
#define erev_nmda _p[1]
#define tau1_ampa _p[2]
#define tau2_ampa _p[3]
#define tau1_nmda _p[4]
#define tau2_nmda _p[5]
#define mg _p[6]
#define alpha _p[7]
#define eta _p[8]
#define q _p[9]
#define w_ampa _p[10]
#define w_nmda _p[11]
#define i _p[12]
#define g _p[13]
#define i_ampa _p[14]
#define i_nmda _p[15]
#define g_ampa _p[16]
#define g_nmda _p[17]
#define I _p[18]
#define G _p[19]
#define A _p[20]
#define B _p[21]
#define C _p[22]
#define D _p[23]
#define factor_nmda _p[24]
#define factor_ampa _p[25]
#define block _p[26]
#define ica_nmda _p[27]
#define DA _p[28]
#define DB _p[29]
#define DC _p[30]
#define DD _p[31]
#define v _p[32]
#define _g _p[33]
#define _tsav _p[34]
#define _nd_area  *_ppvar[0]._pval
#define _ion_ica_nmda	*_ppvar[2]._pval
#define _ion_dica_nmdadv	*_ppvar[3]._pval
 
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
 static double _hoc_MgBlock();
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

 extern Prop* nrn_point_prop_;
 static int _pointtype;
 static void* _hoc_create_pnt(_ho) Object* _ho; { void* create_point_process();
 return create_point_process(_pointtype, _ho);
}
 static void _hoc_destroy_pnt();
 static double _hoc_loc_pnt(_vptr) void* _vptr; {double loc_point_process();
 return loc_point_process(_pointtype, _vptr);
}
 static double _hoc_has_loc(_vptr) void* _vptr; {double has_loc_point();
 return has_loc_point(_vptr);
}
 static double _hoc_get_loc_pnt(_vptr)void* _vptr; {
 double get_loc_point_process(); return (get_loc_point_process(_vptr));
}
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static void _hoc_setdata(void* _vptr) { Prop* _prop;
 _prop = ((Point_process*)_vptr)->_prop;
   _setdata(_prop);
 }
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 0,0
};
 static Member_func _member_func[] = {
 "loc", _hoc_loc_pnt,
 "has_loc", _hoc_has_loc,
 "get_loc", _hoc_get_loc_pnt,
 "MgBlock", _hoc_MgBlock,
 0, 0
};
#define MgBlock MgBlock_glutamate_ica_nmda
 extern double MgBlock( _threadargsproto_ );
 /* declare global and static user variables */
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "erev_ampa", "mV",
 "erev_nmda", "mV",
 "tau1_ampa", "ms",
 "tau2_ampa", "ms",
 "tau1_nmda", "ms",
 "tau2_nmda", "ms",
 "mg", "mM",
 "w_ampa", "uS",
 "w_nmda", "uS",
 "A", "uS",
 "B", "uS",
 "C", "uS",
 "D", "uS",
 "i", "nA",
 "g", "uS",
 0,0
};
 static double A0 = 0;
 static double B0 = 0;
 static double C0 = 0;
 static double D0 = 0;
 static double delta_t = 0.01;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
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
 static void _hoc_destroy_pnt(_vptr) void* _vptr; {
   destroy_point_process(_vptr);
}
 
static int _ode_count(int);
static void _ode_map(int, double**, double**, double*, Datum*, double*, int);
static void _ode_spec(_NrnThread*, _Memb_list*, int);
static void _ode_matsol(_NrnThread*, _Memb_list*, int);
 
#define _cvode_ieq _ppvar[4]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"glutamate_ica_nmda",
 "erev_ampa",
 "erev_nmda",
 "tau1_ampa",
 "tau2_ampa",
 "tau1_nmda",
 "tau2_nmda",
 "mg",
 "alpha",
 "eta",
 "q",
 "w_ampa",
 "w_nmda",
 0,
 "i",
 "g",
 "i_ampa",
 "i_nmda",
 "g_ampa",
 "g_nmda",
 "I",
 "G",
 0,
 "A",
 "B",
 "C",
 "D",
 0,
 0};
 static Symbol* _ca_nmda_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
  if (nrn_point_prop_) {
	_prop->_alloc_seq = nrn_point_prop_->_alloc_seq;
	_p = nrn_point_prop_->param;
	_ppvar = nrn_point_prop_->dparam;
 }else{
 	_p = nrn_prop_data_alloc(_mechtype, 35, _prop);
 	/*initialize range parameters*/
 	erev_ampa = 0;
 	erev_nmda = 15;
 	tau1_ampa = 1.9;
 	tau2_ampa = 4.8;
 	tau1_nmda = 5.52;
 	tau2_nmda = 231;
 	mg = 1;
 	alpha = 0.062;
 	eta = 18;
 	q = 2;
 	w_ampa = 0.0002;
 	w_nmda = 0.001;
  }
 	_prop->param = _p;
 	_prop->param_size = 35;
  if (!nrn_point_prop_) {
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 5, _prop);
  }
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_ca_nmda_sym);
 	_ppvar[2]._pval = &prop_ion->param[3]; /* ica_nmda */
 	_ppvar[3]._pval = &prop_ion->param[4]; /* _ion_dica_nmdadv */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _net_receive(Point_process*, double*, double);
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _glutamate_writes_ica_nmda_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("ca_nmda", 2.0);
 	_ca_nmda_sym = hoc_lookup("ca_nmda_ion");
 	_pointtype = point_register_mech(_mechanism,
	 nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init,
	 hoc_nrnpointerindex, 1,
	 _hoc_create_pnt, _hoc_destroy_pnt, _member_func);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
 #if NMODL_TEXT
  hoc_reg_nmodl_text(_mechtype, nmodl_file_text);
  hoc_reg_nmodl_filename(_mechtype, nmodl_filename);
#endif
  hoc_register_prop_size(_mechtype, 35, 5);
  hoc_register_dparam_semantics(_mechtype, 0, "area");
  hoc_register_dparam_semantics(_mechtype, 1, "pntproc");
  hoc_register_dparam_semantics(_mechtype, 2, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 4, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 pnt_receive[_mechtype] = _net_receive;
 pnt_receive_size[_mechtype] = 1;
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 glutamate_ica_nmda C:/Users/kadpaj/OneDrive - KI.SE/Skrivbordet/Models/Subcellular_workflow/NEURON/mod/glutamate_writes_ica_nmda.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[4], _dlist1[4];
 static int state(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset = 0; {
   DA = - A / tau1_nmda * q ;
   DB = - B / tau2_nmda * q ;
   DC = - C / tau1_ampa ;
   DD = - D / tau2_ampa ;
   }
 return _reset;
}
 static int _ode_matsol1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
 DA = DA  / (1. - dt*( ( ( - 1.0 ) / tau1_nmda )*( q ) )) ;
 DB = DB  / (1. - dt*( ( ( - 1.0 ) / tau2_nmda )*( q ) )) ;
 DC = DC  / (1. - dt*( ( - 1.0 ) / tau1_ampa )) ;
 DD = DD  / (1. - dt*( ( - 1.0 ) / tau2_ampa )) ;
  return 0;
}
 /*END CVODE*/
 static int state (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) { {
    A = A + (1. - exp(dt*(( ( - 1.0 ) / tau1_nmda )*( q ))))*(- ( 0.0 ) / ( ( ( - 1.0 ) / tau1_nmda )*( q ) ) - A) ;
    B = B + (1. - exp(dt*(( ( - 1.0 ) / tau2_nmda )*( q ))))*(- ( 0.0 ) / ( ( ( - 1.0 ) / tau2_nmda )*( q ) ) - B) ;
    C = C + (1. - exp(dt*(( - 1.0 ) / tau1_ampa)))*(- ( 0.0 ) / ( ( - 1.0 ) / tau1_ampa ) - C) ;
    D = D + (1. - exp(dt*(( - 1.0 ) / tau2_ampa)))*(- ( 0.0 ) / ( ( - 1.0 ) / tau2_ampa ) - D) ;
   }
  return 0;
}
 
static void _net_receive (_pnt, _args, _lflag) Point_process* _pnt; double* _args; double _lflag; 
{  double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   _thread = (Datum*)0; _nt = (_NrnThread*)_pnt->_vnt;   _p = _pnt->_prop->param; _ppvar = _pnt->_prop->dparam;
  if (_tsav > t){ extern char* hoc_object_name(); hoc_execerror(hoc_object_name(_pnt->ob), ":Event arrived out of order. Must call ParallelContext.set_maxstep AFTER assigning minimum NetCon.delay");}
 _tsav = t; {
     if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = A;
    double __primary = (A + factor_nmda) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 ) / tau1_nmda )*( q ) ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 ) / tau1_nmda )*( q ) ) - __primary );
    A += __primary;
  } else {
 A = A + factor_nmda ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = B;
    double __primary = (B + factor_nmda) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 ) / tau2_nmda )*( q ) ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 ) / tau2_nmda )*( q ) ) - __primary );
    B += __primary;
  } else {
 B = B + factor_nmda ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = C;
    double __primary = (C + factor_ampa) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( - 1.0 ) / tau1_ampa ) ) )*( - ( 0.0 ) / ( ( - 1.0 ) / tau1_ampa ) - __primary );
    C += __primary;
  } else {
 C = C + factor_ampa ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = D;
    double __primary = (D + factor_ampa) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( - 1.0 ) / tau2_ampa ) ) )*( - ( 0.0 ) / ( ( - 1.0 ) / tau2_ampa ) - __primary );
    D += __primary;
  } else {
 D = D + factor_ampa ;
     }
 } }
 
double MgBlock ( _threadargsproto_ ) {
   double _lMgBlock;
 _lMgBlock = 1.0 / ( 1.0 + mg * eta * exp ( - alpha * v ) ) ;
   
return _lMgBlock;
 }
 
static double _hoc_MgBlock(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (_NrnThread*)((Point_process*)_vptr)->_vnt;
 _r =  MgBlock ( _p, _ppvar, _thread, _nt );
 return(_r);
}
 
static int _ode_count(int _type){ return 4;}
 
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
	for (_i=0; _i < 4; ++_i) {
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
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_ca_nmda_sym, _ppvar, 2, 3);
   nrn_update_ion_pointer(_ca_nmda_sym, _ppvar, 3, 4);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
  A = A0;
  B = B0;
  C = C0;
  D = D0;
 {
   double _ltp ;
 if ( tau1_nmda / tau2_nmda > .9999 ) {
     tau1_nmda = .9999 * tau2_nmda ;
     }
   if ( tau1_ampa / tau2_ampa > .9999 ) {
     tau1_ampa = .9999 * tau2_ampa ;
     }
   A = 0.0 ;
   B = 0.0 ;
   _ltp = ( tau1_nmda * tau2_nmda ) / ( tau2_nmda - tau1_nmda ) * log ( tau2_nmda / tau1_nmda ) ;
   factor_nmda = - exp ( - _ltp / tau1_nmda ) + exp ( - _ltp / tau2_nmda ) ;
   factor_nmda = 1.0 / factor_nmda ;
   C = 0.0 ;
   D = 0.0 ;
   _ltp = ( tau1_ampa * tau2_ampa ) / ( tau2_ampa - tau1_ampa ) * log ( tau2_ampa / tau1_ampa ) ;
   factor_ampa = - exp ( - _ltp / tau1_ampa ) + exp ( - _ltp / tau2_ampa ) ;
   factor_ampa = 1.0 / factor_ampa ;
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
 _tsav = -1e20;
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

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   g_nmda = ( B - A ) * w_nmda ;
   block = MgBlock ( _threadargs_ ) ;
   i_nmda = g_nmda * ( v - erev_nmda ) * block ;
   ica_nmda = i_nmda ;
   g_ampa = ( D - C ) * w_ampa ;
   i_ampa = g_ampa * ( v - erev_ampa ) ;
   G = g_ampa + g_nmda ;
   I = i_ampa ;
   i = I ;
   }
 _current += i;
 _current += ica_nmda;

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
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ double _dica_nmda;
  _dica_nmda = ica_nmda;
 _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
  _ion_dica_nmdadv += (_dica_nmda - ica_nmda)/.001 * 1.e2/ (_nd_area);
 	}
 _g = (_g - _rhs)/.001;
  _ion_ica_nmda += ica_nmda * 1.e2/ (_nd_area);
 _g *=  1.e2/(_nd_area);
 _rhs *= 1.e2/(_nd_area);
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
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
 {   state(_p, _ppvar, _thread, _nt);
  } }}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(A) - _p;  _dlist1[0] = &(DA) - _p;
 _slist1[1] = &(B) - _p;  _dlist1[1] = &(DB) - _p;
 _slist1[2] = &(C) - _p;  _dlist1[2] = &(DC) - _p;
 _slist1[3] = &(D) - _p;  _dlist1[3] = &(DD) - _p;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "glutamate_writes_ica_nmda.mod";
static const char* nmodl_file_text = 
  "COMMENT\n"
  "Updated Exp2Syn synapse with Mg-blocked nmda channel.\n"
  "\n"
  "Defaul values of parameters (time constants etc) set to match synaptic channels in \n"
  "striatal medium spiny neurons (Du et al., 2017; Chapman et al., 2003; Ding et al., 2008).\n"
  "\n"
  "Robert . Lindroos @ ki . se\n"
  "\n"
  "original comment:\n"
  "________________\n"
  "Two state kinetic scheme synapse described by rise time tau1,\n"
  "and decay time constant tau2. The normalized peak condunductance is 1.\n"
  "Decay time MUST be greater than rise time.\n"
  "\n"
  "The solution of A->G->bath with rate constants 1/tau1 and 1/tau2 is\n"
  " A = a*exp(-t/tau1) and\n"
  " G = a*tau2/(tau2-tau1)*(-exp(-t/tau1) + exp(-t/tau2))\n"
  "	where tau1 < tau2\n"
  "\n"
  "If tau2-tau1 -> 0 then we have a alphasynapse.\n"
  "and if tau1 -> 0 then we have just single exponential decay.\n"
  "\n"
  "The factor is evaluated in the\n"
  "initial block such that an event of weight 1 generates a\n"
  "peak conductance of 1.\n"
  "\n"
  "Because the solution is a sum of exponentials, the\n"
  "coupled equations can be solved as a pair of independent equations\n"
  "by the more efficient cnexp method.\n"
  "\n"
  "ENDCOMMENT\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "NEURON {\n"
  "	POINT_PROCESS glutamate_ica_nmda\n"
  "	RANGE tau1_ampa, tau2_ampa, tau1_nmda, tau2_nmda\n"
  "	RANGE erev_ampa, erev_nmda, g, i\n"
  "	NONSPECIFIC_CURRENT i\n"
  "	\n"
  "	RANGE i_ampa, i_nmda, g_ampa, g_nmda, w_ampa, w_nmda, I, G, mg, q, alpha, eta\n"
  "	USEION ca_nmda WRITE ica_nmda VALENCE 2\n"
  "}\n"
  "\n"
  "\n"
  "UNITS {\n"
  "	(nA) = (nanoamp)\n"
  "	(mV) = (millivolt)\n"
  "	(uS) = (microsiemens)\n"
  "}\n"
  "\n"
  "\n"
  "PARAMETER {\n"
  "	erev_ampa        = 0.0       (mV)\n"
  "	erev_nmda        = 15.0       (mV)\n"
  "	\n"
  "	tau1_ampa   = 1.9       (ms)\n"
  "    tau2_ampa   = 4.8       (ms)  : tau2 > tau1\n"
  "    tau1_nmda   = 5.52      (ms)  : old value was 5.63\n"
  "    tau2_nmda   = 231       (ms)  : tau2 > tau1\n"
  "    \n"
  "    mg          = 1         (mM)\n"
  "    alpha       = 0.062\n"
  "    eta 	= 18\n"
  "    q           = 2\n"
  "    w_ampa = 0.2e-3 (uS)\n"
  "    w_nmda = 1e-3 (uS)\n"
  "}\n"
  "\n"
  "\n"
  "ASSIGNED {\n"
  "	v (mV)\n"
  "	i (nA)\n"
  "	g (uS)\n"
  "	factor_nmda\n"
  "	factor_ampa\n"
  "	i_ampa\n"
  "	i_nmda\n"
  "	g_ampa\n"
  "	g_nmda\n"
  "	block\n"
  "	I\n"
  "	G\n"
  "        ica_nmda (nA)\n"
  "}\n"
  "\n"
  "\n"
  "STATE {\n"
  "	A (uS)\n"
  "	B (uS)\n"
  "	C (uS)\n"
  "	D (uS)\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "INITIAL {\n"
  "	LOCAL tp\n"
  "	if (tau1_nmda/tau2_nmda > .9999) {\n"
  "		tau1_nmda = .9999*tau2_nmda\n"
  "	}\n"
  "	if (tau1_ampa/tau2_ampa > .9999) {\n"
  "		tau1_ampa = .9999*tau2_ampa\n"
  "	}\n"
  "	\n"
  "	: NMDA\n"
  "	A           = 0\n"
  "	B           = 0\n"
  "	tp          = (tau1_nmda*tau2_nmda)/(tau2_nmda - tau1_nmda) * log(tau2_nmda/tau1_nmda)\n"
  "	factor_nmda = -exp(-tp/tau1_nmda) + exp(-tp/tau2_nmda)\n"
  "	factor_nmda = 1/factor_nmda\n"
  "	\n"
  "	: AMPA\n"
  "	C           = 0\n"
  "	D           = 0\n"
  "	tp          = (tau1_ampa*tau2_ampa)/(tau2_ampa - tau1_ampa) * log(tau2_ampa/tau1_ampa)\n"
  "	factor_ampa = -exp(-tp/tau1_ampa) + exp(-tp/tau2_ampa)\n"
  "	factor_ampa = 1/factor_ampa\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "BREAKPOINT {\n"
  "	SOLVE state METHOD cnexp\n"
  "	\n"
  "	: NMDA\n"
  "	g_nmda = (B - A)*w_nmda\n"
  "	block  = MgBlock()\n"
  "	i_nmda = g_nmda * (v - erev_nmda) * block\n"
  "	ica_nmda = i_nmda\n"
  "	\n"
  "	: AMPA\n"
  "	g_ampa = (D - C)*w_ampa\n"
  "	i_ampa = g_ampa * (v - erev_ampa)\n"
  "	\n"
  "	: total current\n"
  "	G = g_ampa + g_nmda\n"
  "	I = i_ampa \n"
  "    	i = I\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "DERIVATIVE state {\n"
  "	A' = -A/tau1_nmda*q\n"
  "	B' = -B/tau2_nmda*q\n"
  "	C' = -C/tau1_ampa\n"
  "	D' = -D/tau2_ampa\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "NET_RECEIVE(weight (uS)) {\n"
  "	A = A + factor_nmda\n"
  "	B = B + factor_nmda\n"
  "	C = C + factor_ampa\n"
  "	D = D + factor_ampa\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "FUNCTION MgBlock() {\n"
  "    \n"
  "    MgBlock = 1 / (1 + mg * eta * exp(-alpha * v)  )\n"
  "    \n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "\n"
  ;
#endif
