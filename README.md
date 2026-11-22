Author: Za'Kiya Toomer-Sanders
Date: 11/22/2026
Project 2: Air Quality Data Processing and Visualization

This project analyzes air quality data from 2018, 2019, and 2020 containing measurements of carbon monoxide (CO), particulate matter (PM2.5), and ozone (O₃). The data were cleaned, combined, summarized, and visualized to examine yearly and seasonal patterns in pollutant concentrations.

Data are from the EPA monitor at Raleigh-Durham International (RDU) airport:
The 2018 and 2019 datasets contain nearly complete years of observations, while the 2020 dataset contains 121 daily observations. As a result, patterns observed for 2020 should be interpreted with caution because fewer observations were available compared to the other years.

File Information:
AQ_2018.csv - Air quality data for 2018.
AQ_2019.csv - Air quality data for 2019.
AQ_2020.csv - Air quality data for 2020.

Project2.Rmd - R Markdown file containing all code, tables, plots, and written interpretations.
README.md - Description of project files and processing steps.

Function Description:
The process_air_quality() function was created to clean and process each yearly air quality dataset. The function:

Imports the data from the CSV files.
Renames pollutant variables to shorter names (CO, PM25, and O3).
Converts the date variable to date format (month, day, year).
Removes duplicate records.
Replaces negative pollutant concentrations with zero.
Averages observations recorded on the same day.
Returns a cleaned dataset containing one row per day.

How to Reproduce the Analysis:

Download the project files, including Project2.Rmd, AQ_2018.csv, AQ_2019.csv, and AQ_2020.csv, and save them in the same working directory.
Open Project2.Rmd in RStudio.

Install and load the required packages: tidyverse, lubridate, and gt.
Run the code in the R Markdown file from beginning to end. The process_air_quality() function will clean each dataset by renaming variables, converting dates, removing duplicates, replacing negative values with zero, and averaging multiple observations recorded on the same day.
The cleaned datasets are combined into a single dataset and used to generate summary tables and visualizations.
Knit the R Markdown file to produce the final report containing the tables, plots, and interpretations.
