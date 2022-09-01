library(shiny)
library(DT)
library(shinyjs)
library(rhandsontable)

fluidPage(
  
  h1("Scatter plot"),
  p(code("Upload your file and select the independent and dependent variables")),
  

 sidebarLayout(
   
   sidebarPanel(
     
       fileInput("uploaded_patient_data",
                 "1. Please upload the data file (.csv) here:"),
     # 
     # 
     # 
     p(strong(h5("2. Please upload the data file (.csv) here:"))), #Bold header line
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
     column
     (
       12,
       plotOutput("scatterPlot")
       
     )
     
   )
 ))  
  
  
  
  
  
