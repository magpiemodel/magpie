*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  type39 Cost type
    / cost, reward /
;

* Set-switch for countries receiving cluster-level land conversion calibration.
* Default: BRA only. Add or remove ISO country codes to change the selection.
sets
  policy_countries39(iso) countries to receive cluster-level land conversion calibration
    / BRA /
;
