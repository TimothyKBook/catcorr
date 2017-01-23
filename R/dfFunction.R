find_corr_df <- function(x, type = "b", bias_correction = TRUE)
{
  x <- as.data.frame(x)
  n_cols <- ncol(x)

  if (type %in% c("cramer", "c", "v", "both", "b")) {
    do_V <- TRUE
  } else {
    do_V <- FALSE
  }

  if (type %in% c("tschuprow", "tschu", "t", "both", "b")) {
    do_T <- TRUE
  } else {
    do_T <- FALSE
  }

  V_mat <- matrix(0, n_cols, n_cols)
  T_mat <- matrix(0, n_cols, n_cols)
  P_mat <- matrix(0, n_cols, n_cols)

  for (i in 1:n_cols) for (j in i:n_cols)
  {
    corr_obj <- find_corr_vec(x[[i]], x[[j]])
    if (do_V)
    {
      V_mat[i, j] <- V_mat[j, i] <- corr_obj$cramer_V
      P_mat[i, j] <- P_mat[j, i] <- corr_obj$pval
    }
    if (do_T)
    {
      T_mat[i, j] <- T_mat[j, i] <- corr_obj$tschu_T
    }
  }

  sol <- list()
  if (do_V)
  {
    colnames(V_mat) <- rownames(V_mat) <- colnames(x)
    colnames(P_mat) <- rownames(P_mat) <- colnames(x)

    sol$cramer_V <- V_mat
    sol$pval <- P_mat
  }
  if (do_T)
  {
    colnames(T_mat) <- rownames(T_mat) <- colnames(x)
    sol$tschu_T <- T_mat
  }

  return(sol)

}
