fluidPage(
  #theme = shinytheme("yeti"),
  navbarPage(
    title = ">> SNPer <<",
    
    # Tab 1 = = = = = = = = = = = = = = >> BACKGROUND INFORMATION << = = = = = = = = = = = = = = = = = = 
    
    tabPanel("Data upload", icon=icon("table"),
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
                uiOutput("CustomMAC"),
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
    
    tabPanel("SNP viewer", icon = icon("bullseye"),
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
    
    tabPanel("Background information", icon = icon("info-circle"),
             
             sidebarPanel(
               "SNPer was developed by ", a("Magdalena Julkowska", href = "https://mmjulkowska.github.io/", target = "_blank"), ", a PostDoc at " , a("King Abdullah University for Science and Technology", href = "https://www.kaust.edu.sa/en", target = "_blank"), " working in the group of ", a("Prof. Mark Tester.", href="https://scholar.google.com/citations?user=FTvzOtkAAAAJ&hl=en", target= "_blank"),
               br(),br(),
               "If you have any questions or suggestions please contact", span("Magdalena.Julkowska@kaust.edu.sa", style="color:blue"),
               br(),br(),
               "The README containing instructions on how to use SNPer is available", a("HERE", href="https://mmjulkowska.github.io/SNPer/", target = "_blank") 
             ),
             mainPanel(
               "About the SNPer:",
               br(),br(),
               "The SNPer is a tool to quickly visualize the pre-analyzed Genome Wide Association Study results. The power of high-throughput phenotyping, or simply the untapped enthousiasm of the hardworking scientists, are creating the datasets that are bigger than ever. Looking at the GWAS results and comparing them between different traits / conditions, can be a challende. This tool is going to make it so much easier for you to explore your GWAS data.",
               br(),br(),
               "The only thing you need is a compiled .csv file containing the Chromosome, Position, P-value, Minor Allele Frequency and one collumn containing the traits identifiers.",
               br(),br(),
               "The instruction on how to cite the app will be available shortly HERE"
             )
    )

    # end of the app    
  ))