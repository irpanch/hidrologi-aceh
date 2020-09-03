# cleaning data

# Keterangan,
# Sta_1 = Pegasing
# Sta_2 = Pintu Rime Gayo
# Sta_3 = Silih Nara

rm(list = ls())

# import raw data
library(readxl)
Sta_1<- read_excel("data-hujan/Sta Hujan Pegasing.xlsx", 
                                 sheet = "Hymos")

# lihat data
library(tidyverse)
glimpse(Sta_1)
str(Sta_1)

# ganti nama kolom dan kurangi kolom
Sta_1 <- Sta_1[,1:2]
names(Sta_1) <- c("Tanggal","Curah_Hujan")

Sta_1 <- filter(Sta_1, Curah_Hujan != "-")
Sta_1$Curah_Hujan <- as.numeric(Sta_1$Curah_Hujan)
Sta_1$Tanggal <- as.Date(as.POSIXct(Sta_1$Tanggal))

# cek type data
sapply(Sta_1,class)

# cek parameter data
max(Sta_1$Curah_Hujan)

# ringkasan data
summary(Sta_1)

# import data hujan sta lain
## import sta hujan pintu rime gayo
Sta_2<- read_excel("data-hujan/Sta Hujan Pintu Rime Gayo.xlsx", 
                   sheet = "Hymos")
Sta_2 <- Sta_2[,1:2]
names(Sta_2) <- c("Tanggal","Curah_Hujan")
Sta_2 <- filter(Sta_2, Curah_Hujan != "-")
Sta_2$Curah_Hujan <- as.numeric(Sta_2$Curah_Hujan)
Sta_2$Tanggal <- as.Date(as.POSIXct(Sta_2$Tanggal))

## import sta hujan Silih nara
Sta_3<- read_excel("data-hujan/Sta Hujan Silih nara.xlsx", 
                   sheet = "Hymos")
Sta_3 <- Sta_3[,1:2]
names(Sta_3) <- c("Tanggal","Curah_Hujan")
Sta_3 <- filter(Sta_3, Curah_Hujan != "-")
Sta_3$Curah_Hujan <- as.numeric(Sta_3$Curah_Hujan)
Sta_3$Tanggal <- as.Date(as.POSIXct(Sta_3$Tanggal))

# Tambah kolom nama stasiun
nama_sta1 <- "Pegasing"
nama_sta2 <- "Pintu Rime Gayo"
nama_sta3 <- "Silih Nara"

Sta_1$Nama_Stasiun <- nama_sta1
Sta_2$Nama_Stasiun <- nama_sta2
Sta_3$Nama_Stasiun <- nama_sta3


View(Sta_3)

# gabung data semua stasiun hujan

data_gabung_clean <- rbind(Sta_1,Sta_2,Sta_3)

View(data_gabung_clean)

write.csv(data_gabung_clean,"data_hujan_gabung.csv")
