p32_error_check = sum((i,kforestry),v32_prod_external.l(i,kforestry));

display "Balance overflow detected:";
display p32_error_check;

if(p32_error_check > 0,
  display "Model is infeasible due to production from heaven.";
);
