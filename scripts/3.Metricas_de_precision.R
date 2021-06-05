# Librerías
library(dplyr)
library(ggplot2)
library(tidyverse)
library(naniar)
library(simputation)
sessionInfo() # modulos cargados en memoria

# Ojo
# Para la limpieza de la consola Ctrl + L

# Dataset
url <- "https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/employees.csv"
data1 <- read.csv(url)

str(data1) # todas las variables son de tipo chr
           # Salary, Bonus deben ser numericos

# En el dataset, se ven observaciones en blanco, NA, ?, NaN, na
glimpse(data1)
# Posiblemente, el ? convierte las observaciones a character

# Tuberías de dplyr/tidyverse
data1 %>%
  miss_scan_count(search = list("n.a","na"))

# vectores predefinidos (extraños) del paquete naniar
common_na_numbers
common_na_strings
# La función miss_scan_count devuelve la cantidad de datos extraños
# Los números que están en formato chr también son contados como tal
miss_scan_count(data1, search = common_na_strings)
outpoutNA <- miss_scan_count(data1, search = common_na_strings)

# Funciones para manejos de NA
# replace_with_na()     reemplaza valores epecíficos con NA
# replace_with_na_all() todas las variables
# replace_with_na_at()  especificamos/seleccionamos un subconj de variables
# replace_with_na_if()  rellenamos bajo alguna condicion
colnames(data1)

# Buscamos el n.a y na
data1 %>% 
  replace_with_na(replace = list(Team = c('na','n.a'))) %>%
  miss_scan_count(search = common_na_strings)

# Buscamos los espacios en blanco o vacíos
data1 %>%
  replace_with_na_all(condition = ~.x == "") %>%
  miss_scan_count(search = common_na_strings)
# ~.x para especificar todas las filas

# Reemplazamos todos los posibles valores de common_na_strngs
# por NA
data1 %>%
  replace_with_na_all(condition = ~.x %in% common_na_strings) %>%
  miss_scan_count(search = common_na_strings)

# Analizando otro dataset más sencillo
data("pedestrian")
View(pedestrian)
str(pedestrian)

# Exploremos pedestrian en busca de N/A
miss_scan_count(pedestrian, search = list("N/A"))

# Exploremos pedestrian en busca de missing ,"na","n-a"
miss_scan_count(pedestrian, search = list("missing"))
miss_scan_count(pedestrian, search = list("na"))
miss_scan_count(pedestrian, search = list(" "))

# realmente, ¿qué hace miss_scan_count()
pollerias <- c("A la leña"," El Meson", "Norkys", "Pio Pio", "Rockys", "N/A","El gallo")
ventas_al_dia <- c(1200,1800,1240,2000,"na", 1300, NA)
df_polleria <- data.frame(pollerias, ventas_al_dia)
df_polleria
str(df_polleria)
miss_scan_count(df_polleria, search = list("na", "N/A"))
miss_scan_count(df_polleria, search = common_na_strings)
miss_scan_count(df_polleria, search = common_na_strings[-22])
# todos contienen el caracter "" de common_na_strings

# busquemos reemplazar los "", "na, "n.a", "NaN"
data1_limpia <- replace_with_na(data1, 
                                replace = list(Team = c("","na","n.a","NaN"),
                                               Bonus.. = c("","na","n.a","NaN")))
miss_scan_count(data1_limpia, search = list("","na","n.a","NaN"))

# replace_with_na_at para reemplazar con NA
replace_with_na_at(data1,
                  .vars = c("Fist.Name","Gender","Team"),
                  ~.x %in% c("","na","n.a","NaN","?"))

# Veamos un ejemplo con replace_with_na_if con la condición
# de que el valor sea un caracter
replace_with_na_if(data1,
                   .predicate = is.character,
                   ~.x %in% c(""," ","na","NaN","?"))
# usando el replace_with_na_all
replace_with_na_all(data1,
                    condition = ~.x %in% c(""," ","na","NaN","?","n.a","n.a."))

# creando un dataframe que no contenga caracteres extraños
data1_limpia_2 <- replace_with_na_all(data1,
                                      condition = ~.x %in% c(""," ","na","NaN","?","n.a","n.a."))
str(data1_limpia_2)
# modificar el tipo de variables salary y bonus..
data1_limpia_2$Salary <- as.numeric(data1_limpia_2$Salary)
data1_limpia_2$Bonus.. <- as.numeric(data1_limpia_2$Bonus..)
data1_limpia_2$Senior.Management <- as.logical(data1_limpia_2$Senior.Management)
str(data1_limpia_2)

# visualizacion de NA
vis_miss(data1_limpia_2)
