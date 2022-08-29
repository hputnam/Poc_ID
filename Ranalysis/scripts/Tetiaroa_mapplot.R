### Make a map

#if(!requireNamespace("devtools")) install.packages("devtools")
#devtools::install_github("dkahle/ggmap")
library(ggmap)
library(sf)
library(ggsn)
library(tidyverse)
library(patchwork)

###### Make Map ############
register_google(key = "addkeyhere") ### use your own API

# Sites
sitedata <- read.csv("data/tetia_tracks.csv")
#sitedata$Lat <- round(as.numeric(as.character(sitedata$Lat)),4)
str(sitedata)
labels <- sitedata$ident
isledata <- read.csv("data/tetia.info.map.csv")
island <- isledata$Site
# location
NS<-data.frame(lon = -149.56284, lat = -17.008567)

#Map base
M1<-get_map(NS,zoom = 12, maptype = 'satellite')

#site.cols <- c("#374D7C","#00CCCC", "#FF6633")


TetiaroaSitemap<-ggmap(M1)+
  scalebar(x.min = -149.804, x.max = -149.808,y.min = -17.480, y.max = -17.475,
           model = 'WGS84', box.fill = c("gray", "white"), st.color = "white",
           location =  "bottomright", transform = TRUE, dist_unit = "km", dist = 1) +
  geom_point(data = sitedata, mapping = aes(x=Longitude, y=Latitude), size=0.5)+
  #geom_text(data = sitedata, aes(x=Longitude, y=Latitude, label=labels),vjust = -2,size=1 )+
  ggtitle('B')+
  xlab("")+
  ylab("")

pdf("output/Tetiaroa_map.pdf")
TetiaroaSitemap
dev.off()

# # location
# Moorea<-data.frame(lon = -149.83246425684064, lat = -17.531092816791094)
# 
# #Map base
# M2<-get_map(Moorea,zoom = 12, maptype = 'satellite')
# 
# bbx <- c(left=-149.802,bottom= -17.480,right=-149.805,top=-17.475)
# x <- c(bbx["left"], bbx["left"], bbx["right"], bbx["right"])
# y <- c(bbx["bottom"], bbx["top"], bbx["top"], bbx["bottom"])
# df <- data.frame(x, y)
# 
# Mooreamap<-ggmap(M2)+
#   scalebar(x.min = -149.90, x.max = -149.05,y.min = -17.4, y.max = -18.0,
#            model = 'WGS84', box.fill = c("gray", "white"), st.color = "white",
#            location =  "bottomright", transform = TRUE, dist_unit = "km", dist = 10) +
#   geom_polygon(aes(x=x, y=y), data=df, color="yellow", fill=NA) +
#   #geom_text(data = isledata, aes(x=Long, y=Lat, label=island),vjust =0,size=4, color = 'yellow')+
#   ggtitle('A')+
#   xlab("")+
#   ylab("")
# 
# Mooreamap
# 
# (Mooreamap+MooreaSitemap) +ggsave("output/SiteMap.pdf", width = 10, height = 6)
