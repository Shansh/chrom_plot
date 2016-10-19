library(shiny)
library(ggplot2)

options(shiny.maxRequestSize = 10*1024^2)

shinyServer(function(input, output) {
        
        plotInput <- reactive({
                
                infile <- input$file1
                if (is.null(infile)) {
                        return(NULL)
                }
                
                df <- read.csv(infile$datapath)
                df <- df[complete.cases(df),]
                names(df) <- c("time", "signal")
                
                insert_minor <- function(major_labs, n_minor) 
                        {labs <- c( sapply( major_labs, function(x) c(x, rep("", 4) ) ) )
                                labs[1:(length(labs)-n_minor)]}
                
                # Input y axis tuning
                max_y <- input$abundance
                major_y <- 100
                minor_y <- 20
                y_cap <- input$y_cap
                y_brks <- seq(0, max_y, by=minor_y)
                y_labels <- insert_minor(seq(0, max_y, by=major_y), 4)
                y_labels <- c(y_labels[-length(y_labels)], y_cap)
                
                # Input x axis tuning
                time <- input$time
                max_x <- max(time)
                min_x <- min(time)
                major_x <- 5
                minor_x <- 1
                x_brks <- seq(0, max_x, by=minor_x)
                x_labels <- insert_minor(seq(0, max_x, by=major_x), 4)
                x_labels <- c(x_labels[-length(x_labels)], "min")
                
                p <- ggplot(df, aes_string(x=names(df)[1], y=names(df)[2])) +
                        geom_line() + theme_classic() +
                        scale_y_continuous("", limits = c(-20, max_y), expand=c(0,0),
                                           breaks = y_brks,
                                           labels = y_labels) +
                        scale_x_continuous("", limits = c(min_x, max_x), expand=c(0,0),
                                           breaks = x_brks,
                                           labels = x_labels) +
                        theme(plot.background = element_blank(),
                              plot.margin = unit(c(2, 3, 1, 1), "cm"),
                              panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank() )+
                        theme(panel.border= element_blank())+
                        theme(axis.line.x = element_line(color="black"),
                              axis.line.y = element_line(color="black")
                              ) 
        })
        
        output$plot <- renderPlot({
                print(plotInput())
        })

        output$downloadPlot <- downloadHandler(
                
                filename = function() { 
                        df_name <- input$file1
                      
                        paste(substr(df_name, 1, nchar(df_name)-4), '.tiff', sep='') },
                
                content = function(file) {
                        device <- function(..., width, height) {
                                usr_wdt <- input$width
                                usr_hgt <- input$height
                                usr_res <- input$resolution
                                
                                grDevices::tiff(..., width = usr_wdt, height = usr_hgt,
                                                units = "px", type = c("cairo"),
                                                pointsize = 12, compression = c("lzw"),
                                                bg = "white", res = usr_res)}
                        
                        ggsave(file, plotInput(), device = device)
                }
        )
})
        