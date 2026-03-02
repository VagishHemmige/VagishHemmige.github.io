#This script creates a CV from a template

library(officer)
library(RefManageR)
library(stringr)

doc <- read_docx("cv/Hemmige Einstein CV template.docx")


filename<-paste0("cv/Hemmige Einstein CV ", Sys.Date(), ".docx")
print(doc, target = filename)