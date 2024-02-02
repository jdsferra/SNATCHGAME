dashboardPage(skin = 'purple',
  dashboardHeader(title='Who Should I Play on the Snatch Game?', titleWidth = 380),
  
  dashboardSidebar( sidebarUserPanel("Joe Sferra: NYCDSA",
                                     image = './NYCDSA.png' ),
                    sidebarMenu(
                      menuItem("Intro", tabName = 'intro', icon = icon("house")),
                      menuItem("Compare Specific", tabName = "spec", icon = icon("magnifying-glass-plus")),
                      menuItem("Compare General", tabName = "data", icon = icon("magnifying-glass-minus")),
                      menuItem("Heavier Stats", tabName = 'heavystats', icon = icon("gears")),
                      menuItem("Dead vs. Alive", tabName = 'doa', icon = icon("skull")),
                      menuItem("Queens to Study", tabName = 'mvp', icon = icon("crown") )
                    )),
                    


  
  dashboardBody(
    tabItems(
      #Welcome
      tabItem(tabName = 'intro',
              h1('A Deep Dive Into Snatch Game Results',
                 style='text-align:center'),
              h5("This app compares how different kinds of characters perform in the 'Snatch Game' episodes\
              of RuPaul's Drag Race, including all worldwide English-language seasons and All-Stars formats."),
              h5("How do fashion icons fare against musicians? Are the Golden Girls cursed? Answer these questions and more!"),
              h5("Placements are ranked as ELIMINATED, BOTTOM, SAFE, HIGH, WIN and are scored -1, -.5, 0, .5, and 1."),
              h3('How it Works'),
              h5("'Compare Specific' and 'Compare General' allows you to select two genres of character and compare\
                  their placements. 'Specific' features ~30 genres while 'General' groups them into\
                 11 categories."),
              div(img(src='pride.jpg', width="100%", style= "height: 100px" ), style="text-align: left"),
              h6("Image by rawpixel.com on Freepik")
              ),
    
    #Compare Specific
      tabItem(tabName = 'spec', h2('Compare Specific Genres'),
              sidebarLayout(
                sidebarPanel(
                  
                  selectizeInput('genre1', "Genre1", choices=unique(bigjoin1$genres)),
                  selectizeInput('genre2', "Genre2", choices=unique(bigjoin1$genres)),
                
                ),

              mainPanel(
                fluidRow(
                  column(12, plotOutput('bar1')),
                  ),
                fluidRow(
                  column(12, plotOutput('freq1'))
                )

#don't touch below here
)
)
))))