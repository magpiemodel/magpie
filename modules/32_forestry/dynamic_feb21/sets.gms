*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
sets
***FORESTRY COST TYPES***

 fcostsALL forestry factor cost types
 / recur, mon, harv /

 fcosts32(fcostsALL) forestry factor cost per annum
 / recur, mon /

 type32 plantation type
 / aff, ndc, plant /

 pol32 afforestation policy type
 / none, npi, ndc /

 ini32(j,ac) subset for initialization of timber plantations

 rotation_type Rotation type
 / min, low, def, high, bio /

 bgp32 biogeophysical effect (degree C) of afforestation on local surface temperature
/ nobgp, ann_bph /

tcre32 transient surface temperature response to CO2 emission (degree C per tC)
/ ann_TCREmean, ann_TCREhigh, ann_TCRElow /

aff_effect biochemical and local biophysical effect of afforestation on climate
/ bgc, bph /

ac_bph(ac) fade-in of bph effect over age-classes

inter32 Interpolation of scenario from FAO study on proportion of roundwood production coming from plantations
/abare, brown/

scen32 Scenario for development of roundwood production share from plantations
/ constant,h5s5l5,h5s2l2,h5s2l1,h5s1l1,h5s1l05,h2s1l05 /

 shock_scen32 Scenario name of forest carbon shock
 / none, 002lin2030,004lin2030,008lin2030,016lin2030
  /

;

*** EOF sets.gms ***
