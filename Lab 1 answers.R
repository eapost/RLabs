data(mtcars)
?mtcars

# 1
kpl <- 378.54/(1.609*mtcars$mpg)

# 2

1000*mean(mtcars$wt)

# 3
class(mtcars$vs)
class(mtcars$am)

VS <- factor(mtcars$vs,labels=c("V-shaped","Straight"))
AM <- factor(mtcars$am,labels=c("Automatic","Manual"))

# 4

sum(mtcars$hp>200)

# 5
rownames(mtcars)[which(mtcars$qsec==min(mtcars$qsec))]

# 6

length(grep("Toyota", rownames(mtcars)))





