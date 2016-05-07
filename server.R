# Coursera - Developing Data Products- Course Project 
# server.R file for the shiny app 
# This app was developed to help people choose the best car based on
# MPG and transmission types  
# using mtcars dataset. 

library(shiny) 
library(datasets) 
library(dplyr) 
 
shinyServer(function(input, output) { 
   # Cars displayed as per choosen chracteristics
       output$table <- renderDataTable({ 
             disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1) 
             hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1) 
             data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg,  
                               Transmission = am, Cylinders = cyl, Displacement = disp, Horsepower = hp,  
                              Transmission = am) 
             data <- filter(data, Cylinders %in% input$cyl,  
                           Displacement %in% disp_seq, Horsepower %in% hp_seq, 
                           Transmission %in% input$am)
             data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual")) 
             data <- arrange(data, Transmission)
             data 
         }, options = list(lengthMenu = c(5, 15, 30), pageLength = 30)) 
            output$Plot <- renderPlot(boxplot(mpg ~ am, data = mtcars, col = (c("green","blue")), 
                                         ylab = "Miles Per Gallon", 
                                         xlab ="Transmission Type"))
       
       
   }) 


