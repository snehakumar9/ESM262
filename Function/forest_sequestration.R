

forest_sequestration <- function(tree_density=300,
                                 diameter,
                                 height,
                                 carbon_fraction = 0.5,
                                 bm_conversion_factor = 0.1,
                                 growth_rate = 0.03){
  #ensure valid ranges
  invalid_diameter <- diameter < 0 #diameter can't be negative
  
  invalid_height <- height < 0 #height can't be negative
  
  if(any(invalid_diameter)) {
    stop("Invalid diameter value")
  }
  
  if(any(invalid_height)) {
    stop("Invalid height value")
  }
  
  #Vectorized forest sequestration calculation
  FtSn <- tree_density * (pi * (diameter/2)^2) * height * carbon_fraction * bm_conversion_factor * growth_rate
  
  
  return(FtSn)
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
result2 <- forest_sequestration(tree_density = 300, diameter = 30, height = 10)
print(result2)
}

#running function for each value in parameters with pmap
ftsn2 = pmap(list(diameter = tree_data$diameter, height = tree_data$height), forest_sequestration)


