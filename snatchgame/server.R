shinyServer(function(input, output) {
#  flights_delay <- reactive({
#    flights %>%
#      filter(origin == input$origin & dest == input$dest) %>%
#      group_by(carrier) %>%
#      summarise(n = n(),
#                dep = mean(dep_delay),
#                arr = mean(arr_delay)
#      )
#  })
  
genrecheck1 <- reactive({
  bigjoin1 %>%
    distinct(uniqueid, season, internat, queen, character, tsb, score, genres) %>%
    filter(genres %in% c(input$genre1, input$genre2))
})

output$bar1 <- renderPlot(
  genrecheck1() %>% group_by(genres) %>% mutate(genre_count = n(), avgscore = round(mean(score), 3)) %>%
    ungroup() %>% mutate(genre_update = paste0(genres, "; n=", genre_count, "; Mean Score: ", avgscore)) %>%
    ggplot(aes(x = tsb, fill = genres)) + geom_bar()+ scale_y_continuous(breaks= pretty_breaks()) + 
    scale_fill_manual(values = c("#8344AD", "#27AE60")) + facet_wrap(~genre_update) +
    labs(title = 'Genre Comparison by Count', x = 'Placement', y = 'Count')
)
  
output$freq1 <- renderPlot(
  genrecheck1() %>% group_by(genres) %>% mutate(weight = 1/n()) %>%
         ggplot(aes(x = tsb, fill = genres)) + geom_bar(aes(weight = weight), stat = 'count', position = 'dodge') + 
    scale_fill_manual(values = c("#8344AD", "#27AE60")) +
    labs(title = 'Genre Comparison by Percentage', x = 'Placement', y = 'Percentage')
)  
  
  
  
  
  output$count <- renderPlot(
    flights_delay() %>%
      ggplot(aes(x = carrier, y = n)) +
      geom_col(fill = "lightblue") +
      ggtitle("Number of flights")) 
  
  output$delay <- renderPlot(
    flights_delay() %>% pivot_longer(arr:dep, names_to = 'type', values_to = 'delay') %>%
      ggplot() + geom_col(aes(x = carrier, y = delay, fill = type), position = 'dodge')
  )
  
  output$table <- renderTable(flights %>% filter(origin == input$origin & dest == input$dest))

#don't touch brackets below the line    
})