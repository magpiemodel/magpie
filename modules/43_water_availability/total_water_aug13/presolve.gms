*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

v43_watavail.fx("surface",j) = im_wat_avail(t,"surface",j);
v43_watavail.fx("technical",j)= im_wat_avail(t,"technical",j);
v43_watavail.fx("ground",j) = im_wat_avail(t,"ground",j);
v43_watavail.fx("ren_ground",j) = im_wat_avail(t,"ren_ground",j);

* Update groundwater availability to include overuse from exogenous demands
v43_watavail.fx("ground",j) = v43_watavail.up("ground",j)
                             + (((sum(watdem_exo, vm_watdem.lo(watdem_exo,j))-sum(wat_src,v43_watavail.up(wat_src,j)))*1.01))
                             $(sum(watdem_exo, vm_watdem.lo(watdem_exo,j))-sum(wat_src,v43_watavail.up(wat_src,j))>0);
