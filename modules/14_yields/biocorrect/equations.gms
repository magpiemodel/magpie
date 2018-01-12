*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q14_yield_crop(j2,kcr,w) .. vm_yld(j2,kcr,w) =e=
                    sum(ct,i14_yields(ct,j2,kcr,w))*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2));

q14_yield_past(j2,w) .. vm_yld(j2,"pasture",w) =e=
                    sum(ct,i14_yields(ct,j2,"pasture",w))
                    *((1-s14_yld_past_switch) + s14_yld_past_switch*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2)) );