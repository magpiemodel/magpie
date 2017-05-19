*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

* ### nl_fix ###

vm_yld.fx(j,kve,w) = sum(ct,i14_yields(ct,j,kve,w))*sum(cell(i,j),vm_tau.l(i)/fm_tau1995(i));