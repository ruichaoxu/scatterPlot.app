library(tidyverse)
library(rhandsontable)
library(lubridate)
library(ggplot2)

#using reactlog to debug: run following line in the console
#options("shiny.reactlog" = TRUE)
#Hit Ctrl+F3 in browser where app is opened and run


# Define server logic required to draw a histogram
function(input, output,session) {
  

  
 observeEvent(input$uploaded_patient_data,
              {
                theDat <- read.csv(input$uploaded_patient_data$datapath)
                
                updateSelectInput(
                  session,
                  "selected_x_column",
                  label = "Select your independent variale (x) from uploaded file",
                  choices = colnames(theDat)
                )
              })
  
 observeEvent(input$uploaded_patient_data,
               {
                 theDat <- read.csv(input$uploaded_patient_data$datapath)
                 
                 updateSelectInput(
                   session,
                   "selected_y_column",
                   label = "Select your dependent variable (y) from uploaded file",
                   choices = colnames(theDat)
                 )
               })
 
 #button to control independent variables (x), downward
 observeEvent(
   input$down_ward_x,
   {
     
     theDat <- read.csv(input$uploaded_patient_data$datapath)
     
     updateSelectInput(
       session,
       "selected_x_column",
       label = "Select your independent variale (x) from uploaded file",
       choices = colnames(theDat),
       selected = 
         {
         if
           (input$selected_x_column == colnames(theDat)[length(colnames(theDat))])
           {colnames(theDat)[1]} #End variable loop back to first
         else
           {colnames(theDat)[(which(colnames(theDat) == input$selected_x_column)+1)]}
         } 
     )
     
   }
 ) 
 
 
 
 #button to control independent variables (x), upward
 observeEvent(
   input$up_ward_x,
   {
     
     theDat <- read.csv(input$uploaded_patient_data$datapath)
     
     updateSelectInput(
       session,
       "selected_x_column",
       label = "Select your independent variale (x) from uploaded file",
       choices = colnames(theDat),
       selected = 
         {
           if
           (input$selected_x_column == colnames(theDat)[1])
           {colnames(theDat)[length(colnames(theDat))]} #First variable loop back to end
           else
           {colnames(theDat)[(which(colnames(theDat) == input$selected_x_column)-1)]}
         } 
     )
     
   }
 ) 
 
 
 
 
 #button to control dependent variables (y)
 observeEvent(
   input$down_ward_y,
   {
     
     theDat <- read.csv(input$uploaded_patient_data$datapath)
     
     updateSelectInput(
       session,
       "selected_y_column",
       label = "Select your independent variale (y) from uploaded file",
       choices = colnames(theDat),
       selected = 
         {
           if
           (input$selected_y_column == colnames(theDat)[length(colnames(theDat))])
           {colnames(theDat)[1]}
           else
           {colnames(theDat)[(which(colnames(theDat) == input$selected_y_column)+1)]}
         } 
     )
     
   }
 )
 
 
 
 
 #button to control independent variables (y), upward
 observeEvent(
   input$up_ward_y,
   {
     
     theDat <- read.csv(input$uploaded_patient_data$datapath)
     
     updateSelectInput(
       session,
       "selected_y_column",
       label = "Select your independent variale (y) from uploaded file",
       choices = colnames(theDat),
       selected = 
         {
           if
           (input$selected_y_column == colnames(theDat)[1])
           {colnames(theDat)[length(colnames(theDat))]} #Final variable loop back to first
           else
           {colnames(theDat)[(which(colnames(theDat) == input$selected_y_column)-1)]}
         } 
     )
     
   }
 ) 
 
  uploadedDat <- reactive({
    
    theDat <- read.csv(input$uploaded_patient_data$datapath)
    
    return(theDat)
  })
  
  
##output the scatter plot 
  
  output$scatterPlot <- renderPlot(
    {
    #initially, no plot is shown
    if (input$update_plot == 0) 
      {
      return()
      }
    
    uploadedDat <- uploadedDat()
 
    if((input$add_lr)&(input$add_loess))
      {uploadedDat %>%
        ggplot(aes_string(x = isolate(input$selected_x_column), y = isolate(input$selected_y_column)))+
        geom_point()+ #by isolating, output will not be re-evaluated when the 2 isolated inputs are changed. But when button was hit (input$update_plot was changed), output will be re-evaluated and hence plot updated
        geom_smooth(method = "lm")+
        geom_smooth(method = "loess",se = FALSE, color = "red")+
        
        theme_bw()}
     else if(input$add_lr){
         uploadedDat %>%
           ggplot(aes_string(x = isolate(input$selected_x_column), y = isolate(input$selected_y_column)))+
           geom_point()+
           geom_smooth(method = "lm")+
           
           theme_bw()}
      else if (input$add_loess){
           uploadedDat %>%
             ggplot(aes_string(x = isolate(input$selected_x_column), y = isolate(input$selected_y_column)))+
             geom_point()+
             geom_smooth(method = "loess",se = FALSE, color = "red")+
             
             theme_bw()
      }
    else{
      uploadedDat %>%
        ggplot(aes_string(x = isolate(input$selected_x_column), y = isolate(input$selected_y_column)))+
        geom_point()+
        
        
        theme_bw()
    }
       
        
       })
}
    
    