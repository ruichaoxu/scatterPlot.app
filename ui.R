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
    wellPanel(
      
       selectInput(
         "selected_x_column",
         "2. Select your x value",
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
       )),
   
     

    wellPanel(
      
      selectInput(
        "selected_y_column",
        "3. Select your y value",
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
             "Add linear Regressoin", FALSE
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
  
  
  
  
  
