#' backpipe
#' 
#' Simlilar to \code{\%>\%} but reverses the order of the operators. It is 
#' especially useful for composing shiny tags.
#' 
#' @param lhs a function or expression
#' @param rhs value ro be piped
#' 
#' There is not yet much support for complex expressions
#' 
#' @author Christopher Brown
#' 
#' @seealso 
#'   \code{\link{\%<\%}}
#'     
#' @examples
#' letters %>% paste0( 1:26 )  # forward pipe
#' paste0( 1:26 ) %<% letters  # backward pipe
#' 
#' \dontrun{
#'   div( class="outer-outer") %<%
#'     div( class="outer") %<% 
#'       div( class="inner") %<% h1( "content", role="heading" )
#' }          
#'            
#' @rdname backpipe      
#' @export 

`%<%` <- function( lhs, rhs ) { 

  lhs <- substitute(lhs)
  rhs <- substitute(rhs)
  
  parent = parent.frame() 
    
  # Allow for nested backpipes 
  #  The first case recomposes the nested backpipe expressions, 
  #  The second part uses forward pipe for evaluation to keep this close to the 
  #  original
  ca <- 
    if( is.call(lhs) && deparse( lhs[[1]] ) == '%<%' ) {
      rhs. <- as.call( c(`%>%`, rhs, lhs[[ length(lhs)]] ) )  
      lhs. <- lhs[[2]]
    
      as.call( c( `%<%`, lhs[[2]], rhs. )) 

    } else { 
      as.call( c( `%>%`, rhs, lhs) )  
    }
  
  eval(ca, parent, parent )
}
