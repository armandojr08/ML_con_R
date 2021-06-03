
###### DATOS FALTANTES : missing data ######

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

gg_miss_upset(data_hw)

# ---------------------------------------------------------
# Referencias
# https://cran.r-project.org/web/packages/naniar/index.html
# https://cran.r-project.org/web/packages/naniar/vignettes/getting-started-w-naniar.html



