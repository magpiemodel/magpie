*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q44_bii_glo .. v44_bii_glo
 					=e=
 					sum((j2,potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg)) / sum((j2,land), pcm_land(j2,land));

 q44_bii_reg(i2) .. v44_bii_reg(i2)
 					=e=
 					sum((cell(i2,j2),potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg)) / sum((cell(i2,j2),land), pcm_land(j2,land));

 q44_bii_cell(j2) .. v44_bii_cell(j2)
 					=e=
 					sum((potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg)) / sum(land, pcm_land(j2,land));

