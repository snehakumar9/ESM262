

forest_sequestration <- function(tree_density=NULL,
                                 avg_diameter=NULL,
                                 avg_height=NULL,
                                 carbon_fraction = 0.5,
                                 bm_conversion_factor = 0.1,
                                 growth_rate = 0.03,
                                 tree_data=NULL){
  return(list(annual_sequestration = annual_sequestration,
              total_biomass = total_biomass))
  # Documentation:
  # note: setting some values as NULL initially, in case there is a raw data table we use to compute those values first!
  # > if not given the raw data table with necessary columns to compute these values, apply given values for each 
  # note: using metrics and decimals
  # tree_density: number of trees per hectare
  # avg_diameter: average tree diameter (in cm)
  # avg_height: average tree height (in m)
  # carbon_fraction: fraction of biomass that's carbon (on avg, 50% carbon composition for diff tree parts)
  # bm_conversion_factor: factor to convert tree dimensions (avg diameter and height) to biomass (in tons per tree)
  # > note: conversion factor varies / dependent on group of trees studied, not universal.
  # > placeholder value of 0.1 (midpoint for some studies of California trees - ranging from 0.05 to 0.15)
  # > would switch out depending on your data, and found using allometric modeling)
  # growth_rate: annual growth rate (as a decimal)
  # > note: according to US Forest Service (2021 report), it stands on avg at 3%. (0.03 in decimal)
  # Return both outputs as a list
  
# Example usage (given some values):
result2 <- forest_sequestration(tree_density = 500, avg_diameter = 30, avg_height = 10)
print(result2)
}
