library(tidyverse)
library(rvest)

#years 2013, 2016, 2017, 2018
year <- c("2016", "2017", "2018", "2013")
all_freestyles <- data.frame()

#Ab-soul-xxl-freshman-freestyle-ab-soul-lyrics

for (year in year) {
  url <-paste("https://genius.com/albums/Xxl/Freshman-freestyles-class-of-", year, sep = "")
  webpage <- read_html(url)
  
  #using css selectors to create the links
  titles_html <- html_nodes(webpage, '.chart_row-content-title')
  titles_data <- html_text(titles_html)
  titles_data <- as.data.frame(titles_data)
  c <- c("2018")
  if(year %in% c) {
    titles_data <- titles_data[1:length(titles_data$titles_data) - 1, ]
  }
  titles_data <- as.data.frame(titles_data)
  titles_data$titles_data <-gsub("\r?\n|\r", "", titles_data$titles_data)
  titles_data$titles_data <- trimws(titles_data$titles_data)
  titles_data$titles_data <- regmatches(titles_data$titles_data, regexpr(": .+ by", titles_data$titles_data))
  titles_data$titles_data <-regmatches(titles_data$titles_data, regexpr(" .+ ",titles_data$titles_data))
  titles_data$titles_data <- trimws(titles_data$titles_data)
  titles_data$titles_data <-gsub(" ", "-", titles_data$titles_data)
  names <- titles_data
  clean_names <- gsub("-", " ", names$titles_data)
  titles_data$titles_data <- gsub("^", "-freestyle-", titles_data$titles_data)
  titles_data$titles_data <- gsub("$", "-lyrics", titles_data$titles_data)
  titles_data$titles_data <- gsub("\\.", "", titles_data$titles_data)
  names$titles_data <- gsub("-Freestyle", "", names$titles_data)
  names$titles_data <-gsub("$", "-xxl-freshman", names$titles_data)
  c <- c(1:length(names$titles_data))
  for (number in c) {
    titles_data$titles_data[number] <-
      gsub("^", names$titles_data[number], titles_data$titles_data[number])
  }
  titles_data$titles_data <- gsub("\\.", "", titles_data$titles_data)
  titles_data$titles_data <- gsub("é", "e", titles_data$titles_data)
  titles_data$titles_data <- gsub("\\$", "", titles_data$titles_data)
  links <- gsub("^", "https://genius.com/", titles_data$titles_data)
  
  #initializing empty data frame
  lyrics <- data.frame()
  
  #using css selectors to get the lyrics
  for (row in links) {
    webpage <- read_html(row)
    lyrics_html <- html_nodes(webpage, 'p')
    lyrics_data <- html_text(lyrics_html)
    lyrics_data <- as.data.frame(lyrics_data)
    lyrics_data <- lyrics_data$lyrics_data[1]
    lyrics_data <- as.data.frame(lyrics_data)
    lyrics <- rbind(lyrics, lyrics_data)
  }
  
  #merging names to lyrics
  lyrics <- rename(lyrics, lyrics = lyrics_data)
  clean_names <- as.data.frame(clean_names)
  clean_names <- rename(clean_names, artist = clean_names)
  freestyles <- cbind(clean_names, lyrics)
  freestyles <- mutate(freestyles, year = year)
  
  #merging with all classes
  all_freestyles <- rbind(all_freestyles, freestyles)
}

#years 2014 and 2015
year <- c("2015", "2014")

for (year in year) {
  url <-paste("https://genius.com/albums/Xxl/Freshman-freestyles-class-of-", year, sep = "")
  webpage <- read_html(url)
  
  #using css selectors to create the links
  titles_html <- html_nodes(webpage, '.chart_row-content-title')
  titles_data <- html_text(titles_html)
  titles_data <- as.data.frame(titles_data)
  if(year == "2015") {
    titles_data <- titles_data[1:length(titles_data$titles_data) - 1, ]
  }
  titles_data <- as.data.frame(titles_data)
  titles_data$titles_data <-gsub("\r?\n|\r", "", titles_data$titles_data)
  titles_data$titles_data <- trimws(titles_data$titles_data)
  titles_data$titles_data <- regmatches(titles_data$titles_data, 
                                        regexpr("by.+Lyrics", titles_data$titles_data))
  titles_data$titles_data <-gsub("              ", " ", titles_data$titles_data)
  titles_data$titles_data <-regmatches(titles_data$titles_data, 
                                       regexpr("[[:blank:]].+[[:blank:]]",titles_data$titles_data))
  titles_data$titles_data <- trimws(titles_data$titles_data)
  titles_data$titles_data <-gsub("^[[:blank:]]", "", titles_data$titles_data)
  titles_data$titles_data <-gsub("[[:blank:]]", "-", titles_data$titles_data)
  names <- titles_data
  clean_names <- gsub("-", " ", names$titles_data)
  titles_data$titles_data <- gsub("$", "-xxl-freshman-freestyle-lyrics", titles_data$titles_data)
  titles_data$titles_data <- gsub("\\.", "", titles_data$titles_data)
  titles_data$titles_data <- gsub("é", "e", titles_data$titles_data)
  titles_data$titles_data <- gsub("\\$", "s", titles_data$titles_data)
  links <- gsub("^", "https://genius.com/", titles_data$titles_data)
  
  #initializing empty data frame
  lyrics <- data.frame()
  
  #using css selectors to get the lyrics
  for (row in links) {
    webpage <- read_html(row)
    lyrics_html <- html_nodes(webpage, 'p')
    lyrics_data <- html_text(lyrics_html)
    lyrics_data <- as.data.frame(lyrics_data)
    lyrics_data <- lyrics_data$lyrics_data[1]
    lyrics_data <- as.data.frame(lyrics_data)
    lyrics <- rbind(lyrics, lyrics_data)
  }
  
  #merging names to lyrics
  lyrics <- rename(lyrics, lyrics = lyrics_data)
  clean_names <- as.data.frame(clean_names)
  clean_names <- rename(clean_names, artist = clean_names)
  freestyles <- cbind(clean_names, lyrics)
  freestyles <- mutate(freestyles, year = year)
  if(year == "2015") {
    freestyles <- freestyles[1:length(freestyles$artist)-1,]
  }
  
  #merging with all classes
  all_freestyles <- rbind(all_freestyles, freestyles)
}

write.csv(all_freestyles, "freestyle_lyrics.csv")
