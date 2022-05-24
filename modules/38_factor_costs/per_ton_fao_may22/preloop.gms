*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

# choosing between reginal and global factor requirements
if "%c38_fac_req%" == "glo" i38_fac_req(i,kcr) = f38_fac_req(kcr);
if "%c38_fac_req%" == "reg" i38_fac_req(i,kcr) = f38_fac_req_fao_reg(i,kcr);


