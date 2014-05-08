
source_https <- function(url, ...) {
  ## Function for sourcing individual R scripts from GitHub
  ## Author: Tony Breyal
  ## Contributions: Kay Cichini
  ## Original URL: http://tonybreyal.wordpress.com/2011/11/24/source_https-sourcing-an-r-script-from-github/
  ## Load required package
  require(RCurl)
  ## Parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE,
                             cainfo = system.file("CurlSSL", "cacert.pem",
                                                  package = "RCurl"))),
         envir = .GlobalEnv)
  })
}

# just a tiny mod
