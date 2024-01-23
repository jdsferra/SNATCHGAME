shinyServer(function(input, output) {
  flights_delay <- reactive({
    flights %>%
      filter(origin == input$origin & dest == input$dest) %>%
      group_by(carrier) %>%
      summarise(n = n(),
                dep = mean(dep_delay),
                arr = mean(arr_delay)
      )
  })
  
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
  
})