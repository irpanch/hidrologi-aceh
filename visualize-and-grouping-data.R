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

# pivot table dengan reshape2, more simple than pivottabler
## ---- jumlah_bulanan_sta1
library(reshape2)
library(kableExtra)
nama_sta1 <- "Pegasing"
data_sta1 <- subset(data,data$Nama_Stasiun == nama_sta1)
data_melt <- melt(data_sta1,id=c("YEAR","Bulan"),
                  measure="Curah_Hujan",value.name = "Hujan")
data_pivot <- dcast(data_melt,YEAR~Bulan,
                    margins = T,fun.aggregate = sum,
                    value.var = "Hujan")
data_pivot2 <- data_pivot[,c(1,6,5,9,2,10,8,7,3,13,12,11,4,14)]
kable(data_pivot2, booktabs=TRUE) %>% 
  kable_styling(position = "center")
# max curah hujan harian






