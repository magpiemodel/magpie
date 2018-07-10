*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


vm_tau.lo(i) =    pc13_tau(i);
vm_tau.up(i) =  2*pc13_tau(i);

* educated guess for vm_tau.l:
vm_tau.l(i) = pc13_tau(i)*(1+pc13_tcguess(i))**m_yeardiff(t);

vm_tech_cost.up(i) = 10e9;

pc13_tech_cost_past(i) = p13_tech_cost_past(t,i);

pc13_land(i) = sum(cell(i,j),pcm_land(j,"crop"));
