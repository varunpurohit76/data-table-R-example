library(shiny)

# Define the overall UI
shinyUI(
  fluidPage(
    titlePanel("DataTable"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
      column(4,
             selectInput("cat",
                         "Category:",
                         c("All",
                           unique(as.character(y$category))))
      ),
      column(4,
             dateInput('date_from',
                       label = 'From:',
                       value = "2016-01-01"
             )
      ),
      column(4,
             dateInput('date_till',
                       label = 'Till:',
                       value = Sys.Date()
             )
      )
      
      #,
      #column(4,
      #       selectInput("Sess",
      #                   "Sessions:",
      #                   c("All",
      #                     unique(as.character(y$Sessions))))
      #)
    ),
    # Create a new row for the table.
    fluidRow(
      DT::dataTableOutput("table")
    )
  )
)