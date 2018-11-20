p32_error_check = sum((j,kforestry),v32_prod_external.l(j,kforestry));

display "Balance overflow detected:";
display p32_error_check;

if(p32_error_check > 0,
  display "Model is infeasible due to production from heaven.";
);
