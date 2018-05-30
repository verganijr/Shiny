# Coursera - Developing Data Products- Course Project

# server.R file for the shiny app

# This app was developed to help people to select car basded on available filters 
# using mtcars dataset, from [R]

library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {

    # Show the cars that correspond to the filters
    output$table <- renderDataTable({
        disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
        hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
        mpg_seq <- seq(from = input$MilesPerGallon[1], to = input$MilesPerGallon[2], by = 0.1)
        data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                          Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                          Transmission = am)
        data <- filter(data, Cylinders %in% input$cyl, 
                       Displacement %in% disp_seq, Horsepower %in% hp_seq, MilesPerGallon %in% mpg_seq, Transmission %in% input$am)
        data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
        data <- arrange(data)
        data
    }, options = list(lengthMenu = c(5, 10, 15, 20, 30), pageLength = 30))
})