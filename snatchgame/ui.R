dashboardPage(skin = 'purple', dashboardHeader(title='Who Should I Play on the Snatch Game?', titleWidth = 380),

#Sidebar Items              
dashboardSidebar( sidebarUserPanel("Joe Sferra: NYCDSA",
                                   image = './NYCDSA.png' ),
  sidebarMenu(
      menuItem("Intro", tabName = 'intro', icon = icon("house")),
      menuItem("Compare Specific", tabName = "spec", icon = icon("magnifying-glass-plus")),
      menuItem("Compare General", tabName = "gen", icon = icon("magnifying-glass-minus")),
      menuItem("Heavier Stats", tabName = 'heavystats', icon = icon("gears")),
      menuItem("Dead vs. Alive", tabName = 'doa', icon = icon("skull")),
      menuItem("About Me", tabName = 'me', icon = icon("address-book") )
)),

#Dashboard Body              
dashboardBody(
    tabItems(
            #Welcome
        tabItem(tabName = 'intro', h1('A Deep Dive Into Snatch Game Results', style='text-align:center'),
                                   h5("This app compares how different kinds of characters perform in the 'Snatch Game' episodes\
              of RuPaul's Drag Race, including all worldwide English-language seasons and All-Stars formats."),
                                   h5("How do fashion icons fare against musicians? Are the Golden Girls cursed? Answer these questions and more!"),
                                   h5("Placements are ranked as ELIMINATED, BOTTOM, SAFE, HIGH, WIN and are scored -1, -.5, 0, .5, and 1.\
                                   An average score that's positive means that that category does well, while negative means the group is often\
                                   in the bottom or eliminated."),
                                   h3(strong('How it Works')),
                                   h5("'Compare Specific' and 'Compare General' allows you to select two genres of character and compare\
                                        their placements. 'Specific' features ~30 genres while 'General' groups them into 10.\
                                        When you select two genres, the page displays two plots, one comparing placements by count, and\
                                        one underneath comparing in terms of percentages, plus the table with the plotted queens."),
                                  h4(strong('Specific')),
                                  h5("In the specific grouping, characters have two or three genre labels, including 'Actor', 'Drag Queen', 'Reality',\
                                     and others. 'RH' and 'GG' are special labels for Real Housewives and Golden Girls, characters suspected to be\
                                     cursed."),
                                  h4(strong('General')),
                                  h5("In the general grouping, characters mostly only have one, more 'zoomed-out' label:"),
                                  tags$ul(
                                  tags$li("TV Presenters: 'TV'"), 
                                  tags$li("Comedic Entertainers: 'ComedicEnt'"), 
                                  tags$li("Non-Comedic Entertainers: 'NonComedicEnt'"),
                                  tags$li("Public Figures and News Stories: 'PubFig'"),
                                  tags$li("Streamers, YouTubers, and Viral Stars: 'Internet'"),
                                  tags$li("Historical, Fictional, and Religious: 'HistFict'"),
                                  tags$li("Drag Queens, Performance Artists, and Others Hard to Categorize: 'FarOut'"),
                                  tags$li("Musicians"),
                                  tags$li("Fashion Icons"),
                                  tags$li("Writers"),
                                ),
                                  h4(strong('Remaining Tabs')),
                                  h5("The remaining tabs include the results of pairwise t-testing on the more general grouping, a comparison between\
                                  dead and alive characters, and my contact information. Keep in touch, and let me know what you think!"),
                                  div(img(src='pride.jpg', width="100%", style= "height: 100px" ), style="text-align: left"),
                                  h6("Image by rawpixel.com on Freepik")
                              ),
                  
            #Compare Specific
         tabItem(tabName = 'spec', h2('Compare Specific Genres'),
                sidebarLayout(
                  sidebarPanel(
                    selectizeInput('genre1', "Genre 1", choices=unique(bigjoin1$genres)),
                    selectizeInput('genre2', "Genre 2", choices=unique(bigjoin1$genres)),
                  width = 4),
                            
                mainPanel(
                  fluidRow(column(12, plotOutput('bar1')),
                        ),
                  fluidRow(column(12, plotOutput('freq1'))
                        ),
                  fluidRow(column(12, tableOutput('table1'))
                        )
                )
              )
            ),
        tabItem(tabName = 'gen', h2('Compare General Genres'),
                sidebarLayout(
                  sidebarPanel(
                    selectizeInput('general1', "Genre 1", choices = unique(bigjoin2$genres)),
                    selectizeInput('general2', "Genre 2", choices = unique(bigjoin2$genres)),
                  width = 4),
                  
                mainPanel(
                  fluidRow(column(12, plotOutput('bar2')),
                       ),
                  fluidRow(column(12, plotOutput('freq2'))
                       ),
                  fluidRow(column(12, tableOutput('table2'))
                        )
                )
              )
              ),
        tabItem(tabName = 'heavystats', h2('Heavier Statistics'),
                h5("While results from doing statistical testing (pairwise t-testing) on the specific categories are inconclusive,
                   the more-general categories lead to some better results."),
                h5("Take a look at this table, which features unadjusted p-values from pairwise t-testing rounded to two decimal\
                places. If the value at the intersection of the two categories is less than .05, that means that there is a less than\
                5% chance that the difference in how these two groups perform is due to random chance. Give these pairings a closer\
                look!"),
                
                mainPanel(
                  fluidRow(column(12, tableOutput('ttest')))
                    )),
        
        tabItem(tabName = 'doa', h2('Dead or Alive?'),
                h5("The majority of contestants portray characters who were alive at the time of their first appearance.\
                    Playing a dead person has a statistical advantage, though! By comparing the dead and alive average score with the\
                    Welch Two Sample T-test, we get a p-value of:", span(uiOutput("thisval"), style = "display: inline;")),
                h5("A value less than .05 means we have a statistically-significant difference between the performance of the dead and alive.\
                    On the fence about who to play? Play a dead person!"
                   ),
                
                mainPanel(
                  fluidRow(column(12, plotOutput('doabar')),
                      ),
                  fluidRow(column(12, plotOutput('doafreq'))
                      ),
                )
              ),
        
        tabItem(tabName = 'me', h2("Joe Sferra"),
                div(img(src='Joe Sferra Headshot.jpg', height="40%", width="40%"), style="text-align: left;"),
                h5("I'm excited about taking my creative problem-solving and storytelling skills that I've developed\
                   as a musician and college professor into the data science world. I love games, puzzles, jokes, and learning something new!"),
                strong('Find Me On:'),
                uiOutput('tab1'),
                uiOutput('tab2'),
                uiOutput('tab3')
              )
        )
    )
  )
