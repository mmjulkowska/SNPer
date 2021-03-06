# SNPer

A small tool that will help you visualize the GWAS results from many different experiments. You can cite the SNPer as:
Julkowska, M.M.  "V1.0.2 mmjulkowska/SNPer: Release including README :)" DOI: 10.5281/zenodo.1227775

you can either run the SNPer [on-line](https://mmjulkowska.shinyapps.io/SNPer/) or by typing into the terminal windown of the R/S-studio the following commands:

`install.packages(shiny)`

`library(shiny)`

`shiny::runGitHub("mmjulkowska/SNPer", "mmjulkowska")`

The accepted data format is ".csv" files. 

In the first tab - select your file and select all the neccessary column identifiers from the drop-down menus. Once you are finished, click on "Set the dataset" button. 

The new dataset can be viewed in the sub-tab "Selected data"

![readme_01](https://user-images.githubusercontent.com/14832460/39174093-5af92582-47af-11e8-8f48-4c1cec73e7fd.png)

In the tab "SNP-viewer" you can select whichever traits you want to view (unlimited number) and the chromosome.  

![readme_02](https://user-images.githubusercontent.com/14832460/39174094-5b1bafc6-47af-11e8-9df4-86bfa828efd6.png)

After selecting all - click on "Unleash SNPer" button. You can change the transparency of the dots by changing the value in the "transparency box" below 1.

![readme_06](https://user-images.githubusercontent.com/14832460/39174241-ce1853a8-47af-11e8-8e5e-ddb9584611a8.png)

You can also zoom in into the graph by selecting the zoom-in region. 

![readme_03](https://user-images.githubusercontent.com/14832460/39174095-5b3da4a0-47af-11e8-87a6-7e22ee684768.png)

To zoom out click "autoscale" button within the graph. 

![readme_05](https://user-images.githubusercontent.com/14832460/39174097-5b8ad2ca-47af-11e8-952e-fee2ec91b4b1.png)

In order to get the information about the exact position of the associated SNP, put your cursor over the specific SNP. 

![readme_04](https://user-images.githubusercontent.com/14832460/39174096-5b5fdc3c-47af-11e8-9f92-7a5a38bf525b.png)

If you change the chromosome, make sure to agan press "Unleash SNPer" to update the graph. 

Happy Forward Genetic analysis!
