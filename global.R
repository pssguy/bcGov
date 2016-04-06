library(shiny)
library(shinydashboard)

library(dplyr)
library(readr)
library(stringr)
library(plotly)
library(leaflet)


# fine paticular data - possibly acceptable with one file but not many still 26 - so reduced to summary files - could also do for those only in summary table?

fp_df_date <- readRDS("data/fp_df_date.rds")
fp_df_hour <- readRDS("data/fp_df_hour.rds")
fp_df_month <- readRDS("data/fp_df_month.rds")
fp_sites <- read_csv("data/pm25sitesummary.csv")


# should do when initially creating
fp_df_date <- fp_df_date %>% 
  ungroup()

fp_df_hour <- fp_df_hour %>% 
  ungroup()

fp_df_month <- fp_df_month %>% 
  ungroup()


# glimpse(fp_sites)
sites <- fp_sites %>% 
  filter(metric=="pm2.5_annual") %>% 
  select(ems_id,name=display_name,Longitude,Latitude,value=metric_value) %>% 
  unique(.)

print("global done")