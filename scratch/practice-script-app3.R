# load packages ----
library(tidyverse)
library(leaflet)


# read in data ----
filtered_lakes <- read_csv(here::here("shinydashboard", "data", "filtered_lakes_processed.csv"
))

# filter data ----
filtered_lakes <- lake_data |> 
  filter(Elevation >= 8 & Elevation <= 20) |> 
  filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
  filter(AvgTemp >= 4 & AvgTemp <= 6)



# leaflet_map ----
leaflet() |> 
  addProviderTiles(providers$Esri.WorldImagery) |> 
  setView(lng = -152.048442,
          lat = 70.249234,
          zoom = 6) |> 
  addMiniMap(toggleDisplay =TRUE,
             minimized = FALSE) |> 
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude,
             lat = filtered_lakes$Latitude,
             popup = paste0("site name: ", filtered_lakes$Site, "<br>",
                            "elevation: ", filtered_lakes$Elevation,  "meters above sea level", 
                            "<br>",
                            "average depth: ", filtered_lakes$AvgDepth, " meters", 
                            "<br>",
                            "average lake bed temperature: ", 
                            filtered_lakes$AvgTemp, " \u00B0C"))



