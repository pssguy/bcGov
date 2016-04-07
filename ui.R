

dashboardPage(skin="yellow",
  dashboardHeader(title = "BC Data"),
  
  dashboardSidebar(title = "BC Data",
   # includeCSS("custom.css"),
   # uiOutput("a"),
    
    sidebarMenu(id = "sbMenu",
      
      menuItem("Air Quality",
               
               menuSubItem("Fine Particles", tabName = "fineparticles"),
               menuSubItem("Ozone", tabName = "ozone", selected=T)
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
      fluidRow(
        column(
          width = 6,
          box( width=12,
               # status = "info", solidHeader = TRUE,
               # title = "Map - click on Circle for Info and Charts",
               includeMarkdown("about/fineParticles.md")
          ),    
      box( width=12,
          status = "success", solidHeader = TRUE,
          title = "Map - click on Circle for Info and Charts",
          leafletOutput("fp_sitesMap")
      )),
      column(
        width = 6,
      box(width=12,
        status = "success", solidHeader = TRUE,
        collapsible = T,collapsed = F,
         title = "Daily Averages Fine Particular Matter - Zoom and Hover for details",
         plotlyOutput("fp_ts")
      ),
      box(width=12,
          status = "success", solidHeader = TRUE,
          collapsible = T,collapsed = T,
          title = "% Days Exceeding Standards",
          plotlyOutput("fp_days")
        
      ),
      box(width=12,
          status = "success", solidHeader = TRUE,
          collapsible = T,collapsed = T,
          title = "Monthly Variation",
          plotlyOutput("fp_months")
          
      ),
      box(width=12,
          status = "success", solidHeader = TRUE,
          collapsible = T,collapsed = T,
          title = "Hourly Variation",
          plotlyOutput("fp_hours")
          
      )
    )
      )
    ),
    
    tabItem(
      "ozone",
      fluidRow(
        column(
          width = 6,
          box( width=12,
               # status = "info", solidHeader = TRUE,
               # title = "Map - click on Circle for Info and Charts",
               includeMarkdown("about/ozone.md")
          ),    
          box( width=12,
               status = "success", solidHeader = TRUE,
               title = "Map - click on Circle for Info and Charts",
               leafletOutput("ozone_sitesMap")
          )),
        column(
          width = 6,
          box(width=12,
              status = "success", solidHeader = TRUE,
              collapsible = T,collapsed = F,
              title = "Daily Averages Fine Particular Matter - Zoom and Hover for details",
              plotlyOutput("ozone_ts")
          ),
          box(width=12,
              status = "success", solidHeader = TRUE,
              collapsible = T,collapsed = T,
              title = "% Days Exceeding Standards",
              plotlyOutput("ozone_days")
              
          ),
          box(width=12,
              status = "success", solidHeader = TRUE,
              collapsible = T,collapsed = T,
              title = "Monthly Variation",
              plotlyOutput("ozone_months")
              
          ),
          box(width=12,
              status = "success", solidHeader = TRUE,
              collapsible = T,collapsed = T,
              title = "Hourly Variation",
              plotlyOutput("ozone_hours")
              
          )
        )
      )
    )
    


    
  # tabItem("info",includeMarkdown("info.md"))
    
  ))
)
