
x <- 5*6
x

#how to check if x is really a vector

is.vector(x)
length(x)

x[2]<-31
X
x
x[5]<-44
x
# [ -> shift + alt + (

x[11]
x[0]

x <- 1:4
x


y <- x^2
y

x <- 1:5

y <- 3:7


x
y


x+y

z <- y[-5] 

x+z

z <- 1:10

z^x


c("hello", "workshop", "participants!")

str(c("hello", "workshop", "participants!"))

c(9:11, 200, x)

str(c(9:11, 200, x))

c("something", pi, 2:4, pi > 3)

str(c("something", pi, 2:4, pi > 3))

w <- rnorm(10) #lger en vector med ti tilfeldige tall fra en normaldistribution
seq_along(w)
w
which(w<0) #her får vi oppgitt hvilke som har verdier lavere enn 10, dvs hvilke posisjoner de innehar


w[which(w<0)]  #her får vi nr 3, 8 og 10 i vectoren, men verdiene deres. 


w[w<10]


w[-c(2,5)]

#in a vector, all data need to be of the same type, or R will coerce data into the same type
#in lists, data is allowed to be of different types 


list("something", pi, 2:4, pi >3)

str(list("something", pi, 2:4, pi >3))

list (vegetable = "cabbage",
      number = pi, 
      series = 2:4, 
      telling = pi>3)

#assign this list to vector x 
x <- list (vegetable = "cabbage",
           number = pi, 
           series = 2:4, 
           telling = pi>3)
str(x)


#$ gives a meny/list of data we put into x 
x$vegetable

x[1]


str(x[1])

str(x$vegetable)


x[3]


x[[3]]


x <- list(vegetable = list("cabbage", "carrot", "spinach"),
           number = list(c(pi, 0, 2.14, NA)),
           series = list(list(2:4, 3:5)),
           telling = pi > 3)

str(x)

#lists: to get the elements out of the list/extract elements out of the list: double brackets or dollar signs
#can always use str to check the structure of the list


mod <- lm(lifeExp ~ gdpPercap, data=gapminder_plus)
mod
str(mod)

mod[[8]]

str(mod[[8]])
#eller
str(mod[["df.residual"]])

str(mod[["qr"]])


mod$qr$qr[1] 






















