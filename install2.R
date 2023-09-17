pkg_list <- c(
  'assertthat',
  'feather',
  'knitr',
  'kableExtra',
  'htmlTable',
  'htmltools',
  'tidyverse',
  'htmlwidgets',
  'plotly',
  'devtools',
  'tm',
  'tidytext',
  'wordcloud',
  'ggwordcloud',
  'RColorBrewer',
  'SnowballC',
  'topicmodels',
  'reshape2',
  'DiagrammeR',
  'DiagrammeRsvg',
  'rsvg',
  'stringdist',
  'qdap',
  'janitor',
  'staplr',
  'qpdf',
  'pagedown',
  'shape',
  'writexl',
  'lpSolve'
)

install_if_not_present <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, method='auto', repos='http://cran.us.r-project.org', type="source")
  }
}

lapply(pkg_list, install_if_not_present)
