*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*****************************Technical macros***********************************

* Macro for fixing a variable in the case that lower and upper bound are too
* close to each other (closer than argument "sens"). 
* "arg" specifies the set for fixing. "sufx" specifies to what value the variable should be fixed ("l","lo","up").
* EXAMPLE: m_boundfix(vm_land,(j,"ifft"),up,1e-6);
$macro m_boundfix(x,arg,sufx,sens) x.fx arg$(x.up arg-x.lo arg<sens) = x.sufx arg;

$macro m_weightedmean(x,w,s) (sum(s,x*w)/sum(s,w))$(sum(s,w)>0) + 0$(sum(s,w)<=0);

$macro m_growth_vegc(S,A,k,m,ac) S + (A-S)*(1-exp(-k*(ac*5)))**m;

$macro m_growth_litc_soilc(start,end,ac) (start + (end - start) * 1/20 * ac*5)$(ac <= 20/5) + end$(ac > 20/5);

* annuity factor (annuity) for converting the present value (P) of an investment to a repeating annual payment (A): A = P/annuity
* ordinary annuity: cash flow at the end of the period (currently only used for carbon emissions costs as they can become negative (~reward) in case of afforestation)
* https://en.wikipedia.org/wiki/Time_value_of_money (row 4; find A given P)
$macro m_annuity_ord(interest_rate,time_horizon) ((1+interest_rate)**(time_horizon)-1)/(interest_rate*(1+interest_rate)**(time_horizon));

* annuity due: cash flow at the beginning of the period (used for TC, land conversion and irrigation infrastructure costs)
* [Jordan et al (2000,p164-165)] Jordan, Bradford D.; Ross, Stephen David; Westerfield, Randolph (2000). Fundamentals of corporate finance. Boston: Irwin/McGraw-Hill.
* m_annuity_due = m_annuity_ord * (1 + interest_rate)
* http://www.frickcpa.com/tvom/tvom_annuity_due.asp
$macro m_annuity_due(interest_rate,time_horizon) (1-(1+interest_rate)**(-time_horizon))/((interest_rate)/(1+interest_rate));

* returns the year for subsets of time_annual.
* ATTENTION: first year of time_annual needs to be hardcoded here (no possibility
*            to extract it from set). If this changes you have to change
*            it here as well!
$macro m_year(t) (sum(time_annual,ord(time_annual)$sameas(t,time_annual)) + 1964)

* calculates the difference in years to the previous time step and
* sets the difference for the first time step to one.
$macro m_yeardiff(t) (1$(ord(t)=1) + (m_year(t)-m_year(t-1))$(ord(t)>1))

* calculates the difference in years to the previous time step and
* sets the difference for the first time step to five.
$macro m_yeardiff_forestry(t) (5$(ord(t)=1) + (m_year(t)-m_year(t-1))$(ord(t)>1))

* same as m_yeardiff but only for the current time step and written in a way
* that it can be used within equations (no t dependency)
* ATTENTION: t2 needs to exist as alias of t to get this macro working!
* ATTENTION: ct needs to exist as set containing only the current time step
$macro m_timestep_length sum((ct,t2),(1$(ord(t2)=1) + (m_year(t2)-m_year(t2-1))$(ord(t2)>1))$sameas(ct,t2))

* same as m_yeardiff but only for the current time step and written in a way
* that it can be used within equations (no t dependency)
* ATTENTION: t2 needs to exist as alias of t to get this macro working!
* ATTENTION: ct needs to exist as set containing only the current time step
$macro m_timestep_length_forestry sum((ct,t2),(5$(ord(t2)=1) + (m_year(t2)-m_year(t2-1))$(ord(t2)>1))$sameas(ct,t2))

* update total costs by distribute annuity costs over all years within the given time horizon
$macro m_annuity_costs_update(past_costs, cost_annuity, invest_horizon) past_costs = past_costs \
            + cost_annuity$(m_year(t2) > m_year(t) AND m_year(t2) <= m_year(t) + invest_horizon) \
            + (m_year(t) + invest_horizon - m_year(t2-1))/m_yeardiff(t2)*cost_annuity$(m_year(t2) > m_year(t) AND m_year(t2-1) < m_year(t) + invest_horizon AND m_year(t2) > m_year(t) + invest_horizon);


