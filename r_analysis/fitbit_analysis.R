# fitbit_analysis.R
# Bellabeat Case Study – R Analysis Script
# Author: Aderonke
# Date: 9th September, 2025

# 1. Load required libraries
library(tidyverse)
library(lubridate)
library(janitor)
library(skimr)

# 2. Load cleaned data
fitbit_data <- read_csv("clean_master_sheet - master.csv")

# 3. Inspect data
skim_without_charts(fitbit_data)

# 4. Convert date column if needed
fitbit_data <- fitbit_data %>%
  mutate(activity_date = ymd(ActivityDate))  

# 5. Summary statistics
avg_steps <- mean(fitbit_data$TotalSteps, na.rm = TRUE)
avg_sleep_hours <- mean(fitbit_data$minutes_asleep / 60, na.rm = TRUE)
cat("Average Daily Steps:", round(avg_steps,2), "\n")
cat("Average Sleep Hours:", round(avg_sleep_hours,2), "\n")

# 6. Weekday vs Weekend steps
fitbit_data <- fitbit_data %>%
  mutate(day_of_week = wday(activity_date, label = TRUE),
         day_type = if_else(day_of_week %in% c("Sat", "Sun"), "Weekend", "Weekday"))
steps_by_day_type <- fitbit_data %>%
  group_by(day_type) %>%
  summarise(avg_steps = mean(total_steps, na.rm = TRUE))
print(steps_by_day_type)

# 7. Steps vs Calories scatter plot
ggplot(fitbit_data, aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.5, color = "blue") +     # scatter points
  geom_smooth(method = "lm", color = "red") +   # add trend line (linear regression)
  labs(
    title = "Steps vs Calories",
    x = "Total Steps",
    y = "Calories Burned"
  ) +
  theme_minimal()

# 8. Sleep hours histogram
ggplot(fitbit_data, aes(x = minutes_asleep / 60)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "white") +
  labs(
    title = "Distribution of Sleep Hours",
    x = "Sleep Hours (per day)",
    y = "Count of Days"
  ) +
  theme_minimal()

# 9. Active minutes breakdown over time
library(dplyr)
library(tidyr)
library(ggplot2)

# Summarize daily averages of active minutes
p_active <- fitbit_data %>%
  group_by(activity_date) %>%
  summarise(
    very_active = mean(VeryActiveMinutes, na.rm = TRUE),
    fairly_active = mean(FairlyActiveMinutes, na.rm = TRUE),
    lightly_active = mean(LightlyActiveMinutes, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(very_active, fairly_active, lightly_active),
               names_to = "activity_level", values_to = "minutes") %>%
  ggplot(aes(x = activity_date, y = minutes, fill = activity_level)) +
  geom_col(position = "stack") +
  labs(
    title = "Daily Active Minutes Breakdown",
    x = "Date",
    y = "Minutes"
  ) +
  theme_minimal()

# Show the plot
print(p_active)

# 10. Save charts

ggsave("r_analysis/outputs/steps_vs_calories.png", p_steps_calories, width = 7, height = 5)
ggsave("r_analysis/outputs/sleep_distribution.png", p_sleep, width = 7, height = 5)
ggsave("r_analysis/outputs/active_minutes_breakdown.png", p_active, width = 10, height = 6)
