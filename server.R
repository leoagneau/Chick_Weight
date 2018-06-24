library(shiny)
library(ggplot2)

# Define server logic required to fit the model, plot the graph and output the weight
shinyServer(function(input, output) {
  mod <- list()
  pred <- list()
  mod[[1]] <- lm(weight ~ Time , data=ChickWeight[ChickWeight$Diet==1,c(1,2)])
  mod[[2]] <- lm(weight ~ Time , data=ChickWeight[ChickWeight$Diet==2,c(1,2)])
  mod[[3]] <- lm(weight ~ Time , data=ChickWeight[ChickWeight$Diet==3,c(1,2)])
  mod[[4]] <- lm(weight ~ Time , data=ChickWeight[ChickWeight$Diet==4,c(1,2)])
  
  pred[[1]] <- reactive({
    predict(mod[[1]], newdata = data.frame(Time = input$days))
  })
  pred[[2]] <- reactive({
    predict(mod[[2]], newdata = data.frame(Time = input$days))
  })
  pred[[3]] <- reactive({
    predict(mod[[3]], newdata = data.frame(Time = input$days))
  })
  pred[[4]] <- reactive({
    predict(mod[[4]], newdata = data.frame(Time = input$days))
  })
  
  output$wtPred <- renderText({
    paste(round(pred[[as.numeric(input$diet)]](),2), "grams")
  })
  
  output$plot1 <- renderPlot({
    id = as.numeric(input$diet)
    g = ggplot(ChickWeight[ChickWeight$Diet==id,c(1,2)], aes(Time, weight)) + geom_point(size=3, alpha=0.1)
    g = g + geom_smooth(method="lm")
    g = g + geom_point(data=data.frame(Time=input$days, weight=pred[[id]]()), colour = "brown", size=5, shape=17)
    g
  })
  
})
