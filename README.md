# R package ggAVplots
 
Added variable plots are extremely convenient for intereting
the effect of a variable in statistical linear models where the
covariates are correlated. The most common packages for 
visuallizing these don't work for random effect models,
nor provide a ggplot2 interface, which allows for easier
editing of the graph.

This package aims to address that need. I'm open to any and all
collaboration to improve the package.

## To do:
1.  Create an `ggAVplots()` function that will generate a grid
    of graphs, 1 for each covariate.
2.  Provide functionality for transformed covariates, such as
    a sqrt() transformed x-variable or a gam() smoothed variable.
