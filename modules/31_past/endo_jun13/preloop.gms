*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Initialize biodiversity value
vm_bv.l(j,"manpast",potnatveg) = 
  pcm_land(j,"past") * fm_luh2_side_layers(j,"manpast") * fm_bii_coeff("manpast",potnatveg) * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"rangeland",potnatveg) = 
  pcm_land(j,"past") * fm_luh2_side_layers(j,"rangeland") * fm_bii_coeff("rangeland",potnatveg) * fm_luh2_side_layers(j,potnatveg);

