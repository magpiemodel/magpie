*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

 fcosts32 forestry factor cost per annum
 / recur, mon /

 type32 plantation type
 / aff, ndc, plant /

 pol32 afforestation policy type
 / none, npi, ndc /

 kforestry(kall) Forestry products
 / wood, woodfuel /

 bgp32 biogeophysical effect (tCeq per ha) of afforestation on local climate
 / nobgp, ann, djf, jja /

 aff_effect biochemical and local biophysical effect of afforestation on climate
 / bgc,bph /

;
*** EOF sets.gms ***
