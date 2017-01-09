*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
***Cost parameters********************************************
*Annuity-due annual cash flows over n years (vorschuessig)
*http://en.wikipedia.org/wiki/Annuity_(finance_theory)#Annuity-due

pm_interest(i)        current real interest rate in each region
pm_annuity_due(i)     current Annuity-due annual cash flows over n years in each region (vorschuessig)
p12_interest(t,i)	  real interest rate in each region and timestep
p12_annuity_due(t,i)  Annuity-due annual cash flows over n years in each region (vorschuessig) and timestep
;
