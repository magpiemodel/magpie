*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q37_cost_landtax_annuity(j2,land_ag) .. v37_cost_landtax_annuity(j2,land_ag)
        						=g=
 (vm_land(j2,land_ag) - pcm_land(j2,land_ag))*sum(ct, f37_land_tax(ct))/sum(cell(i2,j2),pm_annuity_due(i2));

q37_cost_landtax(j2,land_ag) .. vm_cost_landtax(j2,land_ag)
                          =e=
 v37_cost_landtax_annuity(j2,land_ag) + sum(ct, p37_cost_landtax_past(ct,j2,land_ag));
