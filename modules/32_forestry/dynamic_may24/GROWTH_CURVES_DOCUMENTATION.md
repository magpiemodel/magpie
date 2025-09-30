# Growth Curves Documentation for MAgPIE Forestry Module (dynamic_may24)

## Overview

This document provides comprehensive information about the growth curves used in the MAgPIE forestry module, specifically for the `dynamic_may24` realization. The growth curves determine how carbon density and biomass accumulate over time in plantations and naturally regenerating forests.

## Growth Curve Equations

### 1. Vegetation Carbon Growth (Chapman-Richards Equation)

The primary growth curve for vegetation carbon is the **Chapman-Richards equation**, which produces an S-shaped growth curve:

**Equation:**
```
C_vegc(ac) = S + (A - S) * (1 - exp(-k * (ac * 5)))^m
```

**Where:**
- `C_vegc(ac)` = Carbon density at age-class `ac` (tC/ha)
- `S` = Starting carbon density (tC/ha)
- `A` = Asymptotic (mature) carbon density from LPJmL (tC/ha)
- `k` = Growth rate parameter (dimensionless)
- `m` = Shape parameter (dimensionless)
- `ac` = Age-class index (each age-class represents 5 years)
- `ac * 5` = Age in years

**Implementation:**
- Defined in: `core/macros.gms` (line 18)
- Macro name: `m_growth_vegc(S,A,k,m,ac)`
- Applied in: `modules/52_carbon/normal_dec17/start.gms` (lines 17, 28, 35)

### 2. Litter and Soil Carbon Growth (Linear)

Litter and soil carbon grow linearly over a 20-year period:

**Equation:**
```
C_litter(ac) = start + (end - start) * (ac * 5) / 20     if ac <= 4
C_litter(ac) = end                                       if ac > 4
```

**Where:**
- `start` = Initial litter carbon density (tC/ha)
- `end` = Final litter carbon density (tC/ha)
- `ac` = Age-class index
- 20-year horizon based on IPCC guidelines

**Implementation:**
- Defined in: `core/macros.gms` (line 20)
- Macro name: `m_growth_litc_soilc(start,end,ac)`
- Applied in: `modules/52_carbon/normal_dec17/start.gms` (lines 20, 31, 38)

## Growth Parameters

### Chapman-Richards Parameters

The growth parameters (`k` and `m`) are climate-class specific and differ between forest types:

**Parameter File:** `modules/52_carbon/input/f52_growth_par.csv`

**Forest Types:**
1. **plantations** - Fast-growing timber plantations
2. **natveg** - Natural vegetation regrowth (secondary forests)

**Climate Classes:**
The parameters vary by climate classification (`clcl`) to account for different growth rates in different climates.

**Application:**
```gams
k_plantations = sum(clcl, pm_climate_class(j,clcl) * f52_growth_par(clcl,"k","plantations"))
m_plantations = sum(clcl, pm_climate_class(j,clcl) * f52_growth_par(clcl,"m","plantations"))

k_natveg = sum(clcl, pm_climate_class(j,clcl) * f52_growth_par(clcl,"k","natveg"))
m_natveg = sum(clcl, pm_climate_class(j,clcl) * f52_growth_par(clcl,"m","natveg"))
```

## Carbon Density Application in Forestry Module

### Carbon Density by Forest Type

The forestry module uses these growth curves differently depending on the forestry type:

#### 1. Timber Plantations (`plant`)
```gams
p32_carbon_density_ac(t,j,"plant",ac,ag_pools) = pm_carbon_density_plantation_ac(t,j,ac,ag_pools)
```
- Uses **plantation** growth parameters
- Faster growth rate optimized for timber production
- Location: `modules/32_forestry/dynamic_may24/presolve.gms` (line 59)

#### 2. NPI/NDC Afforestation (`ndc`)
```gams
p32_carbon_density_ac(t,j,"ndc",ac,ag_pools) = pm_carbon_density_secdforest_ac(t,j,ac,ag_pools)
```
- Uses **natveg** (natural vegetation) growth parameters
- Slower, more natural regrowth pattern
- Location: `modules/32_forestry/dynamic_may24/presolve.gms` (line 62)

#### 3. CO2-price Driven Afforestation (`aff`)
```gams
if(s32_aff_plantation = 0):
    p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_secdforest_ac(t,j,ac,ag_pools)
elseif s32_aff_plantation = 1:
    p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_plantation_ac(t,j,ac,ag_pools)
```
- **Switchable** via parameter `s32_aff_plantation`
- Default (`s32_aff_plantation = 0`): Uses natveg growth curve
- Alternative (`s32_aff_plantation = 1`): Uses plantation growth curve
- Location: `modules/32_forestry/dynamic_may24/presolve.gms` (lines 52-56)

## Rotation Length Calculation

The rotation length (harvest age) for plantations is calculated based on growth dynamics:

### Methods for Rotation Calculation

Four methods are available via switch `c32_rot_calc_type`:

#### 1. Current Annual Increment (CAI) - Default
```gams
Harvest when: CAI(ac) - CAI(ac-1) <= 0
```
- Maximizes the annual growth rate
- Harvest when growth rate starts declining
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 50-53)

#### 2. Mean Annual Increment (MAI)
```gams
MAI(ac) = C_vegc(ac) / (ac * 5)
Harvest when: CAI(ac) - MAI(ac) <= 0
```
- Maximizes average growth over plantation lifetime
- Harvest when current growth equals average growth
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 55-59)

