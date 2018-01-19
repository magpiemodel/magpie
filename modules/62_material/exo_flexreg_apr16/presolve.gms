*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

pm_dem_material(t,i,kall) = f62_dem_material_total(t,i,"%c62_material_scenario%")* f62_dem_material_structure(t,i,kall);
