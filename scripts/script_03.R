# 
rm(list = ls())
data0 <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/candy_production.csv")
colnames(data0) <- c("period", "candy_production")
colnames(data0)
str(data0)
class(data0) # debe ser un tipo data.frame

# convertimos el dataframe en un objeto TS
candyts <- ts(data0$candy_production,
              start = c(1972,1),
              end = c(2017,8),
              frequency = 12)
str(candyts)
candyts

# verificando si hay valores perdidos
sum(is.na(candyts))
# verificando la frecuencia
frequency(candyts)
# ciclo
cycle(candyts)
# visualizacion de la data
plot.ts(candyts, ylab = 'produccion de caramelos', main = 'Produccion mensual de caramelos en USA')
# boxplot de la serie de tiempo en funcion de su ciclo
colores <- rep('lightblue',12)
colores[3] <- 'yellow'
boxplot(candyts~cycle(candyts),
        xlab = 'mensual',
        ylab = 'produccion de caramelos',
        main = 'produccion mensual de caramelos [1972-2017]',
        col = colores)

# Datos obtenidos de
# https://github.com/robintux/Datasets4StackOverFlowQuestions/blob/master/candy_production.csv
