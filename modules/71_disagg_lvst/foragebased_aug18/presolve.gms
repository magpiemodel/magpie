*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i71_forage_cell_prod_share(j,kforage) =
*       vm_prod.l(j,kforage) / (sum(cell(i,j),sum(cell2(i,j3), vm_prod.l(j3,kforage))) + 10**(-6));
       vm_prod.l(j,kforage) / (sum(cell(i,j), vm_prod_reg.l(i,kforage)) + 10**(-6));

* Note that $10^{-6}$ is required to avoid division by zero.
