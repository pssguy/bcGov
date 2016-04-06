
# map 
output$sitesMap <- renderLeaflet({
  map <-sites %>% 
    leaflet()  %>% 
    addTiles() %>% 
    #addProviderTiles("MapQuestOpen.Aerial") %>%
    addCircleMarkers(color = ~pal(value),  # cannot use color with addMarkers
                     popup = popup,
                     stroke=FALSE,
                     fillOpacity = 1,
                     radius=5,
                     layerId=~name)
  map
})

## wrap ineractive outputs in observe



observe({
  click<-input$sitesMap_marker_click
  
  print("test click")
  print(click)
  print("tested click")
  if(is.null(click))
    return()
  #text<-paste("Lattitude ", click$lat, "Longtitude ", click$lng)
  text2<-paste("You've selected point ", click$id)
  # map$clearPopups()
  # map$showPopup( click$lat, click$lng, text)
  
  output$Click_text<-renderText({
    text2
  })
})

output$fp_ts <- renderPlotly({
  
  
  
  fp_df_date %>% 
    filter(ems_id=="E269223") %>% 
    plot_ly(x=date,y=avVal,mode="lines",color=as.factor(year),
            line=list(width=1),
            hoverinfo = "text",
            text = paste(date,"<br>Value:",avVal)) %>%
    add_trace(y = c(10, 10), x= c(min(vander$date), max(vander$date)),
              mode = "lines", line = list(color = "red",width=1,dash="10px"),
              name="Standard") %>%
    
    add_trace(y = c(meanValue, meanValue), x= c(min(vander$date), max(vander$date)), 
              mode = "lines", line = list(color = "red",width=2),
              name="Average") %>% 
    
    layout(hovermode = "closest",
           title="Status of Fine Particulate Matter in B.C - Vanderhoof Courthouse",
           xaxis=list(title=" "),
           yaxis=list(title="Daily Average PM2.5<br>(micrograms per cubic meter)")
    )
  
})