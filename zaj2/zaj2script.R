library("MCDA")
library("OutrankingTools")
library("RIM")
library("MCDM")

RIM <- function(decision, #matrix with all the alternatives
                  weights,  #vector with the numeric values of the weights
                  cb,       #vector with the "type" of the criteria (benefit = "max", cost = "min")
                  v         #value with the real number of the 'v' parameter to calculate Q
)
{
  #Checking parameters
  if(! is.matrix(decision))
    stop("'decision' must be a matrix with the values of the alternatives")
  if(missing(weights))
    stop("a vector containing n weigths, adding up to 1, should be provided")
  if(sum(weights) != 1)
    stop("The sum of 'weights' is not equal to 1")
  if(! is.character(cb))
    stop("'cb' must be a character vector with the type of the criteria")
  if(! all(cb == "max" | cb == "min"))
    stop("'cb' should contain only 'max' or 'min'")
  if(length(weights) != ncol(decision))
    stop("length of 'weights' does not match the number of the criteria")
  if(length(cb) != ncol(decision))
    stop("length of 'cb' does not match the number of the criteria")
  if(missing(v))
    stop("a value for 'v' in [0,1] should be provided")
  
  #1. Ideal solutions
  posI <- as.integer(cb == "max") * apply(decision, 2, max) +
    as.integer(cb == "min") * apply(decision, 2, min)
  negI <- as.integer(cb == "min") * apply(decision, 2, max) +
    as.integer(cb == "max") * apply(decision, 2, min)
  
  #2. S and R index
  norm =function(x,w,p,n){
    w*((p-x)/(p-n))
  }
  SAux <- apply(decision, 1, norm, weights, posI, negI)
  S <- apply(SAux, 2, sum)
  R <- apply(SAux, 2, max)
  
  
  #3. Q index
  #If v=0
  if (v==0)
    Q <- (R-min(R))/(max(R)-min(R))
  #If v=1
  else if (v==1)
    Q <- (S-min(S))/(max(S)-min(S))
  #Another case
  else
    Q <- v*(S-min(S))/(max(S)-min(S))+(1-v)*(R-min(R))/(max(R)-min(R))
  
  #4. Checking if Q is valid
  if( (Q == "NaN") || (Q == "Inf")){
    RankingQ <- rep("-",nrow(decision))
  }else{
    RankingQ <- rank(Q, ties.method= "first") 
  }
  #5. Ranking the alternati
ves
  return(data.frame(Alternatives = 1:nrow(decision), S = S, R = R, Q = Q, Ranking = RankingQ))
  
}

d <- matrix(c(30,40,25,27,45,0,9,0,0,15,2,1,3,5,2,3,3,1,3,2,3,2,3,3,3,2,2,2,1,4),
            nrow = 5, ncol = 6)
w <- c(0.2262,0.2143,0.1786,0.1429,0.119,0.119)
cb = matrix(c(23,60,0,15,0,10,1,3,1,3,1,5),nrow = 2,ncol = 6)
v = matrix(c(30,35,10,15,0,0,3,3,3,3,4,5),nrow = 2,ncol = 6)
RIM(d,w,cb,v)