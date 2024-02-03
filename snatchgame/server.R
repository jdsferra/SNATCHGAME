shinyServer(function(input, output) {

#reactive functions
genrecheck1 <- reactive({
  bigjoin1 %>%
    distinct(uniqueid, season, internat, queen, character, tsb, score, genres) %>%
    filter(genres %in% c(input$genre1, input$genre2))
})

genrecheck2 <- reactive({
  bigjoin2 %>%
    distinct(uniqueid, season, internat, queen, character, tsb, score, genres) %>%
    filter(genres %in% c(input$general1, input$general2))
})

#specific work
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
  
output$table1 <- renderTable(genrecheck1() %>% group_by(genres) %>% select(-1))

#general work
output$bar2 <- renderPlot(
  genrecheck2() %>% group_by(genres) %>% mutate(genre_count = n(), avgscore = round(mean(score), 3)) %>%
    ungroup() %>% mutate(genre_update = paste0(genres, "; n=", genre_count, "; Mean Score: ", avgscore)) %>%
    ggplot(aes(x = tsb, fill = genres)) + geom_bar()+ scale_y_continuous(breaks= pretty_breaks()) + 
    scale_fill_manual(values = c("#8344AD", "#27AE60")) + facet_wrap(~genre_update) +
    labs(title = 'Genre Comparison by Count', x = 'Placement', y = 'Count')
)

output$freq2 <- renderPlot(
  genrecheck2() %>% group_by(genres) %>% mutate(weight = 1/n()) %>%
    ggplot(aes(x = tsb, fill = genres)) + geom_bar(aes(weight = weight), stat = 'count', position = 'dodge') + 
    scale_fill_manual(values = c("#8344AD", "#27AE60")) +
    labs(title = 'Genre Comparison by Percentage', x = 'Placement', y = 'Percentage')
)  

output$table2 <- renderTable(genrecheck2() %>% group_by(genres) %>% select(-1))

#heavier stats
pwjoin <- bigjoin2 %>% distinct(uniqueid, season, internat, queen, character, tsb, score, genres)
pw <- pairwise.t.test(pwjoin$score, pwjoin$genres, p.adj= 'none')
pwtt <- data.table(pw[['p.value']], keep.rownames = T) %>% rename(X = rn) %>% mutate_if(is.numeric, ~round(., 4))
pwtt[is.na(pwtt)] <- ""
output$ttest <- renderTable(pwtt)

#DEAD OR ALIVE
deadalivecheck <- bigjoin2 %>% distinct(uniqueid, character, tsb, score, alive)

output$doabar <- renderPlot(deadalivecheck %>% group_by(alive) %>% mutate(avgscore = round(mean(score), 3)) %>%
  ungroup() %>% mutate(alive_update = paste0("Mean Score: ", avgscore)) %>% ggplot(aes(x = tsb, fill = alive)) + 
  scale_fill_manual(values = c("#8344AD", "#27AE60"), name = "", labels=c('dead', 'alive')) + geom_bar()+ 
  scale_y_continuous(breaks= pretty_breaks()) + facet_wrap(~alive_update) + 
  labs(title = "Dead Characters' Advantage is Statistically Significant", x = 'Placement', y = 'Count')
  )

output$doafreq <- renderPlot(deadalivecheck %>% group_by(alive) %>% mutate(weight = 1/n()) %>%
  ggplot(aes(x = tsb, fill = alive)) + geom_bar(aes(weight = weight), stat = 'count', position = 'dodge') +
  scale_fill_manual(values = c("#8344AD", "#27AE60"), name = "", labels = c('dead', 'alive')) +
  labs(title = 'Breakdown by Percentage', x = 'Placement', y = 'Percentage')
  )

allalive <- deadalivecheck %>% filter(alive == 1)
alldead <- deadalivecheck %>% filter(alive == 0)
mydoa <- t.test(alldead$score, allalive$score)
output$thisval <- renderText(round(mydoa[['p.value']], 4))

#About Me

linkedin = a("LinkedIn", href="https://linkedin.com/in/joe-sferra/")
github = a("GitHub", href="https://github.com/jdsferra")
blog = a("NYCDSA Blog", href="https://nycdatascience.com/blog/author/jdsferra/")

output$tab1 <- renderUI({
  tagList(linkedin)
})

output$tab2 <- renderUI({
  tagList(github)
})

output$tab3 <- renderUI({
  tagList(blog)
})




#don't touch brackets below the line    
})