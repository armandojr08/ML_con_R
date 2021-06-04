
###### DATOS FALTANTES : missing data ######

library(naniar)
library(simputation)
library(dplyr)
library(tidyverse)
library(gridExtra)

## Los datos faltantes pueden traer efectos inesperados en nuestro análisis.
## Una mala imputación puede dar lugar a estimaciones (y en consecuencia),
## decisiones deficientes

x <- c(1,NA,3,NA,NA,5)

# Para generar x, implemente una función que genere 200 elementos enteros y 
# que además tenga un porcentaje aleatorio (entre 1 y 30 %) de elementos NA

# Implementar 3 formas de verificar presencia de elementos NA, midiendo
# tiempos de procesamiento

# 1era forma : usar las funciones any y is_na
baset0 <- Sys.time()
any(is.na(x))
t_base <- Sys.time() - baset0
t_base

# 2da forma : usando naniar
naniert0 <- Sys.time()
naniar::any_na(x)
t_naniar <- Sys.time() - naniert0
t_naniar

# 3era forma
base2t0 <- Sys.time()
anyNA(x)
t_base2 <- Sys.time() - base2t0
t_base2

# Buscar un vector booleano que testee si un elemento es NA
are_na(x)

# cantidad de NA en un vector de datos
n_miss(x)

# proporción de NA en un vector de datos
prop_miss(x)

# Operaciones aritméticas en vectores que contienen NA
sum(x)
sum(x, na.rm = T)
mean(x, na.rm = T)
which(is.na(x)) # posiciones que ocupan los NA

# Valores extraños : NA, NaN, Inf
c(1,0)/0

# Operaciones con NA desde una operación lógica
NA | TRUE
NA | FALSE
NA | NA
NaN | NA

# Crear otro vector
x <- c(NA, NaN, Inf, '.', 'missing')
any_na(x)
are_na(x)

# Cargar dataset desde GitHub

data_hw_url <- "https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/dat_hw.csv"
data_hw <- read.csv(data_hw_url)
colnames(data_hw)
dim(data_hw)

# eliminar la columna x (índices)
data_hw <- data_hw[,-1] # data_hw %>% select(-x)

# Cantidad de valores perdidos
n_miss(data_hw)
n_miss(data_hw$weight); n_miss(data_hw$height)

# Función n_complete : cuenta el número de valores no perdidos
n_complete(data_hw)
n_complete(data_hw$weight); n_complete(data_hw$height)

# Proporción de valores perdidos
prop_miss(data_hw)
prop_miss(data_hw$weight)

# Proporción de valores no faltantes
prop_complete(data_hw)
prop_complete(data_hw$height)

# Resumen estadístico básico del dataframe
summary(data_hw)

# Resumen de datos faltantes por columna
miss_col <- miss_var_summary(data_hw)
glimpse(miss_col)

# Trabajando con el dataframe airquality
miss_col_air <- miss_var_summary(airquality)
glimpse(miss_col_air)

# Información de valores perdidos por fila o caso
miss_case_summary(data_hw)    # case (fila)
miss_case_summary(airquality) # en la fila 27 hay 2 NA

miss_var_table(data_hw)    # En 2 variables faltan 15 observaciones
                           # en cada una de ellas

miss_var_table(airquality) # En 4 variables hay 0 NA
                           # En 1 variable faltan 7 observaciones
                          
miss_case_table(data_hw)   # 70 filas tienen 0 NA
                           # 30 filas tienen 1 NA

miss_case_table(airquality)# Hay 11 filas que no contienen NA

# Otras funciones útiles
# miss_var_span : resume NA por intervalo de datos (usada en ST)
# miss_var_run  : resume por ejecuciones, sirve para encontrar
#                 patrones inusuales en datos faltantes

# Visualización de datos faltantes
vis_miss(airquality)
vis_miss(airquality[,c(1,2,3)])
vis_miss(data_hw)

# Reporte de valores faltantes en ambas dimensiones
varp <- gg_miss_var(airquality)
casep <- gg_miss_case(airquality)
grid.arrange(varp, casep, ncol = 2)
# Si agrupamos  nuestros datos faltantes por intermedio
# de la variable month
varp_month <- gg_miss_var(airquality, facet = Month)
varp_month

# Algunas funciones importantes
v1 <- c(2,NA,5,12,NA,10,NA,9,NA,NA)
v2 <- c(23,NA,11,12,111,23,NA,0,10,NA)
v3 <- c(12,NA,12,16,124,2,12,1,9,NA)
v4 <- c(seq(1,9,1),NA)
df1 <- data.frame(v1,v2,v3,v4)
df1;dim(df1)
gg_miss_upset(df1)
# barras horizontales  : cantidad de NA
# baras verticales     : intersecciones en filas con NA
# números en barras v. : 2+1*2+1*3+1*4 = cantidad de NA

gg_miss_upset(data_hw)
gg_miss_upset(airquality)
n_miss(airquality$Wind)

# mapa de calor
gg_miss_fct(x = airquality, fct = Month)
# el mes 6 concentra más del 60% de los datos faltantes
# en la variable Ozono. Mes 6 muy conflictivo.

# Analizando dataset pedestrian
View(pedestrian)
str(pedestrian)
names(pedestrian)
dim(pedestrian)
gg_miss_span(pedestrian, var = hourly_counts, span_every = 3000)
# se agrupó en lapsos de 3000 elementos, las barras
# verticales son grupos, la primera barra comprende
# los 3000 primeros elementos

# Analizando dataset riskfactors, variable sexo
View(riskfactors)
dim(riskfactors)
str(riskfactors)
n_miss(riskfactors); prop_miss(riskfactors) # 14.24% de NA
# variable sexo
class(riskfactors$sex) # es tipo categórica
levels(riskfactors$sex)
any(is.na(riskfactors$sex)) # no contiene ningún NA
table(riskfactors$sex)      # distribución 
barplot(table(riskfactors$sex))

vis_miss(riskfactors)
limpiaNA <- na.omit(riskfactors)
dim(limpiaNA) # Toda fila contiene por lo menos un NA

# Si decido que toda columna con un porcentaje de NA
# por encima de 20 % se elimine
colSums(is.na(riskfactors)) # NA por columnas
rowSums(is.na(riskfactors)) # NA por filas
# 1era forma
NAs_rf <- riskfactors %>% map_df(function(x) sum(is.na(x))) %>%
  gather(variable, Num_NAs)
NAs_rf$porc_NA <- NAs_rf$Num_NAs*100/nrow((riskfactors))
NAs_rf
var_RF <- NAs_rf[NAs_rf$porc_NA > 20,]$variable
rf1 <- riskfactors[,!(colnames(riskfactors) %in% var_RF)]
# 2da forma
x <- vector()
for (i in 1:dim(riskfactors)[2]) {
  if (prop_miss(riskfactors[,i]) > 0.2) {
    x <- c(x,i)
  }
}
x # columnas que cumplen la condición

rf2 <- riskfactors[,-x]
dim(rf2)
vis_miss(rf2)
# Evaluar si lo que queda generaría algún problema


# ---------------------------------------------------------
# Referencias
# https://cran.r-project.org/web/packages/naniar/index.html
# https://cran.r-project.org/web/packages/naniar/vignettes/getting-started-w-naniar.html
# https://www.rdocumentation.org/packages/naniar/versions/0.6.1

# Resolución de errores presentados al correr el script
# https://stackoverflow.com/questions/20155581/persistent-invalid-graphics-state-error-when-using-ggplot2


