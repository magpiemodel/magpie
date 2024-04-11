*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

total_wood_products   End use wood product category from FAO
/
roundwood,
industrial_roundwood,wood_fuel,other_industrial_roundwood,
pulpwood,sawlogs_and_veneer_logs,fibreboard,particle_board_and_osb,
wood_pulp,sawnwood, plywood, veneer_sheets,
wood_based_panels,other_sawnwood
/

wood_products(total_wood_products)  Major 2nd level products from wood processing
/
fibreboard,particle_board_and_osb,plywood,veneer_sheets,
wood_pulp,
sawnwood,
other_industrial_roundwood
/

construction_wood(total_wood_products)        Wood products used for building construction
/
fibreboard,particle_board_and_osb,plywood,veneer_sheets,sawnwood
/

wood_panels(wood_products)        Wood products used for panels construction
/
fibreboard,particle_board_and_osb,plywood,veneer_sheets
/

kforestry_to_woodprod(kforestry,total_wood_products) Mapping between intermediate and end use wood products
/
wood . (fibreboard,particle_board_and_osb,plywood,veneer_sheets,wood_pulp,sawnwood,other_sawnwood,other_industrial_roundwood)
woodfuel . (wood_fuel)
/

scen_73 Forestry future scenario
/
nopaper, construction
/

build_scen Building wood scenario
/
BAU, 10pc, 50pc, 90pc
/

;
*** EOF sets.gms ***
