library(leaflet)

ohtheplacesIgo <- data.frame(long=c(-78.5069, -78.507), 
                             lati=c(38.033, 38.0333), loc_name=c("my office", "class"))

leaflet(data=ohtheplacesIgo) %>% addTiles() %>%
  addMarkers(lng=~long, lat=~lati, popup=~loc_name)


leaflet(data=ohtheplacesIgo) %>% addTiles() %>%
  addMarkers(lng=~long, lat=~lati, popup= ~loc_name, label=~loc_name)


ohtheplacesIgo <- data.frame(long=c(-78.5069, -78.507), 
                             lati=c(38.033, 38.0333), 
                             loc_details=c(paste(sep = "<br/>",
                                                 "Rodu",
                                                 "<b><a href='mailto:jsr6q@virginia.edu'>email me</a></b>",
                                                 "412-982-2150"
                             ), "class"))

leaflet(data=ohtheplacesIgo) %>% addTiles() %>%
  addMarkers(lng=~long, lat=~lati, popup=~loc_details)

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/seattle")
listings <- read_csv("listings.csv")
listings$longitude
listings$longitude


listings %>%
  head(50) %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(lng=~longitude, lat=~latitude)

library(geojsonio)
#downloaded from https://catalog.data.gov/dataset?res_format=GeoJSON
bike_crashes <- geojson_read("bicycle-crash-data-chapel-hill-region.geojson",
                             what="sp")




mypal <- colorFactor(topo.colors(7), bike_crashes$category)

leaflet(bike_crashes) %>% addTiles() %>% 
  addCircleMarkers(radius = 5, stroke=FALSE, fillOpacity = 1, 
                   color=~mypal(crashday), popup=~weather) %>%
  addLegend(pal=mypal, values=~crashday, opacity=1)

url <- 'https://opendata.arcgis.com/datasets/744c03a8165a42929f37e2c9f58dc860_0.geojson'

districts <- geojson_read(url, what="sp")

leaflet(districts) %>% addTiles() %>% 
  addPolygons(color = "#444444", weight = 1, fillColor='#0000ff',
              opacity = 1.0, highlightOptions = highlightOptions(color = "white", weight = 2,
                                                                 bringToFront = TRUE))
