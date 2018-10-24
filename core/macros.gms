*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*****************************Technical macros***********************************

* Macro for fixing a variable in the case that lower and upper bound are too
* close to each other (closer than argument "sens")
* EXAMPLE: ma_boundfix(vm_land,(j,"ifft"),up,10e-5);
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

* same as m_yeardiff but only for the current time step and written in a way
* that it can be used within equations (no t dependency)
* ATTENTION: t2 needs to exist as alias of t to get this macro working!
* ATTENTION: ct needs to exist as set containing only the current time step
$macro m_timestep_length sum((ct,t2),(1$(ord(t2)=1) + (m_year(t2)-m_year(t2-1))$(ord(t2)>1))$sameas(ct,t2))

* update total costs by distribute annuity costs over all years within the given time horizon
$macro m_annuity_costs_update(past_costs, cost_annuity, invest_horizon) past_costs = past_costs \
            + cost_annuity$(m_year(t2) > m_year(t) AND m_year(t2) <= m_year(t) + invest_horizon) \
            + (m_year(t) + invest_horizon - m_year(t2-1))/m_yeardiff(t2)*cost_annuity$(m_year(t2) > m_year(t) AND m_year(t2-1) < m_year(t) + invest_horizon AND m_year(t2) > m_year(t) + invest_horizon);


* fill empty years with values from previous time step
* input = name of input parameter
* sets = all sets except of t_all written in quotes (e.g. "kve,w")
$macro m_fillmissingyears(input,sets) loop(t, \
          ct(t) = yes;     \
          if(sum((ct,&&sets),input(ct,&&sets))=0,    \
            input(t,&&sets) = input(t-1,&&sets);    \
            display "Data gap in input filled with data from previous time step for the following year: ",ct;    \
          ); \
          ct(t) = no;    \
       );
