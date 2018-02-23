*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
sets
***FORESTRY COST TYPES***
   fcosts32 forestry factor cost types
           / recur,mon /

  land32 forestry land pools
    / new, new_indc, prot, grow, old/

  pol32 afforestation policy type
    / none, npi, indc/

   ac_land32(ac,land32) mapping age class - land type

   kforestry(kall) forestry products
   / wood, woodfuel /
;
*** EOF sets.gms ***
