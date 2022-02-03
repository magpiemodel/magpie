*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc13_land(i,"pastr") = sum(cell(i,j),pcm_land(j,"past"));
pc13_land(i,"crop") = sum(cell(i,j),pcm_land(j,"crop"));

if (sum(sameas(t_past,t),1) = 1 AND s13_ignore_tau_historical = 0,
	vm_tau.lo(h,"pastr") =   fm_pastr_tau_hist(t,h);
	vm_tau.lo(h,"crop") =    f13_tau_historical(t,h);
else
	vm_tau.lo(h, tautype) =    pcm_tau(h, tautype);
);

	vm_tau.up(h,tautype) =  2*pcm_tau(h,tautype);

* educated guess for vm_tau.l:
if(ord(t) = 1,
	vm_tau.l(h,tautype) = pcm_tau(h,tautype);
else
	vm_tau.l(h,tautype) = pcm_tau(h,tautype)*(1+pc13_tcguess(h,tautype))**m_yeardiff(t);
);

vm_tau.up(h,tautype) = 2*pcm_tau(h,tautype);
vm_tech_cost.up(i) = 10e9;
