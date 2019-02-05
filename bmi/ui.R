library(rCharts)
library(shiny)
library(datasets)
library(ISOcodes)
library(shinythemes)
data(ISO_3166_1)

shinyUI(pageWithSidebar(
        headerPanel("BMI (Body Mass Index) Calculator"),
        
        sidebarPanel(
                numericInput(inputId="heightM", label="Your height in cm", value= 0,min=0),
                numericInput(inputId="weightM", label="Your weight in kg", value= 0,min=0),
                radioButtons(inputId="gender", label="Gender", choices=c("Female","Male")),
                selectInput(inputId="country", label="Country", choices=sort(ISO_3166_1$Alpha_3),
                multiple = FALSE,selected="PHL"),
                conditionalPanel(
                        condition = "input.country == 'USA'",
                        p("If you live in USA, please choose a state"),
                        selectInput(inputId="state", label="State", choices=state.name,
                        multiple = FALSE,selected=NULL)),
                actionButton("goButton", "Calculate"),
                br(),
                p(strong(em("More Info Here:",a("Body Mass Index",href="ReadForMoreInfo.html")))),
                p(strong(em("Github Repository Link:",a("Course Project",href="https://github.com/amazing010692/Mod9_CourseProj_ShinyApp"))))
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel('Your results',
                                h5('Your BMI coefficient kg/m^2'),
                                verbatimTextOutput("oiBMI"),
                                verbatimTextOutput("oiBMIclass"),
                                img(src="BMI_Class.png", height = 600, width =600)
                                
                                ),
                        tabPanel('Data Summary',
                                 h5('Available data for'),
                                 verbatimTextOutput("oicountry"),
                                 h5('Gender'),
                                 verbatimTextOutput("oigender"),
                                 h5('Mean BMI (kg/m2) (crude estimate) and 95% CI'),
                                 verbatimTextOutput("oiBMIcrude"),
                                 p("Source: ", a("WHO Global Health Observatory Data Repository", 
                                                 href = "http://apps.who.int/gho/data/node.main.A903?lang=en")),
                                 h5('Recent BMI Indicators'),
                                 dataTableOutput("oiBMIcattable")
                                 
                                ),
                        tabPanel('Plot: BMI Indicators',
                                 h5('Recent BMI Indicators'),
                                 p("Plotted data are for your gender for your specific country"),
                                 p("If there are no data for your gender, plotted data are for adults for your specific country"),
                                 verbatimTextOutput("oiPlotYear"),
                                 showOutput("Plot1","highcharts")
                                 
                                 ),
                        tabPanel('Plot: Mean BMI Trend',
                                 h5('Mean BMI Trend per Years'),
                                 showOutput("Plot2","highcharts")
                                 
                                 ),
                        tabPanel('Plot: BMI Indicators for US States',
                                 h5('2012 US States BMI Indicators for Adults '),
                                 verbatimTextOutput("oiState"),
                                 showOutput("Plot3","highcharts")
                                
                                 )
                )
               )
)
)