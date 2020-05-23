*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s73_price_adjuster Switch for price based adjustment /0/
  s73_timber_demand Switch for timber demand / 1 /
  s73_counter Counter for iterations of demand adjustment / 0 /
  s73_maxiter Maximum iterations for demand adjustments / 1 /
  s73_price_elasticity price elasticity from lauri et al / -0.1 /
  s73_counter2 Counter for iterations of demand adjustment / 0 /
  s73_maxiter2 Maximum iterations for demand adjustments / 1 /
;

table f73_prod_specific_timber(t_past,iso,total_wood_products) demand
$ondelim
$include "./modules/73_timber/input/f73_prod_specific_timber.csv"
$offdelim
;
