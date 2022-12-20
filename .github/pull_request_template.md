## :bird: Description of this PR :bird:

- Briefly explain the purpose of this pull request

## :wrench: Checklist for PR creator :wrench:

- [ ] Label pull request [from the label list](https://github.com/magpiemodel/magpie/labels).
  - **Low risk**: Simple bugfixes (missing files, updated documentation, typos) or changes  in start or output scripts
  - **Medium risk**: Uncritical changes in the model core (e.g. moderate modifications in non-default realizations)
  - **High risk**: Critical changes in model core or default settings (e.g. changing a model default or adjusting a core mechanic in the model)

- [ ] Self-review own code
  - No hard coded numbers and cluster/country/region names.
  - The new code doesn't contain declared but unused parameters or variables.
  - [`magpie4`](https://github.com/pik-piam/magpie4) R library has been updated accordingly and backwards compatible where necessary.
  - `scenario_config.csv` has been updated accordingly (important if `default.cfg` has been updated)

- [ ] Document changes 
  - Add changes to `CHANGELOG.md`
  - Where relevant, put In-code documentation comments
  - Properly address updates in interfaces in the module documentations
  - run [`goxygen::goxygen()`](https://github.com/pik-piam/goxygen) and verify the modified code is properly documented

- [ ] Perform test runs
  - **Low risk**: 
    - Run a compilation check via `Rscript start.R --> "compilation check"`
  - **Medium risk**: 
    - Run test runs via `Rscript start.R --> "test runs"`
    - Check logs for errors/warnings
  - **High risk**:
    - Run test runs via `Rscript start.R --> "test runs"`
    - Check logs for errors/warnings
    - Default run from the PR target branch for comparison
    - Provide relevant comparison plots (land-use, emissions, food prices, land-use intensity,...)

### :chart_with_downwards_trend: Performance changes :chart_with_upwards_trend:
  
  - Current develop branch default : ** mins
  - This PR's default :  ** mins

## :rotating_light: Checklist for reviewer :rotating_light:

- PR is labeled correctly
- Code changes look reasonable
  - No hard coded numbers and cluster/country/region names.
  - No unnecessary increase in module interfaces
  - model behavior/performance is satisfactory.
- Changes are properly documented
  - `CHANGELOG` is updated correctly
  - Updates in interfaces have been properly addressed in the module documentations
  - In-code documentation looks appropriate
- [ ] content review done (at least 1)
- [ ] RSE review done (at least 1)
