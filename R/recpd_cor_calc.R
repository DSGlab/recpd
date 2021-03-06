#### recpd_cor_calc() - Extension of Jaccard similarity of two trait branch
#lineage distributions, based on the sum of branch lengths shared between two
#traits, normalized by the total sum of unique trait lineage branches. this
#version also outputs the unweighted branch state jaccard overlap, and jaccard
#overlap using only phylogenetic tree tips. ###

#Wrap this function to generate a pairwise correlation matrix, or binary list?

#' RecPD branch-length weighted jaccard similarity.
#'
#' @param res A results data.frame generated by recpd_calc().
#' @param feats A user-provided array of at least length 2, containing named features, or indices,
#'     corresponding to the feature column/rows of the recpd_calc() results data.frame.
#'
#' @return data.frame of feature x feature RecPD correlations.
#' @export
#'
#' @examples
#'
recpd_cor_calc <- function(res, feats){
  #Input arguments:
  #res - a results data.frame generated by recpd_calc()

  #feats - an array of at least length 2, which contains named features, or indices
  #corresponding to the feature presence/absence table provided to recpd_calc()

  #Output:
  #rpd_cor_mat - a matrix of feature x feature recpd correlations, in data.frame format.
  rpd_cor_mat <- data.frame(matrix(NA, length(feats), length(feats), dimnames = list(feats, feats)),
                            check.names = FALSE)

  #Check that two features are provided:
  stopifnot(length(feats) >= 2)

  #Get the species phylogenetic tree:
  tree <- attr(res, 'tree')

  #If features are numeric indices, then force them to character:
  if(is.numeric(feats)) feats <- as.character(feats)

  #Iterate through the pairs of features, and calculate their recpd_cor:
  for(i in 1:(length(feats) -1)){
    #Recpd state annotations for feature distribution 1:
    state_x <- attr(res, 'anc_new')[[feats[i]]]

    #br_y - recpd annotated branch states for trait distribution 2:
    br_x <- state_x$branch_state

    #ts_x - recpd annotated tip states for trait distribution 1.
    ts_x <- state_x$tip_state

    for(j in (i + 1):length(feats)){
      #Recpd state annotations for feature distribution 2:
      state_y <- attr(res, 'anc_new')[[feats[j]]]

      #br_x - recpd annotated branch states for trait distribution 1:
      br_y <- state_y$branch_state

      #ts_y - recpd annotated tip states for trait distribution 2.
      ts_y <- state_y$tip_state


      #Identify which gain branches are present in both x and y trait lineages (states = 1),
      #and, which loss branches are absent in both x and y trait lineages (states = 0)?
      ##Note that absent branches (state = -1) are excluded.
      ol_b <- which(br_x == 1 & br_y == 1)# | br_x == 0 & br_y == 0)


      #Identify all unique branches which are present in x and y trait lineages (states = 1/1, 1/0, 0/1):
      tot_b <- which(br_x == 1 | br_y == 1)


      #Calculate RecPDcor, by taking the sum of shared gain and loss branch lengths between both trait lineages,
      #divided by the sum of all tree branch lengths represented by either trait distribution lineage.
      #This is equivalent to a jaccard similarity of trait lineage branches, weighted by tree branch lengths.

      #Also, for comparison purposes, calculate the unweighted recpd trait lineage jaccard similarity.

      #Also calculate the tip gain/loss node jaccard overlap.
      ol_t <- which(ts_x == 1 & ts_y == 1)
      tot_t <- which(ts_x == 1 | ts_y == 1)

      recpd_cor <- sum(tree$edge.length[ol_b])/sum(tree$edge.length[tot_b])
      recpd_jacc <- length(ol_b)/length(tot_b)
      tip_jacc <- length(ol_t)/length(tot_t)

      #Store recpd_cor in rpd_cor_mat:
      rpd_cor_mat[feats[i], feats[i]] <- 1
      rpd_cor_mat[feats[j], feats[j]] <- 1

      rpd_cor_mat[feats[i], feats[j]] <- recpd_cor
      rpd_cor_mat[feats[j], feats[i]] <- recpd_cor
    }
  }

  #Old code, for just single pairwise correlations:
  # rpd_cor <- list(recpd_cor = sum(tree$edge.length[ol_b])/sum(tree$edge.length[tot_b]),
  #                 recpd_jacc = length(ol_b)/length(tot_b),
  #                 tip_jacc = length(ol_t)/length(tot_t)
  # )

  return(rpd_cor_mat)
}
