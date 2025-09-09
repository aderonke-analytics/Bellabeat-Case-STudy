# R Analysis

This folder contains the R code and outputs used for the Bellabeat case study.

## Files Included
- `fitbit_analysis.R` — main R script (data cleaning, analysis, visualizations).
- `outputs/` — folder containing exported plots (PNG) and any HTML/CSV outputs.
- `requirements.R` — (optional) short script listing packages to install.

## How to run
1. Download the cleaned dataset from: `../data/cleaned_fitbit_data.csv` into this folder (or update the path in the script).
2. Open the project in RStudio / Posit Cloud.
3. Install required packages (if not installed):
```r
install.packages(c("tidyverse", "lubridate", "janitor", "skimr", "ggplot2"))

