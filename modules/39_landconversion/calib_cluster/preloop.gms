*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,i,land)   = 0;
i39_reward_reduction(t,i,land) = 0;

* --- Regional crop calibration factor ----------------------------------------
* Per-region fallback: cost=1, reward=0 for any region absent from the CSV,
* or for all regions when s39_ignore_calib=1.
i39_calib(t,i,type39) = f39_calib(t,i,type39);
loop(i,
  if(sum((t,type39), i39_calib(t,i,type39)) = 0 OR s39_ignore_calib = 1,
    i39_calib(t,i,"cost")   = 1;
    i39_calib(t,i,"reward") = 0;
  );
);

* --- Regional pasture calibration factor -------------------------------------
* Per-region fallback: same rationale as for cropland above.
i39_calib_past(t,i,type39) = f39_calib_past(t,i,type39);
loop(i,
  if(sum((t,type39), i39_calib_past(t,i,type39)) = 0 OR s39_ignore_calib = 1,
    i39_calib_past(t,i,"cost")   = 1;
    i39_calib_past(t,i,"reward") = 0;
  );
);

* --- Country / cluster binary switch -----------------------------------------
* 1 = cluster-level calibration active for this country / cluster
p39_country_switch(iso) = 0;
p39_country_switch(policy_countries39) = 1;
* Map country selection down to the cluster level via cell(i,j) and i_to_iso(i,iso)
p39_cell_switch(j) = min(1, sum((cell(i,j),i_to_iso(i,iso)), p39_country_switch(iso)));

* --- Cluster-level crop calibration factor -----------------------------------
* Per-cluster fallback: if a cluster has no data in the file (or
* s39_ignore_calib_cluster=1), inherit the regional crop calibration value
* so that selected clusters without explicit cluster data reproduce the
* regional calibration rather than default to zero cost.
i39_calib_cluster(t,j,type39) = f39_calib_cluster(t,j,type39);
loop(j,
  if(sum((t,type39), i39_calib_cluster(t,j,type39)) = 0 OR s39_ignore_calib_cluster = 1,
    i39_calib_cluster(t,j,"cost")   = sum(cell(i,j), i39_calib(t,i,"cost"));
    i39_calib_cluster(t,j,"reward") = sum(cell(i,j), i39_calib(t,i,"reward"));
  );
);

* --- Cluster-level pasture calibration factor --------------------------------
* Per-cluster fallback: same rationale as for cropland above,
* falling back to the regional pasture calibration value.
i39_calib_past_cluster(t,j,type39) = f39_calib_past_cluster(t,j,type39);
loop(j,
  if(sum((t,type39), i39_calib_past_cluster(t,j,type39)) = 0 OR s39_ignore_calib_cluster = 1,
    i39_calib_past_cluster(t,j,"cost")   = sum(cell(i,j), i39_calib_past(t,i,"cost"));
    i39_calib_past_cluster(t,j,"reward") = sum(cell(i,j), i39_calib_past(t,i,"reward"));
  );
);
