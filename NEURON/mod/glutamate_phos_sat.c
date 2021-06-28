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
 
#define nrn_init _nrn_init__glutamate_phos_sat
#define _nrn_initial _nrn_initial__glutamate_phos_sat
#define nrn_cur _nrn_cur__glutamate_phos_sat
#define _nrn_current _nrn_current__glutamate_phos_sat
#define nrn_jacob _nrn_jacob__glutamate_phos_sat
#define nrn_state _nrn_state__glutamate_phos_sat
#define _net_receive _net_receive__glutamate_phos_sat 
#define calculate_weights calculate_weights__glutamate_phos_sat 
#define state state__glutamate_phos_sat 
 
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
#define tau1_ampa _p[0]
#define tau2_ampa _p[1]
#define tau1_nmda _p[2]
#define tau2_nmda _p[3]
#define w_ampa0 _p[4]
#define w_nmda0 _p[5]
#define e_ampa _p[6]
#define e_nmda _p[7]
#define tau _p[8]
#define tauR _p[9]
#define tauF _p[10]
#define U _p[11]
#define u0 _p[12]
#define q _p[13]
#define base _p[14]
#define f_ampa _p[15]
#define f_nmda _p[16]
#define mg _p[17]
#define alpha _p[18]
#define eta _p[19]
#define total_Substrate _p[20]
#define i _p[21]
#define i_ampa _p[22]
#define i_nmda _p[23]
#define g _p[24]
#define g_ampa _p[25]
#define g_nmda _p[26]
#define w_ampa _p[27]
#define w_nmda _p[28]
#define A_ampa _p[29]
#define B_ampa _p[30]
#define A_nmda _p[31]
#define B_nmda _p[32]
#define ica_nmda _p[33]
#define factor_ampa _p[34]
#define factor_nmda _p[35]
#define x _p[36]
#define DA_ampa _p[37]
#define DB_ampa _p[38]
#define DA_nmda _p[39]
#define DB_nmda _p[40]
#define v _p[41]
#define _g _p[42]
#define _tsav _p[43]
#define _nd_area  *_ppvar[0]._pval
#define _ion_ica_nmda	*_ppvar[2]._pval
#define _ion_dica_nmdadv	*_ppvar[3]._pval
#define pSubstrate	*_ppvar[4]._pval
#define _p_pSubstrate	_ppvar[4]._pval
 
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
 static int hoc_nrnpointerindex =  4;
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 /* declaration of user functions */
 static double _hoc_MgBlock();
 static double _hoc_calculate_weights();
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
 "calculate_weights", _hoc_calculate_weights,
 0, 0
};
#define MgBlock MgBlock_glutamate_phos_sat
 extern double MgBlock( _threadargsproto_ );
 /* declare global and static user variables */
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 "U", 0, 1,
 "u0", 0, 1,
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "tau1_ampa", "ms",
 "tau2_ampa", "ms",
 "tau1_nmda", "ms",
 "tau2_nmda", "ms",
 "w_ampa0", "uS",
 "w_nmda0", "uS",
 "e_ampa", "mV",
 "e_nmda", "mV",
 "tau", "ms",
 "tauR", "ms",
 "tauF", "ms",
 "U", "1",
 "u0", "1",
 "mg", "mM",
 "A_ampa", "uS",
 "B_ampa", "uS",
 "A_nmda", "uS",
 "B_nmda", "uS",
 "i", "nA",
 "i_ampa", "nA",
 "i_nmda", "nA",
 "g", "uS",
 "g_ampa", "uS",
 "g_nmda", "uS",
 0,0
};
 static double A_nmda0 = 0;
 static double A_ampa0 = 0;
 static double B_nmda0 = 0;
 static double B_ampa0 = 0;
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
 
