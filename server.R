library(shiny)
library(DT)

y <-read.csv('x.csv', header=TRUE, skip = 6)
y <- subset(y, select=c(Landing.Page, Date, Sessions, Goal.Completions, Goal.Conversion.Rate))
y$Date<-as.character(y$Date)
y$Date <- as.Date(y$Date, format = '%Y %m %d')


y$category <- "others"

for ( i in 1:nrow(y))
{
  if(length(grep('^/$', y$Landing.Page[i])))
  {
    y$category[i] <- "home"
  }
}

for ( i in 1:nrow(y))
{
  if(length(grep('/projects/', y$Landing.Page[i])))
  {
    y$category[i] <- "projects"
  }
}

for ( i in 1:nrow(y))
{
  if(length(grep('/blog/', y$Landing.Page[i])))
  {
    y$category[i] <- "blog"
  }
}

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    #print(input$date_from)
    #print(input$date_till)
    data <- subset(y, Date >  as.Date(input$date_from) & Date < as.Date(input$date_till))
    if (input$cat != "All") {
      data <- data[data$category == input$cat,]
    }
    #if (input$Sess != "All") {
    #  data <- data[data$Sessions == input$Sess,]
    #}
    data$category <- NULL
    data
  }))
  
})