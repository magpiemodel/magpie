*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
pm_land_start(j,land) = f10_land("y1995",j,land);
pm_land_start(j,land)$(pm_land_start(j,land)<0) = 0;

pcm_land(j,land) = pm_land_start(j,land);