#define _cvode_ieq _ppvar[5]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"glutamate_phos_sat",
 "tau1_ampa",
 "tau2_ampa",
 "tau1_nmda",
 "tau2_nmda",
 "w_ampa0",
 "w_nmda0",
 "e_ampa",
 "e_nmda",
 "tau",
 "tauR",
 "tauF",
 "U",
 "u0",
 "q",
 "base",
 "f_ampa",
 "f_nmda",
 "mg",
 "alpha",
 "eta",
 "total_Substrate",
 0,
 "i",
 "i_ampa",
 "i_nmda",
 "g",
 "g_ampa",
 "g_nmda",
 "w_ampa",
 "w_nmda",
 0,
 "A_ampa",
 "B_ampa",
 "A_nmda",
 "B_nmda",
 0,
 "pSubstrate",
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
 	_p = nrn_prop_data_alloc(_mechtype, 44, _prop);
 	/*initialize range parameters*/
 	tau1_ampa = 2.2;
 	tau2_ampa = 11.5;
 	tau1_nmda = 5.63;
 	tau2_nmda = 320;
 	w_ampa0 = 0.0001;
 	w_nmda0 = 0.001;
 	e_ampa = 0;
 	e_nmda = 15;
 	tau = 3;
 	tauR = 100;
 	tauF = 0;
 	U = 0.3;
 	u0 = 0;
 	q = 2;
 	base = 0;
 	f_ampa = 0;
 	f_nmda = 0;
 	mg = 1;
 	alpha = 0.062;
 	eta = 18;
 	total_Substrate = 3000;
  }
 	_prop->param = _p;
 	_prop->param_size = 44;
  if (!nrn_point_prop_) {
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 6, _prop);
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
 static void _net_init(Point_process*, double*, double);
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _glutamate_phos_sat_reg() {
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
  hoc_register_prop_size(_mechtype, 44, 6);
  hoc_register_dparam_semantics(_mechtype, 0, "area");
  hoc_register_dparam_semantics(_mechtype, 1, "pntproc");
  hoc_register_dparam_semantics(_mechtype, 2, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "ca_nmda_ion");
  hoc_register_dparam_semantics(_mechtype, 4, "pointer");
  hoc_register_dparam_semantics(_mechtype, 5, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 pnt_receive[_mechtype] = _net_receive;
 pnt_receive_init[_mechtype] = _net_init;
 pnt_receive_size[_mechtype] = 5;
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 glutamate_phos_sat C:/Users/kadpaj/OneDrive - KI.SE/Skrivbordet/Models/Subcellular_workflow/NEURON/mod/glutamate_phos_sat.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "Glutamatergic synapse with short-term plasticity";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int calculate_weights(_threadargsproto_);
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[4], _dlist1[4];
 static int state(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset = 0; {
   DA_ampa = - A_ampa * q / tau1_ampa ;
   DB_ampa = - B_ampa * q / tau2_ampa ;
   DA_nmda = - A_nmda * q / tau1_nmda ;
   DB_nmda = - B_nmda * q / tau2_nmda ;
   }
 return _reset;
}
 static int _ode_matsol1 (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
 DA_ampa = DA_ampa  / (1. - dt*( ( ( - 1.0 )*( q ) ) / tau1_ampa )) ;
 DB_ampa = DB_ampa  / (1. - dt*( ( ( - 1.0 )*( q ) ) / tau2_ampa )) ;
 DA_nmda = DA_nmda  / (1. - dt*( ( ( - 1.0 )*( q ) ) / tau1_nmda )) ;
 DB_nmda = DB_nmda  / (1. - dt*( ( ( - 1.0 )*( q ) ) / tau2_nmda )) ;
  return 0;
}
 /*END CVODE*/
 static int state (double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) { {
    A_ampa = A_ampa + (1. - exp(dt*(( ( - 1.0 )*( q ) ) / tau1_ampa)))*(- ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau1_ampa ) - A_ampa) ;
    B_ampa = B_ampa + (1. - exp(dt*(( ( - 1.0 )*( q ) ) / tau2_ampa)))*(- ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau2_ampa ) - B_ampa) ;
    A_nmda = A_nmda + (1. - exp(dt*(( ( - 1.0 )*( q ) ) / tau1_nmda)))*(- ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau1_nmda ) - A_nmda) ;
    B_nmda = B_nmda + (1. - exp(dt*(( ( - 1.0 )*( q ) ) / tau2_nmda)))*(- ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau2_nmda ) - B_nmda) ;
   }
  return 0;
}
 
