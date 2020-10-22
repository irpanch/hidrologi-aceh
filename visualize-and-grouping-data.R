# visualize and grouping data

## import data


library(readr)
## ---- data-hujan
data <- read_csv("data_hujan_gabung.csv") 
data <- data[,-1] # hilangkan kolom nomor

# data hujan harian setiap pos hujan
library(ggplot2)

## ---- data-pisah
plot_pisah <- ggplot(data,aes(Tanggal, Curah_Hujan,col=Nama_Stasiun)) +
  geom_line() + 
  labs(title="Data Curah Hujan Pada Masing-masing Stasiun",
       y="Curah Hujan (mm)",
       x="Waktu") + 
  facet_wrap(~Nama_Stasiun)+
  theme_update(plot.title=element_text(hjust=0.5))+
  theme_update(plot.subtitle=element_text(hjust=0.5))+
  theme_update(axis.title.y=element_text(angle=90)) 

## ---- plot-gabung
plot_gabung <- ggplot(data,aes(Tanggal, Curah_Hujan,col=Nama_Stasiun)) +
  geom_line() + 
  labs(title="Data Curah Hujan Pada Masing-masing Stasiun",
       y="Curah Hujan (mm)",
       x="Waktu") + 
  theme_update(plot.title=element_text(hjust=0.5))+
  theme_update(plot.subtitle=element_text(hjust=0.5))+
  theme_update(axis.title.y=element_text(angle=90))
plot_gabung

## ---- plot-pisah
ggplot(data,aes(Tanggal, Curah_Hujan,col=Nama_Stasiun)) +
  geom_line() + 
  labs(title="Data Curah Hujan Pada Masing-masing Stasiun",
       y="Curah Hujan (mm)",
       x="Waktu") + 
  facet_wrap(~Nama_Stasiun)+
  theme_update(plot.title=element_text(hjust=0.5))+
  theme_update(plot.subtitle=element_text(hjust=0.5))+
  theme_update(axis.title.y=element_text(angle=90)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


# tambah kolom hari, bulan, dan tahun.
library(lubridate)
data$DOY <- as.numeric(yday(data$Tanggal))
data$YEAR <- as.numeric(format(data$Tanggal,"%Y"))
data$MONTH <- as.numeric(format(data$Tanggal,"%m"))
data$Bulan <- month.abb[data$MONTH]
data <- data[,1:7]

View(data)

# Jumlah curah hujan bulanan

nama_sta1 <- "Pegasing"

# max curah hujan harian

## ---- CurahHujan_sta1
library(pivottabler)
data_sta1 <- subset(data,data$Nama_Stasiun == nama_sta1)
pivot_sta1 <- PivotTable$new()
pivot_sta1$addData(data_sta1)
pivot_sta1$addColumnDataGroups("Bulan")
pivot_sta1$sortColumnDataGroups(levelNumber=1,orderBy="customByValue",
                                sortOrder="asc",
                                customOrder=c("Jan","Feb","Mar",
                                              "Apr","May","Jun",
                                              "Jul","Aug","Sep",
                                              "Oct", "Nov","Dec"))
pivot_sta1$addRowDataGroups("YEAR")
pivot_sta1$defineCalculation(calculationName="Max",summariseExpression="max(Curah_Hujan)")
# cells <- pivot_sta1$findCells(minValue=100,totals="exclude")
# pivot_sta1$setStyling(cells=cells, declaration=list("background-color"="#FFC7CE", "color"="#9C0006"))
# pivot_sta1$renderPivot()
pivot_sta1$evaluatePivot()
sta1_df <- pivot_sta1$asDataFrame()
kable(
  sta1_df, booktabs=TRUE,
  caption= 'Hujan Max'
)