* fill empty years with values from previous time step
* input = name of input parameter
* sets = all sets except of t_all written in quotes (e.g. "kve,w")
$macro m_fillmissingyears(input,sets) loop(t_all, \
          ct_all(t_all) = yes;     \
          if(sum((ct_all,&&sets),input(ct_all,&&sets))=0,    \
            input(t_all,&&sets) = input(t_all-1,&&sets);    \
            display "Data gap in input filled with data from previous time step for the following year: ",ct_all;    \
          ); \
          ct_all(t_all) = no;    \
       );

*** Time interpolation
* macro for linear time interpolation
$macro m_linear_time_interpol(input,start_year,target_year,start_value,target_value) \
  input(t_all)$(m_year(t_all) > start_year AND m_year(t_all) < target_year) = ((m_year(t_all)-start_year) / (target_year-start_year));  \
  input(t_all) = start_value + input(t_all) * (target_value-start_value); \
  input(t_all)$(m_year(t_all) <= start_year) = start_value; \
  input(t_all)$(m_year(t_all) >= target_year) = target_value;

* macro for sigmoid time interpolation (S-shaped curve)
$macro m_sigmoid_time_interpol(input,start_year,target_year,start_value,target_value) \
  input(t_all)$(m_year(t_all) >= start_year AND m_year(t_all) <= target_year) = ((m_year(t_all)-start_year) / (target_year-start_year));  \
  input(t_all) = 1 / (1 + exp(-10*(input(t_all)-0.5))); \
  input(t_all) = start_value + input(t_all) * (target_value-start_value); \
    input(t_all)$(m_year(t_all) <= start_year) = start_value; \
    input(t_all)$(m_year(t_all) >= target_year) = target_value;

*** Data interpolation
* macro for linear cell data interpolation
$macro m_linear_cell_data_interpol(output,x,input_x1,input_x2,input_y1,input_y2) \
  output(j) = input_y1 + (input_y2 - input_y1)/(input_x2 - input_x1) * (x - input_x1);

* macro for simple carbon stocks
$macro m_carbon_stock(land,carbon_density,item) \
            (land(j2,item) * sum(ct,carbon_density(ct,j2,item,ag_pools)))$(sameas(stockType,"actual")) + \
            (land(j2,item) * sum(ct,carbon_density(ct,j2,item,ag_pools)))$(sameas(stockType,"actualNoAcEst"))

* macro for carbon stocks with age classes
$macro m_carbon_stock_ac(land,carbon_density,sets,sets_sub) \
            sum((&&sets), land(j2,&&sets) * sum(ct, carbon_density(ct,j2,&&sets,ag_pools)))$(sameas(stockType,"actual")) + \
            sum((&&sets_sub), land(j2,&&sets_sub) * sum(ct, carbon_density(ct,j2,&&sets_sub,ag_pools)))$(sameas(stockType,"actualNoAcEst"))

* macros for peatland module
$macro m58_LandMerge(land,landForestry,set) \
   land(&&set,"crop")$(sameas(manPeat58,"crop")) \
   + land(&&set,"past")$(sameas(manPeat58,"past")) \
   + landForestry(&&set,"plant")$(sameas(manPeat58,"forestry"))

* macro for trade module
$macro m21_baseline_production(supply, excess_prod, self_suff) \
    ((sum(supreg(h2,i2),supply(i2,k_trade)) + excess_prod(h2,k_trade)) \
     $((sum(ct,self_suff(ct,h2,k_trade)) >= 1)) \
     + (sum(supreg(h2,i2),vm_supply(i2,k_trade)) * sum(ct,self_suff(ct,h2,k_trade))) \
       $((sum(ct,self_suff(ct,h2,k_trade)) < 1)))
