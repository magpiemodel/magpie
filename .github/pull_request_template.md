Please fill following information
(Add additional info if you think its important and not covered by this PR):

## Purpose of this Pull Request (PR)

- Purpose

## Performance loss/gain from current default behavior

- Add an image using plot from `shinyresults::appResults()` and annotate accordingly.

- %performance loss/gain = 100*Runtime from PR/Runtime from current default from develop branch.

## Type of change

- [ ] Bug fix (Change which fixes an issue).
- [ ] New feature (Change which adds functionality).
- [ ] Minor change (Change which does not modify core model code i.e., in /modules).
- [ ] Major change (fix or feature that would change current model behavior).

## How Has This Been Tested?

- [ ] Runs using starting script which tests current defaults (using `test_runs.R`).
- [ ] Runs using starting script which successfully runs the same scenarios as in `test_runs.R` but with the changes from PR.
- [ ] (If applicable) Runs using different scenarios/mappings which are not the default (12 regions/c200 clusters).

## *Additions* or *Changes* to default configuration (default.cfg):
Additions are the introduction of new model components in default config

Changes are deletion or updates to the existing model components in default config

- [ ] Realizations:
- [ ] Scenario switches:
- [ ] Scalars/Constants:
- [ ] Model interfaces:
- [ ] Others:

## Checklist:

- [ ] Self-review of my own code.
- [ ] Added changes to `CHANGELOG.md`
- [ ] No hard coded numbers and cluster/country/region names.
- [ ] The code doesn't contain declared but unused parameters or variables.
- [ ] In-code comments added including documentation comments.
- [ ] Compiled and checked resulting documentation with `goxygen::goxygen()` for the new/updated parts.
- [ ] Changes to `magpie4` R library for post processing of model output (ideally backward compatible).

## Special comments/warnings

- Notes
