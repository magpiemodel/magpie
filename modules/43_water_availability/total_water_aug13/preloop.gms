*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

im_wat_avail(t,"surface",j) = f43_wat_avail(t,j);

im_wat_avail(t,"ground",j) = 0;
im_wat_avail(t,"ren_ground",j) = 0;
im_wat_avail(t,"technical",j) = 0;

i43_crop_area("y1995",j,w,kcr) = fm_croparea("y1995",j,w,kcr);

*Water requirement for every crop at the time of initialization (mio. m^3 per yr)
p43_exo_wat_req(t_all,j) = sum((kcr),i43_crop_area("y1995",j,"irrigated",kcr)*pm_wat_req_k("y1995",j,kcr));


$ifthen "%c43_watavail_scenario%" == "nocc" f43_wat_avail(t_all,j) = f43_wat_avail("y1995",j);
$elseif "%c43_watavail_scenario%" == "nocc_hist" f43_wat_avail(t_all,j)$(m_year(t_all) > sm_fix_cc) = f43_wat_avail(t_all,j)$(m_year(t_all) = sm_fix_cc);
$elseif "%c43_watavail_scenario%" == "exo" f43_wat_avail(t_all,j)$(m_year(t_all) > s43_shock_year) = min(f43_wat_avail("y1995",j), p43_exo_wat_req("y1995",j));
$endif
m_fillmissingyears(f43_wat_avail,"j");
