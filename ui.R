library(shiny)
library(DT)
library(shinyjs)
library(rhandsontable)
library(bslib) #easy theme
library(showtext) #load google font
library(thematic)

#apply a pre-designed theme, bslib::
my_theme <- bs_theme(bootswatch = "flatly",
                     base_font = font_google("Open Sans")
                     )

#populate HTML theme to the plots, thematic::
thematic_shiny(font = "auto")




fluidPage(
  
 theme = my_theme,
  
 h1("Scatter plot"),
 p(code("Upload your file and select the independent and dependent variables")),
 br(),


 sidebarLayout(
   
   sidebarPanel(
     
       p(strong(h5("1. Please upload the data file (.csv) here:"))),
       fileInput("uploaded_patient_data",
                 label = NULL),
     # 
     # 
     #
     br(),
     br(),
     
     p(strong(h5("2. Please select the dependent and independent variables"))), #Bold header line
     wellPanel(
      
       selectInput(
         "selected_x_column",
         "Select your independent variale (x) from uploaded file",
         choices = NULL),
     
     
       actionButton
       (
         "up_ward_x",
         "▲"
       ),
       actionButton
       (
         "down_ward_x",
         "▼"
       ),
   
     hr(),

    
      
      selectInput(
        "selected_y_column",
        "Select your independent variale (y) from uploaded file",
        choices = NULL),
      
      
      actionButton
      (
        "up_ward_y",
        "▲"
      ),
      actionButton
      (
        "down_ward_y",
        "▼"
      )),
    
    
       
     br(),
     br(),
     
     
       actionButton(
         "update_plot",
         "Plot/Update"),
     
     
       fluidRow(
         column(
           3,
           checkboxInput(
             "add_lr",
             "Add linear Regression", FALSE
           )),
         column(
           3,offset = 1,
           checkboxInput(
             "add_loess",
             "Add smooth curve fit",
             FALSE)),
       )
       
     ),
   
   
   
   mainPanel
   ( 
     wellPanel(
       p(strong(h5("The data table"))),
       br(),
       br(),
       DTOutput("theUploadedDat")),
     
     
     wellPanel(
       p(strong(h5("The plot"))),
       br(),
       br(),
       plotOutput("scatterPlot"))
   )
 ))  
  
  
  
  
  
