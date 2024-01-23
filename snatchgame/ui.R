library(shinydashboard)
dashboardPage(skin = 'purple',
  dashboardHeader(title='Who Should I Play on the Snatch Game?', titleWidth = 380),
  
  dashboardSidebar( sidebarUserPanel("Joe Sferra: NYCDSA",
                                     image = './NYCDSA.png' ),
                    sidebarMenu(
                      menuItem("Plots", tabName = "plots", icon = icon("truck-monster")),
                      menuItem("Data", tabName = "data", icon = icon("database"))
                    ),
                    
                    selectizeInput(inputId='origin',label='Departure Airport',
                                   choices=unique(flights$origin),
                                   selected=unique(flights$origin)[1]),
                    selectizeInput("dest", "Arrival Airport",
                                   choices=unique(flights$dest))
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = 'plots', fluidRow(
        column(5, plotOutput("count")),
        column(7, plotOutput("delay")) )),
      
      tabItem(tabName = 'data', tableOutput("table")) )
  )
)