*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
sets
***FORESTRY COST TYPES***
   fcosts32 Forestry factor cost types
           / recur,mon /

  land32 Forestry land pools
    / new, new_ndc, prot, grow, old/

  pol32 Afforestation policy
    / none, npi, ndc/

   ac_land32(ac,land32) Mapping between age class and forestry land type
;
*** EOF sets.gms ***