static void _net_receive (_pnt, _args, _lflag) Point_process* _pnt; double* _args; double _lflag; 
{  double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   _thread = (Datum*)0; _nt = (_NrnThread*)_pnt->_vnt;   _p = _pnt->_prop->param; _ppvar = _pnt->_prop->dparam;
  if (_tsav > t){ extern char* hoc_object_name(); hoc_execerror(hoc_object_name(_pnt->ob), ":Event arrived out of order. Must call ParallelContext.set_maxstep AFTER assigning minimum NetCon.delay");}
 _tsav = t; {
   _args[2] = _args[2] * exp ( - ( t - _args[4] ) / tauR ) ;
   _args[2] = _args[2] + ( _args[1] * ( exp ( - ( t - _args[4] ) / tau ) - exp ( - ( t - _args[4] ) / tauR ) ) / ( tau / tauR - 1.0 ) ) ;
   _args[1] = _args[1] * exp ( - ( t - _args[4] ) / tau ) ;
   x = 1.0 - _args[1] - _args[2] ;
   if ( tauF > 0.0 ) {
     _args[3] = _args[3] * exp ( - ( t - _args[4] ) / tauF ) ;
     _args[3] = _args[3] + U * ( 1.0 - _args[3] ) ;
     }
   else {
     _args[3] = U ;
     }
     if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = A_ampa;
    double __primary = (A_ampa + w_ampa * factor_ampa * _args[3]) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 )*( q ) ) / tau1_ampa ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau1_ampa ) - __primary );
    A_ampa += __primary;
  } else {
 A_ampa = A_ampa + w_ampa * factor_ampa * _args[3] ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = B_ampa;
    double __primary = (B_ampa + w_ampa * factor_ampa * _args[3]) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 )*( q ) ) / tau2_ampa ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau2_ampa ) - __primary );
    B_ampa += __primary;
  } else {
 B_ampa = B_ampa + w_ampa * factor_ampa * _args[3] ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = A_nmda;
    double __primary = (A_nmda + w_nmda * factor_nmda * _args[3]) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 )*( q ) ) / tau1_nmda ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau1_nmda ) - __primary );
    A_nmda += __primary;
  } else {
 A_nmda = A_nmda + w_nmda * factor_nmda * _args[3] ;
     }
   if (nrn_netrec_state_adjust && !cvode_active_){
    /* discon state adjustment for cnexp case (rate uses no local variable) */
    double __state = B_nmda;
    double __primary = (B_nmda + w_nmda * factor_nmda * _args[3]) - __state;
     __primary += ( 1. - exp( 0.5*dt*( ( ( - 1.0 )*( q ) ) / tau2_nmda ) ) )*( - ( 0.0 ) / ( ( ( - 1.0 )*( q ) ) / tau2_nmda ) - __primary );
    B_nmda += __primary;
  } else {
 B_nmda = B_nmda + w_nmda * factor_nmda * _args[3] ;
     }
 _args[1] = _args[1] + x * _args[3] ;
   _args[4] = t ;
   } }
 
static void _net_init(Point_process* _pnt, double* _args, double _lflag) {
       double* _p = _pnt->_prop->param;
    Datum* _ppvar = _pnt->_prop->dparam;
    Datum* _thread = (Datum*)0;
    _NrnThread* _nt = (_NrnThread*)_pnt->_vnt;
 _args[1] = 0.0 ;
   _args[2] = 0.0 ;
   _args[3] = u0 ;
   _args[4] = t ;
   }
 
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
 
static int  calculate_weights ( _threadargsproto_ ) {
   w_ampa = w_ampa0 * ( 1.0 + pSubstrate / total_Substrate ) ;
    return 0; }
 
