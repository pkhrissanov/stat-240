likeleyhood <- function(prob,heads, tails){
  
  (prob^heads) * ((1-prob)^tails)
  
  
}
likeleyhood(.5,)


xs <- seq(0, 1, length.out = 100)
ys <- log((xs)^4 * (1 - xs)^2)

plot(xs, ys, ylab = "likelihood", xlab = "theta", type = "l")




