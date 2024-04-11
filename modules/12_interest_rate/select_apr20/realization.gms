*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The select_apr20 realization allows to flexibly choose regional
*' or global interest rates. In the default setting, the interest rate depends
*' on the development state `im_development_state`, which is calculated based
*' on GDP per capita. Thus, interest rates are regionally specific and dynamic
*' over time.
*' Alternative interest rates can be selected via the interest rate coefficients
*' (`s12_interest_lic`, `s12_interest_hic`, `s12_hist_interest_lic`, `s12_hist_interest_hic`).
*' The future interest rate policy fades in starting from 2025 until it is fully
*' in effect by 2050.
*' It is also possible to choose a global interest rate.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/12_interest_rate/select_apr20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/12_interest_rate/select_apr20/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/12_interest_rate/select_apr20/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
