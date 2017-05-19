*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q40_cost_transport(j2,k) ..           vm_cost_transp(j2,k)
                              =e=
                              vm_prod(j2,k)*f40_distance(j2)*f40_transport_costs(k);
