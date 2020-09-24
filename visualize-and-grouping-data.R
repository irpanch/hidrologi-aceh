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


