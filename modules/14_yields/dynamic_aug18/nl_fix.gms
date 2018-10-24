*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

vm_yld.fx(j,kcr,w) = sum(ct,i14_yields(ct,j,kcr,w))*sum(cell(i,j),vm_tau.l(i)/fm_tau1995(i));


v14_past_mngmnt_factor.fx(i) = 1.1;
vm_yld.fx(j,"pasture",w) = sum(ct,i14_yields(ct,j,"pasture",w))*sum(cell(i,j),pm_past_mngmnt_factor(ct,i));




                   


