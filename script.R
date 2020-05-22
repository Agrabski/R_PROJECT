install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
library(jsonlite)
library(math)
unzip("train.json.zip")

train_data <- fromJSON("train.json")
unzip("test.json.zip")
test_data <- fromJSON("test.json")

splitStrings<- train_data %>% select(request_id, request_text, requester_received_pizza)
splitStrings<- splitStrings %>% mutate(request_text=strsplit(request_text," "))
splitStrings<- splitStrings %>% mutate(request_text=tolower(request_text))


x <- train_data %>% mutate(request_text=tolower(request_text)) %>% select(request_text, requester_received_pizza)
x <- x %>% tidyr::separate_rows(request_text, sep = " ")


g = (x %>% select(requester_received_pizza, request_text))



t <- g %>% group_by(request_text, requester_received_pizza) %>% mutate(new = n())
