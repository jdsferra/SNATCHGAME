library(shiny)
library(shinydashboard)
library(tidyverse)
library(scales)

bigjoin1 <- read.csv(file = "./bigjoin1.csv")
bigjoin2 <- read.csv(file = "./bigjoin2.csv")

bigjoin1$airdate <- as.Date(bigjoin1$airdate)
bigjoin2$airdate <- as.Date(bigjoin2$airdate)

bigjoin1$regas <- as.factor(bigjoin1$regas)
bigjoin2$regas <- as.factor(bigjoin2$regas)

bigjoin1$internat <- as.factor(bigjoin1$internat)
bigjoin2$internat <- as.factor(bigjoin2$internat)

bigjoin1$specialformat <- as.factor(bigjoin1$specialformat)
bigjoin2$specialformat <- as.factor(bigjoin2$specialformat)

bigjoin1$alive <- as.factor(bigjoin1$alive)
bigjoin2$alive <- as.factor(bigjoin2$alive)

bigjoin1$genres <- as.factor(bigjoin1$genres)
bigjoin2$genres <- as.factor(bigjoin2$genres)

bigjoin1$tsb <- factor(bigjoin1$tsb, levels = c('ELIM', 'BOTTOM', 'SAFE', 'HIGH', 'WIN'))
bigjoin2$tsb <- factor(bigjoin2$tsb, levels = c('ELIM', 'BOTTOM', 'SAFE', 'HIGH', 'WIN'))