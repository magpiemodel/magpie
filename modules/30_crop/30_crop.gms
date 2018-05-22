*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @title Cropland 

*' @description The cropland module simulates the dynamics of cropland area and 
*' agricultural crop production and calculates corresponding carbon contents of 
*' the existing cropland. 

*' @authors Jan Philipp Dietrich, Florian Humpenöder, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%crop%" == "endo_jun13" $include "./modules/30_crop/endo_jun13.gms"
*###################### R SECTION END (MODULETYPES) ############################
