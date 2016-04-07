
# map 
output$ozone_sitesMap <- renderLeaflet({
  
  popup <- paste0(ozone_sites$name, "<br>", "Av Rate 2011-2013: ", ozone_sites$value)
  pal <- colorNumeric(
    palette = "Reds",
    domain = ozone_sites$value
  )
  
  map <-ozone_sites %>% 
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
  click<-input$ozone_sitesMap_marker_click
  if(is.null(click))
    return()
  
  print(Sys.time())
  
  output$ozone_ts <- renderPlotly({
    
   site <- ozone_df_date %>%
      filter(ems_id==click$id) 
 
   meanValue <- round(mean(site$avVal,na.rm=T),1)
   siteName <- site$site[1]
   
  # write_csv(site,"testsite.csv")
   
   site   %>%
     plot_ly(x=date,y=avVal,mode="lines",color=as.factor(year),
             line=list(width=1),
             hoverinfo = "text",
             text = paste(date,"<br>Value:",avVal))  %>%
     
     
     add_trace(y = c(63, 63), x= c(min(date), max(date)),
               mode = "lines", line = list(color = "blue",width=1,dash="10px"),
               name="Standard") %>%
    
     
     add_trace(y = c(meanValue, meanValue), x= c(min(date), max(date)),
               mode = "lines", line = list(color = "red",width=2),
               name="Average") %>%
     
     layout(hovermode = "closest",
            title=paste0("Ground-level ozone in B.C - ",siteName),
            xaxis=list(title=" "),
            yaxis=list(title="Daily Average 63 parts per billion.")
     )

  })
  
  
  output$ozone_days <- renderPlotly({
    
    site <- ozone_df_date %>%
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
      filter(avVal>=63) %>% 
      group_by(year) %>% 
      tally() %>% 
      rename(bad=n) %>% 
      right_join(allDays) %>% 
      mutate(bad=ifelse(is.na(bad),0,bad),pc=round(100*bad/all,1)) %>% 
      plot_ly(x=year,y=pc,type="bar",marker = list(color = toRGB("red")))  %>%
      layout(hovermode = "closest",
             title=paste0("Ground-level ozone in B.C - ",siteName),
             xaxis=list(title=" "),
             yaxis=list(title="% days exceeding 24hr av of 63 parts per billion")
             
      )
  })  
    output$ozone_months <- renderPlotly({
      
      site <- ozone_df_month %>%
        filter(ems_id==click$id) 
      
      print(glimpse(site))
      siteName <- site$site[1]
      
      site %>% 
       # group_by(month,year) %>% 
        # summarize(avVal=round(mean(value,na.rm=T),1)) %>% 
        group_by(year) %>% 
        plot_ly(x=month,y=avVal,mode="lines+markers",color=as.factor(year),
                hoverinfo = "text",
                text = paste0(month,", ",year,"<br>Value:",avVal)) %>%
        layout(hovermode = "closest",
               title=paste0("Ground-level ozone in B.C - ",siteName),
               xaxis=list(title=" "),
               yaxis=list(title="Average Value")
        )
  })
    
    output$ozone_hours <- renderPlotly({
      
      site <- ozone_df_hour %>%
        filter(ems_id==click$id) 
      
      print(glimpse(site))
      siteName <- site$site[1]
      
      site %>% 
        # group_by(hour,year) %>% 
        # summarize(avVal=round(mean(value,na.rm=T),1)) %>% 
        group_by(year) %>% 
        plot_ly(x=hour,y=avVal,mode="lines+markers",color=as.factor(year),
                hoverinfo = "text",
                text = paste0(hour,", ",year,"<br>Value:",avVal)) %>%
        layout(hovermode = "closest",
               title=paste0("Ground-level ozone in B.C - ",siteName),
               xaxis=list(title="24-hour Time"),
               yaxis=list(title="Average Value")
        )
    })
  
  
})

