*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

subbioen1st60(bioen1st60) = yes;
subbioen1st60("biogas") = no;

$ifthen "%c60_2ndgen_biodem%" == "coupling" i60_bioenergy_dem(t,i) = f60_bioenergy_dem_coupling(t,i);
$else i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"%c60_2ndgen_biodem%");
$endif
* Add minimal bioenergy demand to avoid zero prices
i60_bioenergy_dem(t,i) = i60_bioenergy_dem(t,i) + 0.01;

i60_bioenergy1stgen_dem(t,i,subbioen1st60) = f60_dem_1stgen_bioen(t,i,"%c60_1stgen_biodem",subbioen1st60);