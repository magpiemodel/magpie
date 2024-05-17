*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s22_shift number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 p22_wdpa_baseline(t,j,base22,land)                 Baseline protection (mio. ha)
 p22_conservation_area(t,j,land)                    Total land conservation area for all land types (mio. ha)
 pm_land_conservation(t,j,land,consv_type)          Land protection and restoration for all land types (mio. ha)
 p22_conservation_fader(t_all)                      Land conservation fader (1)
 p22_add_consv(t,j,consv22_all,land)                Additional land conservation in conservation priority areas (mio. ha)
 p22_secdforest_restore_pot(t,j)                    Potential secondary forest restoration area (mio. ha)
 p22_past_restore_pot(t,j)                          Potential pasture restoration area (mio. ha)
 p22_other_restore_pot(t,j)                         Potential other land restoration area (mio. ha)
 p22_country_weight(i)                              Land conservation country weight per region (1)
 p22_country_dummy(iso)                             Dummy parameter indicating whether country is affected by selected land conservation policy (1)
 i22_land_iso(iso)                                  Total land area at ISO level (mio. ha)
;

