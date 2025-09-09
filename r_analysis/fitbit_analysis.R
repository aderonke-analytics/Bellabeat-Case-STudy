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
fitbit_data <- read_csv("../data/clean_master_sheet - master.csv")

# 3. Inspect data
skim_without_charts(fitbit_data)

# 4. Convert date column if needed
fitbit_data <- fitbit_data %>%
  mutate(activity_date = mdy(activity_date_new))  

# 5. Summary statistics
avg_steps <- mean(fitbit_data$total_steps, na.rm = TRUE)
avg_sleep_hours <- mean(fitbit_data$total_minutes_asleep / 60, na.rm = TRUE)
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
p_steps_calories <- ggplot(fitbit_data, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "Steps vs Calories", x = "Steps", y = "Calories")

# 8. Sleep hours histogram
p_sleep <- ggplot(fitbit_data, aes(x = total_minutes_asleep / 60)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "white") +
  labs(title = "Sleep Hours Distribution", x = "Sleep Hours (per night)", y = "Count")

# 9. Active minutes breakdown over time
p_active <- fitbit_data %>%
  group_by(activity_date) %>%
  summarise(
    very_active = mean(very_active_minutes, na.rm = TRUE),
    fairly_active = mean(fairly_active_minutes, na.rm = TRUE),
    lightly_active = mean(lightly_active_minutes, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(very_active, fairly_active, lightly_active),
               names_to = "activity_level", values_to = "minutes") %>%
  ggplot(aes(x = activity_date, y = minutes, fill = activity_level)) +
  geom_col() +
  labs(title = "Daily Active Minutes Breakdown", x = "Date", y = "Minutes")

# 10. Save charts
if (!dir.exists("r_analysis/outputs")) dir.create("r_analysis/outputs")
ggsave("r_analysis/outputs/steps_vs_calories.png", p_steps_calories, width = 7, height = 5)
ggsave("r_analysis/outputs/sleep_distribution.png", p_sleep, width = 7, height = 5)
ggsave("r_analysis/outputs/active_minutes_breakdown.png", p_active, width = 10, height = 6)
