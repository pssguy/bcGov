library(shiny)
library(shinydashboard)

library(dplyr)
library(readr)
library(stringr)
library(plotly)
library(leaflet)


# fine paticular data - possibly acceptable with one file but not many still 26 - so reduced to summary files - could #also do for those only in summary table?

fp_df_date <- readRDS("data/fp_df_date.rds")
fp_df_hour <- readRDS("data/fp_df_hour.rds")
fp_df_month <- readRDS("data/fp_df_month.rds")
fp_sites <- read_csv("data/pm25sitesummary.csv")
ozone_sites <- read_csv("data/ozonesitesummary.csv") 


# should do when initially creating
fp_df_date <- fp_df_date %>% 
  ungroup()

fp_df_hour <- fp_df_hour %>% 
  ungroup()

fp_df_month <- fp_df_month %>% 
  ungroup()

ozone_df_date <- readRDS("data/ozone_df_date.rds")
ozone_df_hour <- readRDS("data/ozone_df_hour.rds")
ozone_df_month <- readRDS("data/ozone_df_month.rds")


# glimpse(fp_sites)
fp_sites <- fp_sites %>% 
  filter(metric=="pm2.5_annual") %>% 
  select(ems_id,name=display_name,Longitude,Latitude,value=metric_value) %>% 
  unique(.)


ozone_sites <- ozone_sites %>% 
  select(ems_id,name=station_name,Longitude=longitude,Latitude=latitude,value=caaq_metric) %>% 
  unique(.)

print("global done")