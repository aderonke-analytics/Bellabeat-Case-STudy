# R Analysis

This folder contains the R code and outputs used for the Bellabeat case study.

## Files Included
- `fitbit_analysis.R` — main R script (data cleaning, analysis, visualizations).
- `outputs/` — folder containing exported plots (PNG) and any HTML/CSV outputs.
- `requirements.R` — (optional) short script listing packages to install.

## How to run
1. Download the cleaned dataset from: [clean fitbit sheet](https://github.com/aderonke-analytics/Bellabeat-Case-STudy/blob/3cbc689779ecca674efee677f1884399767bf25d/data/clean_master_sheet%20-%20master.csv)
2. Open the project in RStudio / Posit Cloud.
3. Install required packages (if not installed):
```r
install.packages(c("tidyverse", "lubridate", "janitor", "skimr", "ggplot2"))

