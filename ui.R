library(shinydashboard)

shinyUI(dashboardPage(skin='green',
  dashboardHeader(title=h3(strong('Analysis Of Starbucks Global Presence and Prediction Of Store Rates')),
                  titleWidth = 800
               
                 ),

  dashboardSidebar(
    sidebarMenu(
      menuItem('Home', tabName = 'home', icon =icon('home')),
      br(),
      
      menuItem('Explore', tabName='explore',  icon = icon('globe')),
               
      br(),
         
      menuItem('Analysis', icon =icon('chart-bar'),
               menuSubItem("Correlation",tabName = "correlation"),
               menuSubItem("Collinearity", tabName = "collinearity")),
      br(),
      
      menuItem('Model Selection', icon=icon("calculator"),
               menuSubItem("Backward elimination", tabName="backward"),
               menuSubItem("Forward selection", tabName="forward")),
                           
      br(),
      
      menuItem(" Check Model Conditions", icon=icon('check'),
               menuSubItem("Linear Relationship", tabName = "linear"),
               menuSubItem("Normal Residuals", tabName="normal"),
               menuSubItem("Variability", tabName='variance')),
              
      br(),
      
      menuItem("Prediction", tabName = "predict", icon=icon("calculator")),
      
      menuItem('About Me', tabName= 'me', icon= icon('user-tie'))
    
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              fluidRow(
                      infoBoxOutput("total_stores"),
                      infoBoxOutput("countries"),
                      infoBoxOutput("cities")),
              
              
              fluidRow(
                column(7,
                    htmlOutput("plot1")),
                column(5,
                    htmlOutput("home_bar")))
              
                ),
              
      tabItem(tabName= 'explore',
              fluidRow(
                br(),
                br(),
                column(3,
                      selectizeInput(inputId='selected',
                                      label='Select a country',
                                      choices=unique(star[star$store_count>0,]$country),
                                      selected='Malaysia'
                                      )),
                
                  uiOutput('country'),
                
                  uiOutput('num_city'),
              
                  uiOutput('store_urban_pop')),
              
              br(),
              br(),
              br(),
                  
              
              fluidRow(
                column(6, 
                  plotlyOutput("box")),
    
          
                column(4,
                  htmlOutput("bar")

                )
              )),
      
      tabItem(tabName = "correlation",
              fluidRow( 
                h3(strong("Check for a linear relationhsip between target variable and each predictors")),
               
                       box(plotlyOutput("gdp")),
               
                       box(plotlyOutput("population"))),
              br(),
             
              fluidRow(
                       column(4,
                         plotlyOutput("med_age")),
                       column(4,
                          plotlyOutput("density")),
                       column(4,
                        plotlyOutput("bus_score"))),
              
      ),
      
      tabItem(tabName = "collinearity",
              fluidRow(
                br(),
                br(),
                h3(strong("Pairwise correlation between target and predictor variables")),
                plotOutput("coll")
              )),
             
      
      tabItem(tabName ="backward",
              fluidRow(
                br(),
                br(),
                
                column(6,
                  h3(strong("Step 1: Full Model"),
                         br(),
                         "store_rate = -2.500e-5",
                         br(),
                                  "1.625e-10 gdp",
                        br(),
                                  "-1.15e-15 pop",
                        br(),
                                  "+3.525e-7 bus_score",
                         br(),
                                  "+1.347e-6asia",
                         br(),
                                  "-8.19 europe",
                         br(),
                                  "+8.49e-6 northamerica",
                         br(),
                                  "-9.1e-6oceania",
                         br(),
                                  "+1.192 south america",
                         br(),
                         br(),
                         h3(strong("Adjusted R-squared = 0.4263")))),
                
                
                column(6,
                  h3(strong("Step 2: Remove Business Score"),
                     br(),
                     "store rate = -2.687e-6",
                     br(),
                     "2.64e-10 gdp",
                     br(),
                     "-1.346-15 pop",
                     br(),
                     "+8.815e-7asia",
                     br(),
                     "-5.548e-6 europe",
                     br(),
                     "+8.588e-6 northamerica",
                     br(),
                     "-6.65e-6oceania",
                     br(),
                     "1.34e-15 south america",
                     br(),
                     br(),
                     
                     h3(strong("Adjusted R-squared = 0.5229")))))),
              
      
      tabItem(tabName ="forward",
              fluidRow(
                br(),
                br(),
                column(4,
                       h3(strong("Step 1: Fit GDP"),
                          br(),
                          "store_rate = -1.15",
                          br(),
                          "+2.11e-4gdp",
                       br(),
                       br(),
                       h3(strong("Adjusted R-squared = 0.3489")))),
                
                column(4,
                      h3(strong("Step 2: Add Continent"),
                         br(),
                         "store_rate = -2.57",
                         br(),
                          "+2.62e-4 gdp",
                         br(),
                          "+1.07 asia",
                         br(),
                         "-5.52 europe",
                         br(),
                         "8.605nort america",
                         br(),
                         "-6.644 oceania",
                         br(),
                         "0.186 south america",
                         br(),
                         br(),
                         h3(strong("Adjusted R-squared = 0.5296")))),
                
                column(4,
                       h3(strong("Step 3: Add Population"),
                          br(),
                          "store_rate = -2.687e-6",
                          br(),
                          "2.64e-10 gdp",
                          br(),
                          "-1.346-15 pop",
                          br(),
                          "+8.815e-7asia",
                          br(),
                          "-5.548e-6 europe",
                          br(),
                          "+8.588e-6 northamerica",
                          br(),
                          "-6.65e-6oceania",
                          br(),
                          "1.34e-15 south america",
                          br(),
                          br(),
                          h3(strong("Adjusted R-squared = 0.5229")))))),
                
          
      tabItem(tabName="linear",
              fluidRow(
                br(),
                h3(strong("Linear Relationship Between Predictors and Target Variable")),
                br(),
                column(4,
                       plotlyOutput("linear_gdp")),
                column(4,
                       plotlyOutput("linear_pop")),
                column(4,
                       plotlyOutput("linear_continent")))),
              
      
      tabItem(tabName = "normal",
              fluidRow(
                br(),
                h3(strong("Nearly Normal Residuals")),
                br(),
                column(6,
                       plotlyOutput("normal_hist")),
                column(6,
                       plotOutput("normal_qqnorm")))),
      
      tabItem(tabName="variance",
              fluidRow(
                h3(strong("Constant Variability of Residuals")),
                br(),
                br(),
                column(6,
                plotlyOutput("vary"))
              )),
      
      tabItem(tabName = "predict",
              br(),
              fluidRow(
              column(4,
                     selectizeInput(inputId='pick',
                                    label=h3(strong('Select a country')),
                                    choices=unique(star1$country))),
              column(4,
                     uiOutput("info")),
              
              column(4,
                     uiOutput("result")))),
      
      tabItem(tabName = "me",
              br(),
              br(),
              fluidRow(
                column(4,
                       img(src="my_pic.jpg", width="70%")),
                br(),
                "Randy was a high school math and physics teacher for 16 years.",
                br(),
                "He got his masters degree in Physics Education at the", 
                br(),
                "University of Southeastern Philippines.",
                br(),
                "His passion about trends, predictions, and data driven", 
                br(),
                "decisions led him to pursue a career in Data Science.",
                br(),
                "He is currently studying Data Science at NYC Data Science Academy",
                br(),
                "and will join Georgia Tech for the MS in Analytics program this fall."
                
              ))
  
    
    
    )
    
  )
)
)
