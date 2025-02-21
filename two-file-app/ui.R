# User interface

ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           # intro text fluidrow ----
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
             
           ), # END intro text fluidrow
           
           
           hr(), 
           
           # footer text ----
           includeMarkdown("text/footer.md")
           
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout panel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerInput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxgroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = c("Clear Cut" = "clear cut forest",
                                                           "Old Growth" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE,
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"), # font awesome is default library
                                                 no = icon("xmark")
                                               ))
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") |> 
                            withSpinner(color = "darkred", type = 7)
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayour
                      
             ), # END trout tab panel
             
             # penguins panel ----
             tabPanel(title = "Penguins",
                      
                      # penguins sidebarLayout ----
                      sidebarLayout(
                        
                        # penguins sidebarPanel ----
                        sidebarPanel(
                          
                          # island pickerInput ----
                          pickerInput(inputId = "island_input",
                                      label = "Select Island(s):",
                                      choices = unique(penguins$island),
                                      selected = "Dream",
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section sliderInput ----
                          shiny::sliderInput(inputId = "slider_input",
                                             label = "Select bins:",
                                             min = 1, max = 100, value = 25)
                          
                        ), # END penguins sidebarPanel
                        
                        # penguins mainPanel ----
                        mainPanel(
                          
                          plotOutput(outputId = "penguin_hist_output") |> 
                            withSpinner(color = "lightpink", type = 6)
                          
                        ) # END penguins mainPanel
                        
                      ) # END penguins sidebarLayour
                      
                      
             ) # END penguins tab panel
             
           )
           
  ) # END (Page 2) data viz tabPanel
  
) #END ui
