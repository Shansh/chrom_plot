library(shiny)

shinyUI(pageWithSidebar(
        headerPanel(
                "Chromatography Plot"
                ),
        
        sidebarPanel(
                fileInput("file1", "Choose your csv dataset", accept = c(
                        "text/csv", "text/comma-separated-values", ".csv")),
                sliderInput("time", "Time range", min = 0, 
                            max = 120, value = c(5, 50), step = 5),
                sliderInput("abundance", "Abundance", min = 0, 
                            max = 2000, value = 700, step = 100),
                numericInput("resolution", label = "Resolution", value = 300, min = 300, max = 1200, step = 300,
                             width = NULL),
                textInput("y_cap", label = "Abundance string", value = "mAU"),
                numericInput("width", label = "Plot width [px]", value = 4000, step = 100),
                numericInput("height", label = "Plot height [px]", value = 2000, step = 100),
                downloadButton('downloadPlot', 'Download Plot')
                ),
        
        mainPanel(
                plotOutput("plot")
                )
        )
)

