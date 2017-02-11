*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


p59_carbon_density(t,j,"noncropland")$(sum((si,noncropland59),pcm_land(j,noncropland59,si))>0) = p59_som_pool(j,"noncropland")/sum((si,noncropland59),pcm_land(j,noncropland59,si));
p59_carbon_density(t,j,"cropland")$(sum(si,pcm_land(j,"crop",si))>0)=  p59_som_pool(j,"cropland") / sum(si,pcm_land(j,"crop",si));