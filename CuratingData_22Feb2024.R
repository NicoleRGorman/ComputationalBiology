# Curating Data
# 22 Feb 2024
# NRG

# open CSV file in file view to just scan for obvious issues

# find where R is pointing to
#in console, type getwd()
#[1] "/Users/nicolegorman/computational_biology"
# don't need to specify path bc file is at root

# read in file
my_data <- read.table(file="../ComputationalBiology/Bio6100ClassNotes/OriginalData/ToyData.csv",
                      header=TRUE,
                      sep=",",
                      comment.char="#")
                      
# my_data <- read.table(file="../ToyData.csv",
#                       header=TRUE,
#                       sep=",",
#                       comment.char="#")
# Two dots just goes up one level

#inspect object
str(my_data)

#now add column
my_data$newVar <- runif(4)
head(my_data)

write.table(x=my_data,
            file="../ModifiedToyData.csv",
            # HEADER=TRUE,
            sep=",")


#############

# Special format for keeping R objects

saveRDS(my_data, file = "../Converted_csv.RDS") 
# .RDS suffix is not required, but good for clarity

data_in <- readRDS("../Converted_csv.RDS")

# saveRDS and readRDS provide the means to save a single R object to a connection (typically a file) and to restore the object, quite possibly under a different name. This differs from save and load, which save and restore one or more named objects into an environment. They are widely used by R itself, for example to store metadata for a package and to store the help.search databases: the ".rds" file extension is most often used.

