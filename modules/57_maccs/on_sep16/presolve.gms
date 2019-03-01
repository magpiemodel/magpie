*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

if((ord(t) = 1),
i57_maccs_mitigation_diff(t,i,emis_source,pollutants) = 0;
else
i57_maccs_mitigation_diff(t,i,emis_source,pollutants) = 
im_maccs_mitigation(t,i,emis_source,pollutants) - 
im_maccs_mitigation(t-1,i,emis_source,pollutants);
);