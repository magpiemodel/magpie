*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  pol35 Land protection policy
  / none, npi, ndc /

  prot_type Conservation priority areas
  / BH, CPD, FF, LW, WDPA, HalfEarth /

  pol_stock35 Land types for land protection policies
  / forest, other /

  ac_poulter Forest age classes in Poulter data set
  / class1, class2, class3, class4, class5,
  class6, class7, class8, class9, class10,
  class11, class12, class13, class14, class15 /

  ac_poulter_to_ac(ac_poulter,ac) mapping between ac and ac_poulter
  /
  class1   .  (ac10)
  class2   .  (ac20)
  class3   .  (ac30)
  class4   .  (ac40)
  class5   .  (ac50)
  class6   .  (ac60)
  class7   .  (ac70)
  class8   .  (ac80)
  class9   .  (ac90)
  class10  .  (ac100)
  class11  .  (ac110)
  class12  .  (ac120)
  class13  .  (ac130)
  class14  .  (ac140)
  class15  .  (acx)
  /
;

alias(ac_poulter,ac_poulter2);
