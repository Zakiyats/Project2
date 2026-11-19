# Za'Kiya Toomer-Sanders
# Project 2


# -------------------------------------------------------------------------

# 1. Load packages
library(tidyverse)
library(lubridate)
library(gt)




# -------------------------------------------------------------------------

# 2. Create processing function

# process_air_quality()
#
# Reads a yearly air quality file and returns a
# cleaned data frame with one row per day.
#
# Arguments:
#   file = location of csv file
#   ozone_unit = "ppm" (default) or "ppb"
#
# Returns:
#   Clean tibble of daily pollutant measurements
#---------------------------------------------------

process_air_quality <- function(file,
                                ozone_unit = "ppm") {
  
  air <- read_csv(file,
                  show_col_types = FALSE)
  
  air_clean <- air %>%
    
    rename(
      CO = `Daily Max 8-hour CO Concentration`,
      PM25 = `Daily Mean PM2.5 Concentration`,
      O3 = `Daily Max 8-hour Ozone Concentration`
    ) %>%
    
    mutate(
      Date = mdy(Date)
    ) %>%
    
    distinct()
  
  pollutants <- c("CO", "PM25", "O3")
  
  for(var in pollutants){
    
    air_clean[[var]] <- ifelse(
      air_clean[[var]] < 0,
      0,
      air_clean[[var]]
    )
  }
  
  air_clean <- air_clean %>%
    
    group_by(Date) %>%
    
    summarise(
      CO = ifelse(all(is.na(CO)), NA, mean(CO, na.rm = TRUE)),
      PM25 = ifelse(all(is.na(PM25)), NA, mean(PM25, na.rm = TRUE)),
      O3 = ifelse(all(is.na(O3)), NA, mean(O3, na.rm = TRUE)),
      .groups = "drop"
    )
  
  if(ozone_unit == "ppb"){
    
    air_clean <- air_clean %>%
      mutate(O3 = O3 * 1000)
    
  }
  
  return(air_clean)
}



# -------------------------------------------------------------------------

# 3. Process each dataset

aq2018 <- process_air_quality("AQ_2018.csv")

aq2019 <- process_air_quality("AQ_2019.csv")

aq2020 <- process_air_quality("AQ_2020.csv")


# -------------------------------------------------------------------------


# 4. Combine datasets


# Add year variable 
aq2018 <- aq2018 %>%
  mutate(Year = 2018)

aq2019 <- aq2019 %>%
  mutate(Year = 2019)

aq2020 <- aq2020 %>%
  mutate(Year = 2020)


# combine data 
aq_all <- bind_rows(
  aq2018,
  aq2019,
  aq2020
)


# Add month labels  
aq_all <- aq_all %>%
  mutate(
    Month = month(Date),
    Month_Name = month(Date,
                       label = TRUE,
                       abbr = TRUE)
  )


# Checking table contents

glimpse(aq_all)

# 5. Create yearly summary tables

create_summary_table <- function(data, year_label){
  
# Find min and max of CO, PM2.5, and O3
  data %>%
    summarise(
      `CO Min (ppm)` = min(CO, na.rm = TRUE),
      `CO Max (ppm)` = max(CO, na.rm = TRUE),
      
      `PM2.5 Min (ug/m3)` = min(PM25, na.rm = TRUE),
      `PM2.5 Max (ug/m3)` = max(PM25, na.rm = TRUE),
      
      `O3 Min (ppm)` = min(O3, na.rm = TRUE),
      `O3 Max (ppm)` = max(O3, na.rm = TRUE)
    ) %>%
  
  # Produce cleaner table format 
    pivot_longer(
      everything(),
      names_to = "Measure",
      values_to = "Value"
    ) %>%
    
    gt() %>%
    
  # Rounding decimals 
  
    fmt_number(
      columns = Value,
      decimals = 3
    ) %>%
    
    tab_header(
      title = paste(
        "Minimum and Maximum Daily Pollutant Concentrations:",
        year_label
      )
    )
}



# Create tables for all 3 measurements 

table2018 <- create_summary_table(
  filter(aq_all, Year == 2018),
  "2018"
)

table2019 <- create_summary_table(
  filter(aq_all, Year == 2019),
  "2019"
)

table2020 <- create_summary_table(
  filter(aq_all, Year == 2020),
  "2020"
)


table2018

table2019

table2020


# 6. Create Plot 1

# 7. Create Plot 2

# 8. Interpretation

# 9. AI Use Statement