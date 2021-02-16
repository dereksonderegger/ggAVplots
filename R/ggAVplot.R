#' Generates a single Added Variable plot
#'
#' @param model An input model created by lm, glm, or any model that
#'              supports `formula()` and `update()` functions.
#' @param variable The variable to create the Added Variable Plot on.
#' @param data A data frame that will be used for making the graph. This
#'             is useful for adding labels, color encodings, etc for
#'             other aspects of the graph the user wants to add.
#' @param ... Further arguments to be passed to the whole plot `aes()`
#'            function.
#' @examples
#' model = lm( log(mpg) ~ disp + hp + drat + wt, data = mtcars)
#' ggAVplot(model, 'hp')
#' ggAVplot(model, 'hp', data=mtcars, color=cyl ) # add to plot-wide aesthetics list
#'
#' @export
ggAVplot <- function(model, variable, data=NULL, ...){
  y_variable <- terms(formula(model))
  y_variable <- as.character(attr(y_variable,'variables'))
  y_variable <- y_variable[2]

  m_y = update(model, paste('. ~ . -', variable))
  m_z = update(model, paste(variable, '~ . -', variable))

  if(is.null(data)){
    df <- data.frame(e_y=resid(m_y), e_z=resid(m_z))
  }else{
    df <- dplyr::mutate(data,
      e_y = resid(m_y, newdata=data),
      e_z = resid(m_z, newdata=data))
  }

  P <-
    ggplot2::ggplot(df, ggplot2::aes(x = e_z, y = e_y, ...)) +
      ggplot2::geom_point(size = 1) +
      ggplot2::geom_smooth(method='lm', formula = y~x) +
      ggplot2::labs(x = paste(variable, '| Others'),
                    y = paste(y_variable, '| Others'))

  return(P)
}
