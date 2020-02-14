table f73_observed_timber_demand_pc(t_all,iso,total_wood_products)  FAO data for observed timber demand (mio. m3 per capita per year)
$ondelim
$include "./modules/73_timber/input/f73_observed_timber_demand_pc.csv"
$offdelim
;
m_fillmissingyears(f73_observed_timber_demand_pc,"iso,total_wood_products");
