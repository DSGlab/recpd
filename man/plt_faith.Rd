% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tree_plots.R
\name{plt_faith}
\alias{plt_faith}
\title{Plot feature Faith's PD ancestral lineages onto a species phylogenetic tree.}
\usage{
plt_faith(res, feat, include.root = TRUE)
}
\arguments{
\item{res}{A results data.frame generated by recpd_calc().}

\item{feat}{A user-provided array of length 2, containing named features, or
indices, corresponding to the feature column/rows of the recpd_calc()
results data.frame.}

\item{include.root}{logical. Include branches from the root of the tree
(TRUE) or the MRCA of the presence state tips (FALSE).}
}
\value{
A ggtree object.
}
\description{
Plot feature Faith's PD ancestral lineages onto a species phylogenetic tree.
}
\examples{

}
\seealso{
\code{\link{plt_recpd}}
}
