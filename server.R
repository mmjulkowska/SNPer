function(input, output) {
  
  # # # # # # # > > > input widgets < < < # # # # # # # 
  
  ItemList = reactive(if (is.null(input$your_data)) {
    return()
  } else {
    d2 = read.csv(input$your_data$datapath)
    return(colnames(d2))
  })
  
  
  # Select P-value
  output$CustomPval <- renderUI({
    if (is.null(ItemList())) {
      return ()
    } else
      tagList(
        selectizeInput(
          inputId = "SelectPval",
          label = "Select column containing P-value",
          choices = ItemList(),
          multiple = F
        )
      )
  })
  
 # Select Chromosome
  output$CustomChr <- renderUI({
    if (is.null(ItemList())) {
      return ()
    } else
      tagList(
        selectizeInput(
          inputId = "SelectChr",
          label = "Select column containing Chromosome",
          choices = ItemList(),
          multiple = F
        )
      )
  })
  
  # Select Chromosome
  output$CustomPos <- renderUI({
    if (is.null(ItemList())) {
      return ()
    } else
      tagList(
        selectizeInput(
          inputId = "SelectPos",
          label = "Select column containing SNP position",
          choices = ItemList(),
          multiple = F
        )
      )
  })
  
  # Select MAC / MAF
  output$CustomMAC <- renderUI({
    if ((is.null(ItemList())) | (input$qMAC == FALSE)) {
      return ()
    } else
      tagList(
        selectizeInput(
          inputId = "SelectMAC",
          label = "Select column containing MAC / MAF",
          choices = ItemList(),
          multiple = F
        )
      )
  })
  
  # Select Trait
  output$CustomTrait <- renderUI({
    if ((is.null(ItemList())) | (input$qTrait == FALSE)) {
      return ()
    } else
      tagList(
        selectizeInput(
          inputId = "SelectTrait",
          label = "Select column containing trait information",
          choices = ItemList(),
          multiple = F
        )
      )
  })
  
  
  # # # >> DATA TABLE OUTPUTS IN THE FIRST TAB << # # # 
  
  output$Data_tabl <- renderDataTable({
    if (is.null(input$your_data)) {
      return(NULL)
    } else{
      test <- read.csv(input$your_data$datapath)
      test
    }
  })
  
  
  my_data <- eventReactive(input$Go_data, {
    d2 = read.csv(input$your_data$datapath)
    my_data <- subset(d2, select = c(input$SelectChr, input$SelectPos, input$SelectPval, input$SelectMAC, input$SelectTrait))
    my_data
      })
  
  output$Data_selected <- renderDataTable({
    if (is.null(input$your_data)) {
      return(NULL)
    } else{
    my_data()
    }
  })
 
  
  # > > > INPUT 2nd TAB < < < #
  
  output$Trait_View <- renderUI({
    if (is.null(input$your_data)) {
      return(NULL)
    } 
    if(input$qTrait == F){
      return(NULL)
    }
    else{
      data <- my_data()
      trait <- unique(data[,input$SelectTrait])
      tagList(
        selectizeInput(
          inputId = "SelTrait",
          label = "Select which trait to plot",
          choices = trait,
          multiple = T))
    }
  })
  
  output$Chromo_View <- renderUI({
    if (is.null(input$your_data)) {
      return(NULL)
    } 
    else{
      data <- my_data()
      chromo <- unique(data[,input$SelectChr])
      tagList(
        selectizeInput(
          inputId = "SelChromo",
          label = "Select which chromosome to plot:",
          choices = chromo,
          multiple = F)) 
    }
  })
  
  output$mLOD_View <- renderUI({
    if (is.null(input$your_data)) {
      return(NULL)
    } 
    else{
      numericInput(
        inputId = "SelLOD",
        label = "Select minimum value of LOD to plot",
        value = 5)}
  })
  
  
  SNPgrapher <- eventReactive(input$GoSNPer,{
    data <- my_data()
    
    data$Chr <- data[,input$SelectChr]
    data$Pos <- data[,input$SelectPos]
    data$MAC <- data[,input$SelectMAC]
    data$LOD <- -log10(data[,input$SelectPval])
    data$Trait <- data[,input$SelectTrait]
    
    data2 <- subset(data, data$Chr == input$SelChromo)
    data2 <- subset(data2, data2$LOD > input$SelLOD)
    
    if(input$qTrait == T){
      data2 <- subset(data2, data2$Trait == input$SelTrait)
    }
    
    data3 <- subset(data2, select=c("Chr", "Pos", "MAC", "LOD", "Trait"))
    data3
    
  }) 
  
  output$tableski <- renderDataTable({
    SNPgrapher()
  })
  
output$graphski <- renderPlotly({
  data <- SNPgrapher()
  p <- ggplot(data = data, aes(x = Pos, y = LOD, col = Trait, size = MAC))
  p <- p + geom_point(alpha= input$transparency)
  p <- p + xlab(paste("SNP positions on Chromosone", input$SelChromo))
  p <- p + guides(fill=guide_legend(title=NULL))
  p <- p + theme(legend.title = element_blank())

  p
})
  
output$dwnld_graphski <- renderUI({
  if(is.null(SNPgrapher())){
    return()
  }
  else{
    downloadButton("Download_graph", label = "Download plot")
  }
})
  
output$Download_graph <- downloadHandler(
  filename = function(){paste("Plot for", input$SelChromo, "using", input$SelTrait, ".pdf") },
  content <- function(file){
    pdf(file)
  
    data <- SNPgrapher()
    p <- ggplot(data = data, aes(x = Pos, y = LOD, col = Trait, size = MAC))
    p <- p + geom_point(alpha= input$transparency)
    p <- p + xlab(paste("SNP positions on Chromosone", input$SelChromo))
    p <- p + guides(fill=guide_legend(title=NULL))
    
    print(p)
    dev.off()
})

}