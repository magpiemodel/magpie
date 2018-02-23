*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

 q43_water(j2)  .. sum(wat_dem,vm_watdem(wat_dem,j2))
                        =l=
                        sum(wat_src,v43_watavail(wat_src,j2))  ;
