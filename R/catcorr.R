catCorr <- function(x = NULL, y = NULL,
                    bias_correction = TRUE,
                    type = "both")
{
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
