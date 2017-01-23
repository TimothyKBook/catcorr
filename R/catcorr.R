#' catCorr
#'
#' Produce metrics of correlation among categorical variables.
#'
#' @param x Either a vector or data.frame to analyze.
#' @param y If \code{x} is a vector, the \code{y} is the vector to compare it to.
#' @param bias_correction Logical, if TRUE (default), use the bias correction in
#' Cramer's V
#' @param type Which statistics to produce.  Options are \code{'tschuprow'},
#' \code{'tschu'}, \code{'t'} for Tschuprow's T statistic, \code{'cramer'},
#' \code{'c'}, \code{'v'} for Cramer's V statistic and p-values, and
#' \code{'both'} or \code{'b'} for both options.
#'
#' @return Cramer's V (\code{cramer_V}), Tschuprow's T (\code{tschu_T}), and/or
#' p-value(s) (\code{pval}).
#'
#' @export
catCorr <- function(x = NULL, y = NULL,
                    bias_correction = TRUE,
                    type = "both")
{

  # TODO: Vectorize matrix computation
  if (length(x) > 0 & !is.null(y))
  {
    output <- find_corr_vec(x, y, type = type, bias_correction = bias_correction)
    return(output)
  }
  else if ((is.data.frame(x) | is.matrix(x)) & is.null(y))
  {
    output <- find_corr_df(x, type = type, bias_correction = bias_correction)
    return(output)
  }
  else
  {
    stop("Error somewhere!  Check your inputs.")
  }
}
