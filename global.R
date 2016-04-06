library(shiny)
library(shinydashboard)

library(dplyr)
library(readr)
library(stringr)
library(plotly)
library(leaflet)

# fine paticular data - possibly acceptable with one file but not many still 26
print(Sys.time())
fp_df_date <- readRDS("data/fp_df_date.rds")
fp_df_hour <- readRDS("data/fp_df_hour.rds")
fp_sites <- read_csv("data/pm25sitesummary.csv")
print(Sys.time())


# glimpse(fp_sites)
sites <- fp_sites %>% 
  filter(metric=="pm2.5_annual") %>% 
  select(ems_id,name=display_name,Longitude,Latitude,value=metric_value) %>% 
  unique(.)

print("global done")