#### 3. Instantaneous Growth Rate (IGR) - Regional
```gams
IGR(ac) = dC/dt / C_vegc(ac)
Harvest when: IGR(ac) - regional_interest_rate <= 0
```
- Compares growth rate to regional interest rate
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 40-43)

#### 4. Instantaneous Growth Rate (IGR) - Global
```gams
Harvest when: IGR(ac) - s32_forestry_int_rate <= 0
```
- Uses global interest rate (`s32_forestry_int_rate = 0.05` or 5%)
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 45-48)

### Marginal Carbon Density Calculation

The change in carbon density between age classes:
```gams
p32_carbon_density_ac_marg(t,j,ac) = (C_vegc(ac) - C_vegc(ac-1)) / 5
```
- Represents annual increment in tC/ha/year
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 22-24)

### Instantaneous Growth Rate (IGR)

```gams
IGR(t,j,ac) = dC/dt / C_vegc(ac)
           = p32_carbon_density_ac_marg(t,j,ac) / p32_carbon_density_ac_forestry(t,j,ac)
```
- Proxy for investment return rate
- Location: `modules/32_forestry/dynamic_may24/preloop.gms` (lines 31-32)

## Key Parameters and Switches

### Input Parameters (`modules/32_forestry/dynamic_may24/input.gms`)

| Parameter | Default | Description |
|-----------|---------|-------------|
| `s32_aff_plantation` | 0 | Afforestation growth curve: 0=natveg, 1=plantation |
| `s32_rotation_extension` | 1 | Rotation extension factor (1=original, 2=double) |
| `s32_forestry_int_rate` | 0.05 | Global interest rate for IGR method (5%) |
| `s32_price` | 55 | Timber price (USD17MER per tC) |
| `s32_planning_horizon` | 50 | Planning horizon for afforestation (years) |

### Switch for Rotation Calculation (`input.gms` line 15)

```gams
$setglobal c32_rot_calc_type  current_annual_increment
```

Options:
- `current_annual_increment` (default)
- `mean_annual_increment`
- `instantaneous_growth_rate_reg`
- `instantaneous_growth_rate_glo`

## Faustmann Rotation (Optional)

An economically optimal rotation accounting for land rent:

```gams
Harvest when: IGR(ac) <= interest_rate + land_rent_weighted(ac)
```

Where:
```gams
land_rent_weighted(ac) = (interest * NPV(ac)) / stand_value(ac)
NPV(ac) = (price * C_vegc(ac) * discount(ac)) / (1 - discount(ac))
discount(ac) = 1 / exp(interest * ac * 5)
```

**Switch:** `s32_faustmann_rotation` (0=off, 1=on, default=0)

**Location:** `modules/32_forestry/dynamic_may24/preloop.gms` (lines 64-82)

## Age-Class Structure

- Age-classes are indexed by `ac` (ac0, ac5, ac10, ..., acx)
- Each age-class except `ac0` represents a 5-year period
- `ac0` = establishment year
- `acx` = final age-class for mature forests (>100 years)
- Age in years = `(ord(ac) - 1) * 5`

## Data Sources

### Climate and Carbon Density Data
- **LPJmL Output:** `modules/52_carbon/input/lpj_carbon_stocks.cs3`
- Provides asymptotic carbon densities (`A` parameter)
- Climate-responsive projections over time

### Growth Parameters
- **File:** `modules/52_carbon/input/f52_growth_par.csv`
- **Source:** Based on Braakhekke et al. 2019
- Climate-class specific parameters for `k` and `m`

## References

### Key Papers
1. **Braakhekke et al. (2019):** Parametrization of S-shaped growth curves for vegetation regrowth
2. **Amacher et al. (2009):** Economics of rotation length calculations
3. **Humpenöder et al. (2014):** Implementation of afforestation in MAgPIE
4. **Mishra et al. (2021):** Forestry dynamics in MAgPIE

### Documentation
- **Realization Description:** `modules/32_forestry/dynamic_may24/realization.gms` (lines 8-32)
- **Growth Curve Application:** `modules/52_carbon/normal_dec17/start.gms`
- **Rotation Calculation:** `modules/32_forestry/dynamic_may24/preloop.gms`
- **Carbon Assignment:** `modules/32_forestry/dynamic_may24/presolve.gms`

## Summary of File Locations

| Component | File | Lines |
|-----------|------|-------|
| Chapman-Richards macro | `core/macros.gms` | 18 |
| Litter growth macro | `core/macros.gms` | 20 |
| Growth parameter input | `modules/52_carbon/normal_dec17/input.gms` | 37-43 |
| Growth curve application | `modules/52_carbon/normal_dec17/start.gms` | 16-38 |
| Rotation calculation | `modules/32_forestry/dynamic_may24/preloop.gms` | 16-131 |
| Carbon density assignment | `modules/32_forestry/dynamic_may24/presolve.gms` | 48-62 |
| Input parameters | `modules/32_forestry/dynamic_may24/input.gms` | 21-50 |
| Realization description | `modules/32_forestry/dynamic_may24/realization.gms` | 8-32 |

## Notes

1. The growth curves are parametrized to match empirical forest growth data
2. Plantation growth curves are generally faster than natural vegetation regrowth
3. Climate change affects the asymptotic carbon density (`A`) over time through LPJmL projections
4. The actual growth parameters (`k`, `m`) remain constant but are climate-class specific
5. Age-class shifts occur according to timestep length (typically 5 years per timestep)
