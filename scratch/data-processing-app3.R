#...............................................................................
#                                                                              .
#  For simplicity, I've removed all rows with missing values (i.e. `NaN`s      .
#  in the `Depth` column & `NA`s in the `BedTemperature` column) before        .
#  calculating averages. However, exploring and  thinking critically about     .
#  missing data is an important part of data analysis, and in a real-life      .
#  scenario, you should consider the most appropriate method for handling them .
#                                                                              .
#...............................................................................

#....................SETUP & DATA PROCESSING.....................

# load packages ----
library(tidyverse)

# read in raw data ----
lake_raw <- read_csv(here::here("raw-data", "FCWO_lakemonitoringdata_2011_2022_daily.csv"))

# calculate avg depth & temp ----
avg_depth_temp <- lake_raw |> 
  select(Site, Depth, BedTemperature) |> 
  filter(Depth != "NaN") |>  # remove NaN ("not a number") from Depth
  drop_na(BedTemperature) |> # remove NAs (missing data) from BedTemperature
  group_by(Site) |> 
  summarize(
    AvgDepth = round(mean(Depth), 1),
    AvgTemp = round(mean(BedTemperature), 1)
  )

# join avg depth & temp to original data (match rows based on 'Site') ---
joined_dfs <- full_join(lake_raw, avg_depth_temp)

# get unique lakes observations (with corresponding lat, lon, elev, avgDepth, avgTemp) for mapping ----
unique_lakes <- joined_dfs |> 
  select(Site, Latitude, Longitude, Elevation, AvgDepth, AvgTemp) |> 
  distinct()

# save processed data to your app's data directory ----
write_csv(x = unique_lakes, file = here::here("shinydashboard", "data", "lake_data_processed.csv"))
