*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q39_cost_landcon_annuity(j2,land) .. v39_cost_landcon_annuity(j2,land)
                         =g=
(sum(si,vm_landexpansion(j2,land,si))*sum(cell(i2,j2),pc39_establish_costs(i2,land)) +
sum(si,vm_landreduction(j2,land,si))*pc39_landclear_costs(j2,land))
/sum(cell(i2,j2),pm_annuity_due(i2));

q39_cost_landcon(j2,land) .. vm_cost_landcon(j2,land)
                         =e=
v39_cost_landcon_annuity(j2,land) + pc39_cost_landcon_past(j2,land);
