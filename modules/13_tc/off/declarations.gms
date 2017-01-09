*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variables
 vm_tau(i)                       agricultural land use intensity tau (1)
 vm_tech_cost(i)                 costs of technological change (mio. US$)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,i,type)       agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type) costs of technological change (mio. US$)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
