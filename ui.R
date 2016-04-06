

dashboardPage(skin="yellow",
  dashboardHeader(title = "BC Data"),
  
  dashboardSidebar(title = "BC Data",
   # includeCSS("custom.css"),
   # uiOutput("a"),
    
    sidebarMenu(id = "sbMenu",
      
      menuItem("Environmental",
               menuSubItem("Fine Particles", tabName = "fineparticles", selected=T)
      ),
      
      
      tags$hr(),
      menuItem(text="",href="https://mytinyshinys.shinyapps.io/dashboard",badgeLabel = "All Dashboards and Trelliscopes (14)"),
      tags$hr(),
      
      tags$body(
        a(class="addpad",href="https://twitter.com/pssGuy", target="_blank",img(src="images/twitterImage25pc.jpg")),
        a(class="addpad2",href="mailto:agcur@rogers.com", img(src="images/email25pc.jpg")),
        a(class="addpad2",href="https://github.com/pssguy",target="_blank",img(src="images/GitHub-Mark30px.png")),
        a(href="https://rpubs.com/pssguy",target="_blank",img(src="images/RPubs25px.png"))
      )
    )
  ),
  
  dashboardBody(tabItems(
    tabItem(
      "fineparticles",
      box(
          status = "success", solidHeader = TRUE,
          title = "Map - click on Circle for Info and Charts",
          leafletOutput("sitesMap"),
          verbatimTextOutput("Click_text")
      ),
      
      box(
        status = "success", solidHeader = TRUE,
         title = "Daily Averages Fine Particular Matter - Hover Points/Bars for details",
         plotlyOutput("fp_ts")
      ),
      box(
          status = "success", solidHeader = TRUE,
          title = "Days Exceeding Standards"
        
      )
    )


    
  # tabItem("info",includeMarkdown("info.md"))
    
  ))
)
