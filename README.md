
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RecPD

<!-- badges: start -->

<!-- badges: end -->

The RecPD package was developed to calculate the recombination-adjusted
phylogenetic diversity of a given feature (phenotype, variant, etc. in
binary presence/absence format) found across a given species
phylogenetic tree utilizing ancestral state reconstruction.

RecPD also provides functions for:

  - Visualizing feature ancestral lineage reconstructions.
  - Derived measures such as: **nRecPD** (a measure of the degree of
    feature recombination), **Span**, **Clustering**, **Longevity**, and
    **Lability**.
  - **RecPDcor** - a measure of pairwise feature lineage correlation.

For a more detailed description of the RecPD methodology, and its
advantage over using simple Prevalence in measure feature diversity, see
[Bundalovic-Torma C. & Guttman D.
(2021)](https://www.biorxiv.org/content/10.1101/2021.10.01.462747v1).

## Installation

You can install the development version of RecPD from
[GitHub](https://github.com/)

``` r
# install.packages("devtools")
devtools::install_github("DSGlab/recpd")
```

## Tutorial and Usage Examples

See the vignette in the ./vignettes directory.
