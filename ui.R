library(shiny)

# Define UI for application that draws the control pane,
# the data, regression line, and display the weight.
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict chick weight from diet type and age (in days)"),
  
  # A radio buttons group for choosing diet type
  # and a slidebar with a slider input for number of days
  sidebarLayout(
    sidebarPanel(
       radioButtons("diet",
                    "Diet type:",
                    c(1, 2, 3, 4),
                    inline = TRUE),
       sliderInput("days",
                   "Number of days since birth:",
                   min = 2,
                   max = 21,
                   value = 10)
    ),
    
    # Show a plot of the dataset, regression line and the weight
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Chick Weight", br(),
                          plotOutput("plot1"),
                          h3("Predicted chick weight is:"),
                          textOutput("wtPred")
                  ),
                  tabPanel("About", 
                    h4("Summary:"),
                    "This application fits simple linear regression models of body weight of chicks on the number of days since birth, to show the effects on growth of chicks of different diets.   There are 4 different models can be fitted based on the 4 different experimental diets the chick received.",
                    h4("Usage:"),
                    "The left hand side of the application contains two modules for user to select: 1. Diet type, and 2. Number of days since chick's birth.
The Diet type radio button controls which set of data is going to be fitted for the linear regression model.  The slider bar lets user to predict the body weight of a chick on the selected number of days since birth and receiving specific diet.
The right pane shows the corresponding data points of the chosen diet type, the regression line, and the predicted body weight represented by a brown triangle.
Finally, the predicted weight is also shown below the graph for easy interpretation."
                  )
      )
       
    )
  )
))
