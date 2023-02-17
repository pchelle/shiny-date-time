library(shiny)

ui <- fluidPage(
  br(),
  dateInput(
    inputId = "date",
    label = span(icon("calendar"), "Date"),
    # Current Date as initial value
    value = Sys.Date(),
    format = "yyyy-mm-dd"
  ),
  br(),
  # Use columns to get hour and minutes in same row
  column(4, selectInput(
    inputId = "hour",
    label = span(icon("clock"), "Hour"),
    choices = gsub(pattern = " ", replacement = "0", x = format(seq(0, 23), width = 2)),
    # Current Time as initial value
    selected = format(Sys.time(), "%H")
  )),
  # Use columns to get hour and minutes in same row
  column(4, selectInput(
    inputId = "min",
    label = "Minutes",
    choices = gsub(pattern = " ", replacement = "0", x = format(seq(0, 59), width = 2)),
    # Current Time as initial value
    selected = format(Sys.time(), "%M")
  )),
  br(),
  strong("Output Date and Time"),
  br(),
  verbatimTextOutput("dateTimeOutput")
)

server <- function(input, output, session) {
  output$dateTimeOutput <- renderText({
    displayDate <- as.POSIXlt(input$date, tz = "GMT", format = "%Y-%m-%d")
    displaytime <- paste0(input$hour, ":", input$min)
    paste(displayDate, displaytime)
  })
}

shinyApp(ui, server)
