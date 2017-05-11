#' <Testing out the Sigma.JS htmlwidget>
#'
#' <This html widget follows the steps outlined by
#' https://github.com/ramnathv/htmlwidgets/blob/master/vignettes/develop_intro.Rmd
#' for creating a widget
#'
#' Sigma takes two classes of inputs
#'  1) the GEXF data file to render
#'  2) Some additional settings which control how it is rendered>


#' @import htmlwidgets
#' @export
sigma <- function(gexf, drawEdges = TRUE, drawNodes = TRUE,
                  width = NULL, height = NULL) {

  # read the gexf file
  data <- paste(readLines(gexf), collapse="\n")

  # create a list that contains the settings
  settings <- list(
    drawEdges = drawEdges,
    drawNodes = drawNodes
  )

  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )

  # create the widget
  htmlwidgets::createWidget("sigma", x, width = width, height = height)
}


#' <Add in these functions to be able to render in Shiny>

#' @export
sigmaOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "sigma", width, height, package = "sigma")
}

#' @export
renderSigma <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaOutput, env, quoted = TRUE)
}
