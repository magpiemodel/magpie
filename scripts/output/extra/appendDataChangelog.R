years <- c(2050, 2100)
variables <- c(
  lucEmis = "Emissions|CO2|Land|+|Land-use Change", # +++++
  tau = "Productivity|Landuse Intensity Indicator Tau", # +++++
  cropland = "Resources|Land Cover|+|Cropland", # ++++++
  irrigated = "Resources|Land Cover|Cropland|Area actually irrigated", # +++
  pasture = "Resources|Land Cover|+|Pastures and Rangelands", # ++++
  forest = "Resources|Land Cover|+|Forest", # +++
  other = "Resources|Land Cover|+|Other Land", # ++
  production = "Production", # +++ (in contrast to all other indicators here, this should be robust to calibration issues, but indicate changes in demand/trade)
  costs = "Costs", # ++
  foodExp = "Household Expenditure|Food|Expenditure" # +
)
roundDigits <- 2
maxEntries <- 15
changelog <- "../../data-changelog.csv"

id <- commandArgs(trailingOnly = TRUE)
if (length(id) == 0) {
  load("runstatistics.rda")
  id <- format(stats$date, "%Y-%m-%d")
}

r <- readRDS("report.rds")

x <- r[r$region == "World"
       & r$variable %in% variables
       & r$period %in% years,
       c("variable", "period", "value")]
notFound <- setdiff(variables, x$variable)
if (length(notFound) > 0) {
  warning("No data-changelog data found for ", paste(notFound, collapse = ", "))
}

# shorten variable names
variableNames <- names(variables)
names(variableNames) <- variables
x$variable <- variableNames[as.character(x$variable)]

colnames(x)[ncol(x)] <- id

out <- data.frame(version = setdiff(colnames(x), c("variable", "period")))
for (variableName in variableNames) {
  for (year in years) {
    newColumn <- x[x$variable == variableName & x$period == year, 3]
    newColumn <- round(newColumn, roundDigits)
    out <- cbind(out, newColumn)
    colnames(out)[ncol(out)] <- paste0(variableName, year)
  }
}

if (file.exists(changelog)) {
  out <- rbind(out, read.csv(changelog))
  out <- out[seq_len(min(maxEntries, nrow(out))), ]
}
write.csv(out, changelog, quote = FALSE, row.names = FALSE)
