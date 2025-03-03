# Function of Global Warming Potential

# Description
# Summary: The global warming potential (GWP) of a greenhouse gas is a measure of how
# much heat a particular gas traps in the atmosphere relative to carbon dioxide (CO2).
# This function allows us to calculate the GWP of carbon dioxide, given the concentration of CO2 in the atmosphere

# This function has multiple inputs, including the following variables:
# @param C is the concentration of the gas in the atmosphere (in units of mass per volume)
# @param RF is the radiative forcing of the gas (W/m2), and
# @param CO2RF is the radiative forcing of carbon dioxide (in W/m2)
# This is calculated to be 2.286 in 2023

# @return GWP - the global warming potential of a greenhouse gas

gwp_function <- function(c, rf, CO2_rf = 2.286)
                {GWP = (c*rf)/CO2_rf
                ifelse(c<0,NA,return(GWP))}

# @references
# https://abhilashshukla.com/climate-and-environment/climate-change/formulas-and-equations-used-to-calculate-change-in-climate/
# https://gml.noaa.gov/aggi/aggi.html 