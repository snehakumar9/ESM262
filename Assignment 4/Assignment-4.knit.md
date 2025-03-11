---
title: "Assignment 4"
author: "Sneha Kumar and Temesgen"
date: "2025-03-10"
output:
  pdf_document: default
  html_document: default
---

# Assignment 4

For this assignment you will write a new Quartro document based on the analysis of power required for different *possible_cars* from looping.RMD; You will

Load Function


``` r
library(here)
```

```
## here() starts at C:/Users/sneha/Documents/ESM262/ESM262
```

``` r
source("~/ESM262/ESM262/autopower.R")
```

Add an additional super light car with mass 5,000 kg and a surface area 10m2


``` r
possible_cars <- data.frame(name=c("A","B","C","New"), mass=c(10000,65000,38000,5000), area=c(22,30,22,10))
possible_cars$power=autopower(V=28, A=possible_cars$area, m=possible_cars$mass)
print(possible_cars)
```

```
##   name  mass area    power
## 1    A 10000   22 128089.9
## 2    B 65000   30 386080.8
## 3    C 38000   22 243337.9
## 4  New  5000   10  60093.6
```

Compute the mean and maximum power for Cars A, B, C and for your new car, assuming that average highway speed is 80 km/hr with a standard deviation of 10km/hr


``` r
nsample = 200
meanspeed_meters = 80*0.277
speeds = rnorm(mean=meanspeed_meters, sd=10, nsample)
summary(speeds)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -2.532  15.742  23.109  22.621  28.744  47.088
```

The mean speed is 22.812 km/hr and the max speed is 53.933 km/hr.


``` r
possible_cars$maxpower = autopower(V=summary(speeds)['Max.'], A=possible_cars$area, m=possible_cars$mass)
possible_cars$meanpower = autopower(V=summary(speeds)['Mean'], A=possible_cars$area, m=possible_cars$mass)
print(possible_cars)
```

```
##   name  mass area    power  maxpower meanpower
## 1    A 10000   22 128089.9  482669.3  79093.83
## 2    B 65000   30 386080.8 1013720.5 278656.49
## 3    C 38000   22 243337.9  676483.1 172203.19
## 4  New  5000   10  60093.6  222541.5  37463.25
```

Use 2 different methods to compute the mean and maximum power for each car type a) **FOR** loop


``` r
df_forloop <- as.data.frame(matrix(nrow=length(speeds), ncol=nrow(possible_cars)))
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

``` r
df_forloop <- df_forloop |>
  rename(A=V1, B=V2, C=V3, New=V4)

for (i in 1:ncol(df_forloop)) {
  df_forloop[,i] = autopower(A=possible_cars$area[i], m=possible_cars$mass[i], V=speeds)
}

View(df_forloop)
```


``` r
meanvalues_forloop <- sapply(df_forloop, mean)
maxvalues_forloop <- sapply(df_forloop,max)
print(meanvalues_forloop)
```

```
##         A         B         C       New 
## 101504.76 309216.85 194614.12  47650.04
```

``` r
print(maxvalues_forloop)
```

```
##         A         B         C       New 
##  482669.3 1013720.5  676483.1  222541.5
```

b)  the **pmap** function from **purr**


``` r
library(purrr)
```

```
## Warning: package 'purrr' was built under R version 4.4.2
```

``` r
df_pmap <- as.data.frame(pmap(list(A = possible_cars$area, m=possible_cars$mass), autopower, V=speeds))

colnames(df_pmap) <- c("A", "B", "C", "New")

View(df_pmap)

meanvalues_pmap <- sapply(df_pmap, mean)
maxvalues_pmap <- sapply(df_pmap,max)
print(meanvalues_pmap)
```

```
##         A         B         C       New 
## 101504.76 309216.85 194614.12  47650.04
```

``` r
print(maxvalues_pmap)
```

```
##         A         B         C       New 
##  482669.3 1013720.5  676483.1  222541.5
```

Create two boxplots (one for each method (**FOR** and **pmap**)) that show the range of power consumption (across sampled speeds) for each car type.


``` r
library(tidyverse)
```

```
## Warning: package 'lubridate' was built under R version 4.4.2
```

```
## -- Attaching core tidyverse packages ------------------------ tidyverse 2.0.0 --
## v forcats   1.0.0     v stringr   1.5.1
## v ggplot2   3.5.1     v tibble    3.2.1
## v lubridate 1.9.4     v tidyr     1.3.1
## v readr     2.1.5     
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
## i Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
forlooppivot <- df_forloop |>
  pivot_longer(cols = everything(), names_to = "type", values_to = "power")
forlooppivot
```

```
## # A tibble: 800 x 2
##    type    power
##    <chr>   <dbl>
##  1 A       9972.
##  2 B      60072.
##  3 C      35306.
##  4 New     4944.
##  5 A      32657.
##  6 B     152613.
##  7 C      91576.
##  8 New    15801.
##  9 A     247277.
## 10 B     613249.
## # i 790 more rows
```

``` r
pmappivot <- df_pmap |>
  pivot_longer(cols = everything(), names_to = "type", values_to = "power")
pmappivot
```

```
## # A tibble: 800 x 2
##    type    power
##    <chr>   <dbl>
##  1 A       9972.
##  2 B      60072.
##  3 C      35306.
##  4 New     4944.
##  5 A      32657.
##  6 B     152613.
##  7 C      91576.
##  8 New    15801.
##  9 A     247277.
## 10 B     613249.
## # i 790 more rows
```

``` r
library(ggplot2)
plot_forloop <- ggplot(data = forlooppivot) +
  geom_boxplot(aes(type, power, fill=type)) + 
  ggtitle("For Loop Boxplots")

plot_pmap <- ggplot(data = pmappivot) +
  geom_boxplot(aes(type, power, fill=type)) + 
  ggtitle("Pmap Boxplots")

library(ggpubr)
```

```
## Warning: package 'ggpubr' was built under R version 4.4.3
```

``` r
ggarrange(plot_forloop, plot_pmap)
```

![](Assignment-4_files/figure-latex/unnamed-chunk-8-1.pdf)<!-- --> 

Put the Quatro in your assignment github and submit a link on Canvas for Assignment 4 when its ready to be graded
