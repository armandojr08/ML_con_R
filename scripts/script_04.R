rm(list = ls())
dev.off()

# libreria de datos financieros
library(quantmod)

# definamos una lista de empresas a estudiar y
# tambien un indicador
tickers <- c('AAPL','TSLA','IBM','CSCO','C','^GSPC')

# para la descarga vamos a usar la funcion getSymbols
getSymbols(Symbols = tickers)

# cuando haya el problema de que no puedo descargar
# varios tickets con una sola ejecucion de getSymbols
for(t in tickers){
  getSymbols.yahoo(Symbols = t, verbose = T, env = .GlobalEnv)
  Sys.sleep(3)
}
# verbose indica si hay un problema o no

# conseguir datos de forex (tipo de cambio)
USOPEN <- getSymbols.oanda('USD/PEN', auto.assign = F)
