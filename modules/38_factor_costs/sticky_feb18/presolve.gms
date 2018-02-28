
*if (sum(sameas(t_past,t),1) = 1,
if (ord(t) = 1,
  i38_capital_requirement(i,kcr) =  f38_fac_req_per_ton(kcr) / 3 / s38_annual_depreciation_rate * pm_annuity_due(i);
* dividing by depreciation calculates back from the investments in one period to the total capital stock
* multiplying by the annuity transforms this from a yearly payment into a one-time investment
* this is transformed back into an annuity within the code, but using the interest rate of the timestep.

* irgendwas mit depreciation und interest rate, assuming for now factor 10;
* should probably not distinguish between capital of irrigation and other capital, should we?
  p38_croparea_preexisting_capital(t,j,kcr) = sum(cell(i,j),f38_croparea_initialisation(t,j,kcr) * i38_capital_requirement(i,kcr) * fm_tau1995(i));
else
  p38_croparea_preexisting_capital(t,j,kcr) = p38_croparea_preexisting_capital(t-1,j,kcr) + p38_croparea_investment(j,kcr);
);

p38_croparea_preexisting_capital(t,j,kcr) = p38_croparea_preexisting_capital(t,j,kcr) * (1-s38_annual_depreciation_rate);