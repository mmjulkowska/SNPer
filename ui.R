fluidPage(
  #theme = shinytheme("yeti"),
  navbarPage(
    title = ">> SNPer - precision GWAS mapping <<",
    
    # Tab 1 = = = = = = = = = = = = = = >> BACKGROUND INFORMATION << = = = = = = = = = = = = = = = = = = 
    
    tabPanel("Data upload",
             
             sidebarPanel(
               
               fluidRow(
                 fileInput(
                   "your_data",
                   label = "Upload your file",
                   accept = c('text / csv', '.csv', 'text/comma-separated-values')
                 ),
                uiOutput("CustomChr"),
                uiOutput("CustomPos"),
                uiOutput("CustomPval"),
                checkboxInput("qMAC", "Does your data contain information of Minor Allele Frequency / Count (MAC / MAF) ?"),
                uiOutput("CustomMAC"),
                checkboxInput("qTrait", "Does your data contain information on mapped trait?"),
                uiOutput("CustomTrait"),
                actionButton("Go_data", "Set the dataset")
                
             )),
             mainPanel( navbarPage("Data upload",
                      tabPanel("Uploaded data",
                               dataTableOutput("Data_tabl")),
                      tabPanel("Selected data",
                               dataTableOutput("Data_selected")
                               )))
    ),
    # End of Data upload tab
    
    tabPanel("SNP viewer",
             sidebarPanel(
               uiOutput("Trait_View"),
               uiOutput("Chromo_View"),
               uiOutput("mLOD_View"),
               numericInput("transparency", "Chose the value for transparency of the points between 0 and 1", value = 1),
               actionButton("GoSNPer", "unleash SNPer")
             ),
             mainPanel(
               uiOutput("dwnld_graphski"),
               plotlyOutput("graphski", height = 600)
             )
    ),
    # End of SNP viewer file
    
    tabPanel("Background information",
             
             sidebarPanel(),
             mainPanel()
    )

    # end of the app    
  ))