*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

vm_area.fx(j,"begr","irrigated")=0;
vm_area.fx(j,"begr","irrigated")=0;
vm_area.fx(j,"betr","irrigated")=0;

crpmax30(crp30) = yes$(f30_rotation_max_shr(crp30) < 1);
crpmin30(crp30) = yes$(f30_rotation_min_shr(crp30) > 0);
