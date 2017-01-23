find_corr_vec <- function(x, y, type = "b", bias_correction = TRUE)
{
  x <- as.vector(x)
  y <- as.vector(y)

  r <- length(unique(x))
  c <- length(unique(y))
  n <- length(x)

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

  if (bias_correction)
  {
    pi_mat <- prop.table(table(x, y))

    pi_i <- prop.table(table(x))
    pi_j <- prop.table(table(y))
    pi_cross <- outer(pi_i, pi_j)

    phi2 <- sum((pi_mat - pi_cross)^2/pi_cross)

    phi2_tilde <- phi2 - (r - 1) * (c - 1) / (n - 1)
    phi2_tilde_plus <- ifelse(phi2_tilde >= 0, phi2_tilde, 0)

    r_tilde <- r - (r - 1)^2 / (n - 1)
    c_tilde <- c - (c - 1)^2 / (n - 1)
  }

  suppressWarnings({
    chi_obj <- chisq.test(x, y)
  })

  sol <- list()

  if (do_V)
  {
    if (bias_correction) {
      crV <- sqrt(phi2_tilde_plus / min(r_tilde - 1, c_tilde - 1))
    } else {
      chi2 <- chi_obj$statistic
      crV <- sqrt((chi2 / n) / min(r - 1, c - 1))
    }

    sol$cramer_V <- crV
    sol$pval <- chi_obj$p.value
  }
  if (do_T)
  {
    if (bias_correction) {
      tsT <- sqrt(phi2_tilde_plus / sqrt((r_tilde - 1) * (c_tilde - 1)))
    } else {
      chi2 <- chi_obj$statistic
      tsT <- sqrt((chi2 / n) / sqrt((r - 1)*(c - 1)))
    }

    sol$tschu_T <- tsT
  }

  return(sol)
}
