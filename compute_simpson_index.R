#' Simpson's Species Diversity Index
#'
#' Compute a species diversity index
#' @param species list of species (names, or code)
#' @return value of Species Diversity Index
#' @examples
#' compute_simpson_index(c("butterfly","butterfly","mosquito","butterfly","ladybug","ladybug")))
#' @references
#' http://www.tiem.utk.edu/~gross/bioed/bealsmodules/simpsonDI.html

compute_simpson_index = function(species) {

species = as.factor(species)

summary_species = summary(species)
diversity=0
N = length(species)
for (i in 1:length(summary_species)) {
   diversity = diversity + (summary_species[i]/N)**2
}
diversity = 1-diversity
return(diversity)
}


