wordsfile_xxl <- read.csv("freestyle_lyrics.csv")
all_artists <- select(wordsfile_xxl, artist)

#fixing text errors
all_artists$artist <- gsub("Stefflon Don Freestyle", "Stefflon Don", all_artists$artist)
all_artists$artist <- gsub("A Boogie Wit Da Hoodie", "A Boogie wit da Hoodie", all_artists$artist)
all_artists$artist <- gsub("Ab Soul", "Ab-Soul", all_artists$artist)
all_artists$artist <- gsub("Ski Mask The Slump God", "Ski Mask the Slump God", all_artists$artist)

artist_hyphen <- all_artists
artist_hyphen$artist <-gsub("[[:blank:]]", "-", artist_hyphen$artist)
artist_hyphen$artist <- gsub("\\.", "", artist_hyphen$artist)
artist_hyphen$artist <- gsub("é", "e", artist_hyphen$artist)
artist_hyphen$artist <- gsub("\\$", "s", artist_hyphen$artist)

original <- data.frame()
#get names and artists of top 10 songs
#creating links
for (artist in artist_hyphen$artist) {
  url <- paste("https://genius.com/artists/", artist, sep = "")
  webpage <- read_html(url)
  count <- c(1:59)
  for (count in count){
    if (artist == artist_hyphen$artist[count])
      x <- count
  }
  #scraping each artists' page
  artist_html <- html_nodes(webpage, '.mini_card-subtitle')
  artist_data <- html_text(artist_html)
  artist_data <- as.data.frame(artist_data)
  artist_data <- trimws(artist_data$artist_data)
  artist_data <- as.data.frame(artist_data)
  artist_data$artist_data <- as.character(artist_data$artist_data)
  artist_data <- count(artist_data, artist_data)
  #original <- rbind(original, artist_data)
  int <- c(1:length(artist_data$artist_data))
  for (count in int) {
    if (artist_data$artist_data[count] == all_artists$artist[x]) {
      newartist <- as.data.frame(artist_data[count,])
      original <- rbind(original, newartist)
    }
  }
}

#hardcoding for wifisfuneral text error
newartist$artist_data <- gsub("Jarren Benton", "Wifisfuneral", newartist$artist_data)
newartist$n <- as.character(newartist$n)
newartist$n <- gsub("5", "8", newartist$n)
original <- rbind(original, newartist)

#merge with last data from 
original$artist_data <- gsub("Stefflon Don", "Stefflon Don Freestyle", original$artist_data)
original$artist_data <- gsub("A Boogie wit da Hoodie", "A Boogie Wit Da Hoodie", original$artist_data)
original$artist_data <- gsub("Ab-Soul", "Ab Soul", original$artist_data)
original$artist_data <- gsub("Ski Mask the Slump God", "Ski Mask The Slump God", original$artist_data)
original <- rename(original, artist = artist_data)
artistcount <- merge(wordsfile_xxl, original)
artistcount$n <- as.integer(artistcount$n)
write.csv(artistcount, "original_xxl.csv")