The catCorr Package
-------------------

This package contains the `catCorr` function, which allows users to
construct scalars and matrices based off of two statistics: Cramer's V
statistic, and Tschuprow's T statistic. The p-value associated with
Cramer's V (related to the *χ*<sup>2</sup> statistic) is also output.

First, some data:
```r
set.seed(1234)

n <- 30
w <- rep(c('D', 'E', 'D'), each = 10)
x <- sample(c('A', 'B'), n, replace = TRUE)
y <- sample(c('A', 'B', 'C'), n, replace = TRUE)
z <- c(rep('D', 15), rep('E', 15))

df <- data.frame(w, x, y, z)
```
The `catCorr` function has two implementations via inputting either a
`data.frame` or two vectors.
```r
catCorr(x, y)

## $cramer_V
## [1] 0.1727463
##
## $pval
## [1] 0.2306932
##
## $tschu_T
## [1] 0.1465884

catCorr(df)

## $cramer_V
##   w         x         y         z
## w 1 0.0000000 0.0000000 0.0000000
## x 0 1.0000000 0.1727463 0.2817181
## y 0 0.1727463 1.0000000 0.0000000
## z 0 0.2817181 0.0000000 1.0000000
##
## $pval
##              w            x            y            z
## w 4.053379e-07 6.985354e-01 3.916056e-01 1.000000e+00
## x 6.985354e-01 3.186355e-07 2.306932e-01 1.441270e-01
## y 3.916056e-01 2.306932e-01 2.900863e-12 6.592406e-01
## z 1.000000e+00 1.441270e-01 6.592406e-01 3.186355e-07
##
## $tschu_T
##   w         x         y         z
## w 1 0.0000000 0.0000000 0.0000000
## x 0 1.0000000 0.1465884 0.2817181
## y 0 0.1465884 1.0000000 0.0000000
## z 0 0.2817181 0.0000000 1.0000000
```
