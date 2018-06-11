library("sets")
X <- c("A", "B", "C")
gset(support = X, universe = LETTERS[1:10])

N <- fuzzy_normal (mean = 0, sd = 1)
N( -3:3)

gset(charfun = N, universe = -3:3)
fuzzy_normal_gset (universe = -3:3)
fuzzy_poisson <- charfun_generator(dpois)
gset (charfun = fuzzy_poisson(10),
      universe = seq(0 ,20, 2))

## creating a series of fuzzy normal sets
fuzzy_tuple (fuzzy_normal, 5)

## a fuzzy multi set
plot(fuzzy_bell)

## creating a sequence of sets
plot (fuzzy_tuple (fuzzy_cone,10),
      col = gray.colors(10))

x <- fuzzy_normal_gset()
y <- fuzzy_trapezoid_gset(corners =
                            c(5,10,15,17), height = c(0.7,1))
plot(tuple(x,y), lty = 3)
lines (x | y, col = 2)
lines (gset_mean(x,y), col = 3, lty = 2)