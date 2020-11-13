*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*for GWP* we need the emissions 20 years before. If t-20 does not exist, the closest match is used.
*https://support.gams.com/gams:getting_the_index_position_of_the_largest_element_of_a_set
p56_diff(t2) = abs(m_year(t2) - (m_year(t) - 20));
s56_min = smin(t2, p56_diff(t2));
t20(t2) = p56_diff(t2) = s56_min;
display ct;
display t20;
pc56_emissions_reg_before(i,emis_source,pollutants) = sum(t20, p56_emissions_reg(t20,i,emis_source,pollutants));
