library(tidyverse)
library(rtweet)


#mining the data
data <- search_tweets("melbourne",
                      n=18000,
                      include_rts = FALSE,
                      lang = "en",
                      retryonratelimit = TRUE)

#flattening the file to store it easier 
data <- data %>% flatten()

#saving the file to a csv 
#change name of file every time this is run to not overwrite the data
data %>% write_csv("melbourne_12_10_21")

#create a list of all of our csv files
files <- list.files(pattern = "\\.csv$", full.names = TRUE)

#combine csv files into one document 
#do this once after all of the data over the weeks have been collected
all_data <- map.df(files ~ read_csv(.x))

#to get rid of duplicate data
final_data <- all_data %>% distinct()