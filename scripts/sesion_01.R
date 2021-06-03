
#### Configuraciones iniciales ####

rm(list = ls())
# setwd("directorio")
# getwd()
# dir()

### Análisis de datos exploratorios - EDA ###

## Datos categoricos

# Resumen de datos categoricos univariados
# Simularemos algunos datos categoricos, en R
# se les conoce como datos de tipo vector
gender <- c(rep('boy',10), rep('girl',12))
drink <- c(rep('coke',5), rep('sprite',3), 
           rep('coffee',6), rep('tea',3),
           rep('water',1))
age <- sample(c('young', 'old'), size = length(gender), replace = T)

# Chocolateo de los elementos
n <- length(gender)
gender <- gender[sample(1:n,n)]
drink <- drink[sample(1:n,n)]
age <- age[sample(1:n,n)]

# Contar las frecuencias de cada nivel de las
# variables anteriores
table(gender)
table(drink)
table(age)

# Cálculo de proporciones
prop.table(table(gender))
prop.table(table(drink))
prop.table(table(age))

# Resumen de datos categoricos bivariados
library(magrittr)
library(help = "magrittr")
cbind(gender, drink) %>% head
table1 <- table(gender, drink)
table1
# operador pipe, la salida de cbind() la utilizas
# como argumento de head

# Resumen de datos multivariado
table2 <- table(gender, drink, age)
table2
# Existe una forma más legible
table2_2 <- ftable(gender, drink, age)
table2_2

## Datos continuos
# Generación de un vector con elementos
# pseudo-aleatorios
x <- c(rexp(20), runif(50), rnorm(50,9,6.5), rweibull(20,5))
# chocolatear los elementos de x
x <- x[sample(1:length(x), length(x))]
plot(x)
# medidas de posicion
m1 <- mean(x)
m2 <- median(x)
# medidas de escala
desEst <- sd(x)
rango.iqr <- IQR(x)
mad(x)

### Visualización de datos

## Para datos categóricos

# gráfico univariado
barplot(table(age))

# grafico bivariado
plot(table1, main = 'grafico bivariado')
plot(table2, main = 'grafico bivariado 2')

## Para datos continuos

sample1 <- rnorm(100)
# qué tan concentrado estan los datos
stripchart(x = sample1)
hist(sample1)
hist(sample1, freq = T, main = 'frecuencias')
# proporciones
hist(sample1, freq = F, main = 'frecuencias')

h1 <- hist(sample1)
View(h1) # observo los campos de h1
h1$breaks # limtes de los intervalos de clase
h1$counts # altura de cada uno de las barras 
h1$density
# coloquemos la curva de densidad sobre
# nuestro histograma
hist(sample1, freq = F, main = 'densidad')
lines(density(sample1))
rug(sample1) # que tan junto estan los datos

# ejecutamos varias veces rnorm y veamos
# el comportamiento de su boxplot
for(num in 1:20){
  #x <- rnorm(100)
  x <- c(rexp(20), runif(80,0,20), rweibull(20,5))
  x <- x[sample(1:length(x), length(x))]
  boxplot(x)
  Sys.sleep(time = 0.2)
}


