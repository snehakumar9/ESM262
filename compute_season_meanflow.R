#' Compute seasonal mean flows
#'
#' This function computes winter and summer flows from a record
#’ @param str data frame with columns month and streamflow 
compute_season_flow = function(str, kind="mean") {
  
  str$season = ifelse( str$month %in% c(1,2,3,10,11,12),"winter","summer")
  
  
  tmp = subset(str, str$season=="winter")
  winter = case_when ( kind =="mean" ~ mean(tmp$streamflow),
                       kind =="max" ~ max(tmp$streamflow),
                       kind =="min" ~ min(tmp$streamflow))

  
  tmp = subset(str, str$season=="summer")
  summer = case_when ( kind =="mean" ~ mean(tmp$streamflow),
                       kind =="max" ~ max(tmp$streamflow),
                       kind =="min" ~ min(tmp$streamflow))
  
  return(list(summer=summer, winter=winter))
}