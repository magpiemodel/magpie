## :bird: Purpose of this PR :bird:

- Briefly explain the purpose of this pull request

## :wrench: Checklist for PR creator :wrench:

- [ ] Labeling pull request correctly [from the label list](https://github.com/magpiemodel/magpie/labels).

* Low risk : Simple bugfixes (missing files, updated documentation, typos) or Start/output scripts
* Medium risk : New realization / Changes to existing realization / Other changes which don't modify default.cfg
* High risk : New input files (if cfg$input is changed in default.cfg) / Modification to core model (eg. changes in equations, calculations, introduction of new sets etc.) / Other changes in default.cfg

- [ ] Providing additional information based on PR label

* Low risk : No new model run needed.
* Medium risk : Default run based on the current version of the fork from which PR is made
* High risk
  * Default run from the current develop branch
  * Default run based on the current version of the fork from which PR is made

- [ ] :chart_with_downwards_trend: Performance loss/gain from current default behavior :chart_with_upwards_trend:
  * Current develop branch default : ** mins
  * This PR's default :  ** mins

- [ ] Added changes to `CHANGELOG.md`
- [ ] Compilation check (model starts without compilation errors - use `gams main.gms action=c` in model folder for testing).
- [ ] No hard coded numbers and cluster/country/region names.
- [ ] The new code doesn't contain declared but unused parameters or variables.
- [ ] Where relevant, In-code comments added including documentation comments.
- [ ] Made sure that documentation created with [`goxygen`](https://github.com/pik-piam/goxygen) is okay (use `goxygen::goxygen()` for testing).
- [ ] Changes to [`magpie4`](https://github.com/pik-piam/magpie4) R library for post processing of model output (ideally backward compatible).
- [ ] Self-review of my own code.
- [ ] In case of updated cellular input tgz file in default.cfg: scenario_config.csv has been updated accordingly (rcp1p9, rcp2p6 etc)
- [ ] For high risk runs: validation of major model indicators - Land-use, emissions, food prices, Tau.  %Delete this line in case it is not a high risk run%
- [ ] In case of updated switches in default.cfg: made sure that all scenario definitions in scenario_config.csv are still available (or updated accordingly).

## :warning: Additional notes or warnings :warning:
NA

## :rotating_light: Checklist for RSE reviewer :rotating_light:

- [ ] PR is labeled correctly.
- [ ] `CHANGELOG` is updated correctly
- [ ] No hard coded numbers and cluster/country/region names.
- [ ] No unnecessary increase in module interfaces
- [ ] All required updates in interfaces (if any) have been properly adressed in the module contracts
- [ ] In-code comments and documentation comments are satisfactory.
- [ ] model behavior/performance is satisfactory.
- [ ] Requested changes (if any) were applied correctly

## :rotating_light: Checklist for MAgPIE reviewer :rotating_light:

- [ ] PR is labeled correctly.
- [ ] `CHANGELOG` is updated correctly
- [ ] No hard coded numbers and cluster/country/region names.
- [ ] Changes to the model are scientifically sound
- [ ] In-code comments and documentation comments are satisfactory.
- [ ] model behavior/performance is satisfactory.
- [ ] Requested changes (if any) were applied correctly