static double _hoc_calculate_weights(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (_NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 calculate_weights ( _p, _ppvar, _thread, _nt );
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
  A_nmda = A_nmda0;
  A_ampa = A_ampa0;
  B_nmda = B_nmda0;
  B_ampa = B_ampa0;
 {
   double _ltp_ampa , _ltp_nmda ;
 A_ampa = 0.0 ;
   B_ampa = 0.0 ;
   _ltp_ampa = ( tau1_ampa * tau2_ampa ) / ( tau2_ampa - tau1_ampa ) * log ( tau2_ampa / tau1_ampa ) ;
   factor_ampa = - exp ( - _ltp_ampa / tau1_ampa ) + exp ( - _ltp_ampa / tau2_ampa ) ;
   factor_ampa = 1.0 / factor_ampa ;
   tau1_ampa = tau1_ampa ;
   tau2_ampa = tau2_ampa ;
   A_nmda = 0.0 ;
   B_nmda = 0.0 ;
   _ltp_nmda = ( tau1_nmda * tau2_nmda ) / ( tau2_nmda - tau1_nmda ) * log ( tau2_nmda / tau1_nmda ) ;
   factor_nmda = - exp ( - _ltp_nmda / tau1_nmda ) + exp ( - _ltp_nmda / tau2_nmda ) ;
   factor_nmda = 1.0 / factor_nmda ;
   tau1_nmda = tau1_nmda ;
   tau2_nmda = tau2_nmda ;
   w_ampa = w_ampa0 ;
   w_nmda = w_nmda0 ;
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
   double _litotal , _lmggate ;
 calculate_weights ( _threadargs_ ) ;
   _lmggate = MgBlock ( _threadargs_ ) ;
   g_ampa = B_ampa - A_ampa ;
   i_ampa = g_ampa * ( v - e_ampa ) ;
   g_nmda = B_nmda - A_nmda ;
   i_nmda = g_nmda * ( v - e_nmda ) * _lmggate ;
   ica_nmda = i_nmda ;
   i = i_ampa ;
   g = g_ampa + g_nmda ;
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
 _slist1[0] = &(A_ampa) - _p;  _dlist1[0] = &(DA_ampa) - _p;
 _slist1[1] = &(B_ampa) - _p;  _dlist1[1] = &(DB_ampa) - _p;
 _slist1[2] = &(A_nmda) - _p;  _dlist1[2] = &(DA_nmda) - _p;
 _slist1[3] = &(B_nmda) - _p;  _dlist1[3] = &(DB_nmda) - _p;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "glutamate_phos_sat.mod";
static const char* nmodl_file_text = 
  "TITLE Glutamatergic synapse with short-term plasticity\n"
  "\n"
  "NEURON {\n"
  "    THREADSAFE\n"
  "    POINT_PROCESS glutamate_phos_sat\n"
  "    RANGE tau1_ampa, tau2_ampa, tau1_nmda, tau2_nmda\n"
  "    RANGE g_ampa, g_nmda, i_ampa, i_nmda, w_ampa, w_nmda, w_ampa0, w_nmda0\n"
  "    RANGE e_ampa, e_nmda, g, i, q, mg\n"
  "    RANGE tau, tauR, tauF, U, u0\n"
  "    RANGE base, f_ampa, f_nmda\n"
  "    RANGE mg, alpha, eta\n"
  "    \n"
  "    POINTER pSubstrate	\n"
  "    RANGE total_Substrate\n"
  "    \n"
  "    NONSPECIFIC_CURRENT i\n"
  "    USEION ca_nmda WRITE ica_nmda VALENCE 2\n"
  "}\n"
  "\n"
  "UNITS {\n"
  "    (nA) = (nanoamp)\n"
  "    (mV) = (millivolt)\n"
  "    (uS) = (microsiemens)\n"
  "    (mM) = (milli/liter)\n"
  "}\n"
  "\n"
  "PARAMETER {\n"
  "    tau1_ampa= 2.2 (ms)\n"
  "    tau2_ampa = 11.5 (ms)  : tau2 > tau1\n"
  "    tau1_nmda= 5.63 (ms)\n"
  "    tau2_nmda = 320 (ms)  : tau2 > tau1\n"
  "    w_ampa0 = 0.1e-3 (uS)\n"
  "    w_nmda0 = 1.0e-3 (uS)\n"
  "    e_ampa = 0 (mV)\n"
  "    e_nmda = 15 (mV)\n"
  "    tau = 3 (ms)\n"
  "    tauR = 100 (ms)  : tauR > tau\n"
  "    tauF = 0 (ms)  : tauF >= 0 (org: 800 ms)\n"
  "    U = 0.3 (1) <0, 1>\n"
  "    u0 = 0 (1) <0, 1>\n"
  "    q = 2\n"
  "    base   = 0.0      : set in simulation file    \n"
  "	f_ampa = 0.0      : set in simulation file\n"
  "	f_nmda = 0.0      : set in simulation file\n"
  "    	\n"
  "	mg          = 1         (mM)\n"
  "    	alpha       = 0.062\n"
  "    	eta 	= 18\n"
  "	total_Substrate = 3000\n"
  "}\n"
  "\n"
  "ASSIGNED {\n"
  "    v (mV)\n"
  "    i (nA)\n"
  "    i_ampa (nA)\n"
  "    i_nmda (nA)\n"
  "    ica_nmda (nA)\n"
  "    g (uS)\n"
  "    g_ampa (uS)\n"
  "    g_nmda (uS)\n"
  "    factor_ampa\n"
  "    factor_nmda\n"
  "    x\n"
  "    w_ampa\n"
  "    w_nmda\n"
  "    pSubstrate\n"
  "}\n"
  "\n"
  "STATE {\n"
  "    A_ampa (uS)\n"
  "    B_ampa (uS)\n"
  "    A_nmda (uS)\n"
  "    B_nmda (uS)\n"
  "}\n"
  "\n"
  "INITIAL {\n"
  "    LOCAL tp_ampa, tp_nmda\n"
  "    A_ampa = 0\n"
  "    B_ampa = 0\n"
  "    tp_ampa = (tau1_ampa*tau2_ampa)/(tau2_ampa-tau1_ampa) * log(tau2_ampa/tau1_ampa)\n"
  "    factor_ampa = -exp(-tp_ampa/tau1_ampa) + exp(-tp_ampa/tau2_ampa)\n"
  "    factor_ampa = 1/factor_ampa\n"
  "    tau1_ampa = tau1_ampa\n"
  "    tau2_ampa = tau2_ampa\n"
  "    A_nmda = 0\n"
  "    B_nmda = 0\n"
  "    tp_nmda = (tau1_nmda*tau2_nmda)/(tau2_nmda-tau1_nmda) * log(tau2_nmda/tau1_nmda)\n"
  "    factor_nmda = -exp(-tp_nmda/tau1_nmda) + exp(-tp_nmda/tau2_nmda)\n"
  "    factor_nmda = 1/factor_nmda\n"
  "    tau1_nmda = tau1_nmda\n"
  "    tau2_nmda = tau2_nmda\n"
  "    w_ampa = w_ampa0\n"
  "    w_nmda = w_nmda0\n"
  "}\n"
  "\n"
  "BREAKPOINT {\n"
  "    LOCAL itotal, mggate\n"
  "    SOLVE state METHOD cnexp\n"
  "    calculate_weights()\n"
  "    mggate = MgBlock()\n"
  "    g_ampa = B_ampa - A_ampa\n"
  "    i_ampa = g_ampa*(v - e_ampa)\n"
  "    \n"
  "    g_nmda = B_nmda - A_nmda\n"
  "    i_nmda = g_nmda*(v - e_nmda)*mggate\n"
  "    ica_nmda = i_nmda\n"
  "    i = i_ampa\n"
  "    g = g_ampa + g_nmda\n"
  "}\n"
  "\n"
  "DERIVATIVE state {\n"
  "    A_ampa' = -A_ampa*q/tau1_ampa\n"
  "    B_ampa' = -B_ampa*q/tau2_ampa\n"
  "    A_nmda' = -A_nmda*q/tau1_nmda\n"
  "    B_nmda' = -B_nmda*q/tau2_nmda\n"
  "}\n"
  "\n"
  "NET_RECEIVE(weight (uS), y, z, u, tsyn (ms)) {\n"
  "    INITIAL {\n"
  "        y = 0\n"
  "        z = 0\n"
  "        u = u0\n"
  "        tsyn = t\n"
  "    }\n"
  "    z = z*exp(-(t-tsyn)/tauR)\n"
  "    z = z + (y*(exp(-(t-tsyn)/tau) - exp(-(t-tsyn)/tauR)) / (tau/tauR - 1) )\n"
  "    y = y*exp(-(t-tsyn)/tau)\n"
  "    x = 1-y-z\n"
  "    if (tauF > 0) {\n"
  "        u = u*exp(-(t-tsyn)/tauF)\n"
  "        u = u + U*(1-u)\n"
  "    } else {\n"
  "        u = U\n"
  "    }\n"
  "\n"
  "    A_ampa = A_ampa + w_ampa*factor_ampa*u\n"
  "    B_ampa = B_ampa + w_ampa*factor_ampa*u\n"
  "    A_nmda = A_nmda + w_nmda*factor_nmda*u\n"
  "    B_nmda = B_nmda + w_nmda*factor_nmda*u\n"
  "    y = y + x*u\n"
  "    tsyn = t\n"
  "}\n"
  "\n"
  "FUNCTION MgBlock() {\n"
  "    \n"
  "    MgBlock = 1 / (1 + mg * eta * exp(-alpha * v)  )\n"
  "    \n"
  "}\n"
  "\n"
  "PROCEDURE calculate_weights() {\n"
  "	w_ampa = w_ampa0 * (1 + pSubstrate/total_Substrate)\n"
  "}\n"
  "\n"
  "COMMENT\n"
  "\n"
  "Implementation of glutamatergic synapse model with short-term facilitation\n"
  "and depression based on modified tmgsyn.mod [1] by Tsodyks et al [2].\n"
  "Choice of time constants and calcium current model follows [3].\n"
  "NEURON implementation by Alexander Kozlov <akozlov@kth.se>.\n"
  "\n"
  "[1] tmgsyn.mod, ModelDB (https://senselab.med.yale.edu/ModelDB/),\n"
  "accession number 3815.\n"
  "\n"
  "[2] Tsodyks M, Uziel A, Markram H (2000) Synchrony generation in recurrent\n"
  "networks with frequency-dependent synapses. J Neurosci. 20(1):RC50.\n"
  "\n"
  "[3] Wolf JA, Moyer JT, Lazarewicz MT, Contreras D, Benoit-Marand M,\n"
  "O'Donnell P, Finkel LH (2005) NMDA/AMPA ratio impacts state transitions\n"
  "and entrainment to oscillations in a computational model of the nucleus\n"
  "accumbens medium spiny projection neuron. J Neurosci 25(40):9080-95.\n"
  "ENDCOMMENT\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "\n"
  "\n"
  ;
#endif
