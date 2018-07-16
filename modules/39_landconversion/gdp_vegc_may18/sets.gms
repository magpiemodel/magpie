*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
  cost_estimate39 cost estimate for land clearing costs
  / verylow_estimate, low_estimate, medium_estimate, high_estimate, veryhigh_estimate, magpie3, pure_estab /

  bound39 bound for land conversion costs
    / low_gdp, high_gdp /

** vegetation that creates costs when being removed
   land_natveg(land)
        / primforest, secdforest, other /

reg_min_gdp(i) region with the smallest gdp
reg_max_gdp(i) region with the highest gdp
;
