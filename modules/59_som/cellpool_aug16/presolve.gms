*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p59_carbon_density(t,j,noncropland59)$(pcm_land(j,noncropland59)>0) = p59_som_pool(j,noncropland59)/pcm_land(j,noncropland59);
p59_carbon_density(t,j,"crop")$(pcm_land(j,"crop")>0)=  p59_som_pool(j,"crop") / pcm_land(j,"crop");
