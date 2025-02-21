# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "fish creek watershed lake monitoring",
  titleWidth = 400
) # END dashboard header

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  # sidebar menu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
    
  ) # END sidebar menu
  
  
) # END dashboard sidebar


# dashboard body ----
body <- dashboardBody(
  
  # tabItems ----
  tabItems(
    
    # welcome tabitem
    tabItem(
      
      tabName = "welcome",
      
      # left-hand-column -----
      column(width = 6,
             
             # background info box
             box(width = NULL,
                 
                 title = tagList(icon("water"),strong("Background Info")),
                 
                 includeMarkdown("text/intro.md"),
                 tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                          alt = "A map of northern alaska showing fish creek watershed located within the national petroleum reserve.",
                          style = "max-width: 100%;"),
                 tags$h6("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/",
                                               "FCWO"),
                         style = "text-align: center;")
                 
                 
             ) # END background info box
             
      ), #END left hand column
      
      # right-hand-column ----
      column(width = 6,
             
             # first fluidrow ----
             fluidRow(
               
               #citation box
               box(width = NULL,
                   
                   title = tagList(icon("table"),strong("Citation")),
                   
                   includeMarkdown("text/citation.md")
                   
               ) # END citation box
               
             ), # END first fluid row
             
             # second fluidrow 
             fluidRow(
               
               #disclaimer box
               box(
                 width = NULL,
                 
                 title = tagList(icon("triangle-exclamation"), strong("Disclaimer")),
                 
                 includeMarkdown("text/disclaimer.md")
               ) # END disclaimer box
             ) # END second fluidrow
             
      ) # END right hand column
      
    ), # END welcome tabitem
    
    
    # dashboard tabitem
    tabItem(
      
      tabName = "dashboard",
      
      # fluidRow ----
      fluidRow(
        
        
        #input box ----
        box(
          width = 4,
         
          title = tags$strong("adjust lake parameter ranges:"),
          
          # sliderinputs ----
          sliderInput(inputId = "elevation_slider_input",
                      label = "elevation (meters above sea level)",
                      min = min(lake_data$Elevation),
                      max = max(lake_data$Elevation),
                      value = c(min(lake_data$Elevation), 
                                    max(lake_data$Elevation)),
                      ), # END elevation slider input
  
          # depth slider input
          sliderInput(inputId = "depth_slider_input", 
                      label = "Average depth (meters):",
                      min = min(lake_data$AvgDepth), 
                      max = max(lake_data$AvgDepth),
                      value = c(min(lake_data$AvgDepth), max(lake_data$AvgDepth))), # END depth slider input
          
          # temp slider input
          sliderInput(inputId = "temp_slider_input", 
                      label = "Average lake bed temperature (°C):",
                      min = min(lake_data$AvgTemp), 
                      max = max(lake_data$AvgTemp),
                      value = c(min(lake_data$AvgTemp), max(lake_data$AvgTemp))) #END temp slider input
          
        ), # END input box
        
        # leaflet box ----
        box(
          width = 8, 
          
          title = tags$strong("monitored lakes within fish creek watershed "),
          
          # leaflet output ----
          leafletOutput(outputId = "lake_map_output") |> 
            withSpinner(type = 1, color = "blue")
          
        ) # END leaflet box
        
      ) # END fluidrow
      
    ) # END Dashboard tabitem
    
    
  )# End tabItems
  
  
) # END dashboard body

# combine all to dashboardPage ----
dashboardPage(header, sidebar, body)