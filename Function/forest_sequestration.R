forest_sequestration <- function(tree_density=NULL, avg_diameter=NULL, avg_height=NULL,
                                      carbon_fraction = 0.5, bm_conversion_factor = 0.1, growth_rate = 0.03,tree_data=NULL){ 
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
  
  # If raw tree data is provided by user, calculate the averages and density.
  if (!is.null(tree_data)) {
    avg_diameter <- mean(tree_data$diameter, na.rm = TRUE)
    avg_height   <- mean(tree_data$height, na.rm = TRUE)
  
  
  
  
  
  # Combine tree dimensions into single variable for clarity / modularity
  tree_dimensions <- avg_diameter * avg_height
  
  # Estimate biomass per tree based on combined tree dimensions
  biomass_per_tree <- bm_conversion_factor * tree_dimensions
  
  # Total biomass per hectare (in tons)
  total_biomass <- tree_density * biomass_per_tree
  
  # Annual forest carbon sequestration: (growth-related biomass increase) * (carbon fraction)
  annual_sequestration <- total_biomass * growth_rate * carbon_fraction
  
  # Return both outputs as a list
  return(list(annual_sequestration = annual_sequestration, total_biomass = total_biomass))


# Example usage (given some values):
result2 <- forest_sequestration(tree_density = 500, avg_diameter = 30, avg_height = 10)
print(result2)
}
