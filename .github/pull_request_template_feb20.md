## :bird: Purpose of this PR :bird:

- MAgPIE bird asks you to briefly describe why this pull request is made

## :wrench: Type of change :wrench:

Label your pull request accordingly [from the label list](https://github.com/magpiemodel/magpie/labels).

- [ ] Low risk
  - [ ] Simple bugfixes (missing files, updated documentation, typos) or
  - [ ] Start/output scripts
- [ ] Medium risk  
  - [ ] New realization
  - [ ] Changes to existing realization
  - [ ] Other changes which don't modify default.cfg
- [ ] High risk
  - [ ] New input files (if cfg$input is changed in default.cfg)
  - [ ] Modification to core model (eg. changes in equations, calculations, introduction of new sets etc.)
  - [ ] Other changes in default.cfg

## :key: Model run prerequisites :key:

- [ ] Low risk : No new model run needed.
- [ ] Medium risk : Default run based on the current version of the fork from which PR is made
- [ ] High risk
  - [ ] Default run from the current develop branch
  - [ ] Default run based on the current version of the fork from which PR is made

## :chart_with_downwards_trend: Performance loss/gain from current default behavior :chart_with_upwards_trend:

- For high risk PR's : Comparison of run time between current develop and PR runs.


## :rotating_light: Checklist :rotating_light:

- [ ] Added changes to `CHANGELOG.md`
- [ ] Compilation check (model starts without compilation errors - use `gams main.gms action=c` in model folder for testing).
- [ ] No hard coded numbers and cluster/country/region names.
- [ ] The code doesn't contain declared but unused parameters or variables.
- [ ] In-code comments added including documentation comments.
- [ ] Compiled and checked resulting documentation with [`goxygen`](https://github.com/pik-piam/goxygen) for the new/updated parts (use `goxygen::goxygen()` for testing).
- [ ] Changes to [`magpie4`](https://github.com/pik-piam/magpie4) R library for post processing of model output (ideally backward compatible).
- [ ] Self-review of my own code.
- [ ] For high risk runs: validation of major model indicators - Land-use, emissions, food prices, Tau.

## :warning: Special comments/warnings :warning:

- Notes
