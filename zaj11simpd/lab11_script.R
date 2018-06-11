
library("sets")

sets_options("universe", seq(1, 150, 0.5))
variables <- set(
  Ekran = fuzzy_partition(varnames = c(small = 50, medium = 56, large = 61), sd = 0.1),
  RAM = fuzzy_partition(varnames = c(small = 1, medium = 3, large = 6), sd = 20),
  Pamiec = fuzzy_partition(varnames = c(poor = 0, sufficient = 64, excellent = 128), sd = 1.0),
  Price = fuzzy_partition(varnames = c(low = 0, medium = 2000, high = 4000), sd = 1000),
  Rank = fuzzy_partition(varnames = c(poor = 1, mediocre = 2, alright = 3, nice = 4, great = 5), FUN = fuzzy_cone, radius = 0.5)
)

# Fuzzy rules
rules <- set(
  fuzzy_rule(Ekran %is% small && RAM %is% small && Pamiec %is% poor, Rank %is% poor),
  fuzzy_rule(Ekran %is% small && RAM %is% small, Rank %is% mediocre),
  fuzzy_rule(Ekran %is% medium && RAM %is% medium, Rank %is% nice),
  fuzzy_rule(Ekran %is% large && RAM %is% large, Rank %is% great),
  fuzzy_rule(Price %is% low && Ekran %is% small && RAM %is% small, Rank %is% alright),
  fuzzy_rule(Price %is% medium && Ekran %is% medium && RAM %is% medium, Rank %is% nice),
  fuzzy_rule(Price %is% large && Ekran %is% large && RAM %is% large, Rank %is% great),
  fuzzy_rule(Price %is% high && Pamiec %is% excellent, Rank %is% alright),
  fuzzy_rule(Price %is% low && Pamiec %is% poor, Rank %is% alright),
  fuzzy_rule(Price %is% low && Pamiec %is% excellent, Rank %is% great),
  fuzzy_rule(Price %is% high && Pamiec %is% poor, Rank %is% poor)
)
model <- fuzzy_system(variables, rules)

print(model)
plot(model)
example.1 <- fuzzy_inference(model, list(Ekran = 58, RAM = 4, Pamiec = 128, Price = 2699))
gset_defuzzify(example.1, "centroid")
dev.new()
plot(example.1)