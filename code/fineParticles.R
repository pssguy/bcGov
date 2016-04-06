
# map 
output$sitesMap <- renderLeaflet({
  
  popup <- paste0(sites$name, "<br>", "Av Rate 2011-2013: ", sites$value)
  pal <- colorNumeric(
    palette = "Reds",
    domain = sites$value
  )
  
  map <-sites %>% 
    leaflet()  %>% 
    addTiles() %>% 
    #addProviderTiles("MapQuestOpen.Aerial") %>%
    addCircleMarkers(color = ~pal(value),  # cannot use color with addMarkers
                     popup = popup,
                     stroke=FALSE,
                     fillOpacity = 1,
                     radius=5,
                     layerId=~ems_id)
  map
})

## wrap ineractive outputs in observe



observe({
  click<-input$sitesMap_marker_click
  if(is.null(click))
    return()
  
  print(Sys.time())
  
  output$fp_ts <- renderPlotly({
    
   site <- fp_df_date %>%
      filter(ems_id==click$id) 
 
   meanValue <- round(mean(site$avVal,na.rm=T),1)
   siteName <- site$site[1]
   
  # write_csv(site,"testsite.csv")
   
   site   %>%
     plot_ly(x=date,y=avVal,mode="lines",color=as.factor(year),
             line=list(width=1),
             hoverinfo = "text",
             text = paste(date,"<br>Value:",avVal))  %>%
     
     
     add_trace(y = c(10, 10), x= c(min(date), max(date)),
               mode = "lines", line = list(color = "blue",width=1,dash="10px"),
               name="Annual <br> Standard") %>%
     add_trace(y = c(28, 28), x= c(min(date), max(date)),
               mode = "lines", line = list(color = "green",width=1,dash="10px"),
               name="Daily <br> Standard") %>%
     
     add_trace(y = c(meanValue, meanValue), x= c(min(date), max(date)),
               mode = "lines", line = list(color = "red",width=2),
               name="Average") %>%
     
     layout(hovermode = "closest",
            title=paste0("Status of Fine Particulate Matter in B.C - ",siteName),
            xaxis=list(title=" "),
            yaxis=list(title="Daily Average PM2.5<br>(micrograms per cubic meter)")
     )

  })
  
  
  output$fp_days <- renderPlotly({
    
    site <- fp_df_date %>%
      filter(ems_id==click$id) 
    
   print(glimpse(site))
    siteName <- site$site[1]
  
    print("in")
    allDays <- site %>% 
      group_by(year) %>% 
      tally() %>% 
      rename(all=n)
      
      print("out")
      print(glimpse(allDays))
    
    site %>% 
      group_by(date,year) %>% 
     # filter(value>-1&year>2008) %>% # exclude partial data
     # summarize(avVal=round(mean(value,na.rm=T),1)) %>% 
      filter(avVal>=28) %>% 
      group_by(year) %>% 
      tally() %>% 
      rename(bad=n) %>% 
      right_join(allDays) %>% 
      mutate(bad=ifelse(is.na(bad),0,bad),pc=round(100*bad/all,1)) %>% 
      plot_ly(x=year,y=pc,type="bar",marker = list(color = toRGB("red")))  %>%
      layout(hovermode = "closest",
             title=paste0("Status of Fine Particulate Matter in B.C - ",siteName),
             xaxis=list(title=" "),
             yaxis=list(title="% days exceeding 24hr av of 28 µg/ cubic metre")
             
      )
    
  })
  
  
})

