*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p59_carbon_density(t,j,"noncropland")$(sum(noncropland59,pcm_land(j,noncropland59))>0) = p59_som_pool(j,"noncropland")/sum(noncropland59,pcm_land(j,noncropland59));
p59_carbon_density(t,j,"cropland")$(pcm_land(j,"crop")>0)=  p59_som_pool(j,"cropland") / pcm_land(j,"crop");
