*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
  cost_estimate39 cost estimate for land clearing costs
  / low_estimate, medium_estimate, high_estimate /

  bound39 bound for land conversion costs
    / low_gdp, high_gdp /

** vegetation that creates costs when being removed
   ffoland(land)
        / forestry, forest, other /
;
