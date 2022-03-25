*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc13_land(i) = sum(cell(i,j),pcm_land(j,"crop"));

if (sum(sameas(t_past,t),1) = 1 AND s13_ignore_tau_historical = 0,
	vm_tau.lo(h) =    f13_tau_historical(t,h);
else
	vm_tau.lo(h) =    pcm_tau(h);
);


* educated guess for vm_tau.l:
if(ord(t) = 1,
	vm_tau.l(h) = pcm_tau(h);
else
	vm_tau.l(h) = pcm_tau(h)*(1+pc13_tcguess(h))**m_yeardiff(t);
);

vm_tau.up(h) = pcm_tau(h) * (1 + 0.01 * m_yeardiff(t));
*vm_tau.up(h) = 2*pcm_tau(h);
vm_tech_cost.up(i) = 10e9;
