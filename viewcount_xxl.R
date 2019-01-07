###CREATING LINKS

artist_hyphen$artist <- gsub("Joey-Badass", "joey-bada", artist_hyphen$artist)

test <- data.frame()
all_views <- data.frame()
for (artist in artist_hyphen$artist) {
  url <- paste("https://genius.com/artists/", artist, "/", sep = "")
  
  webpage <- read_html(url)
  album_html <- html_nodes(webpage, 'h3')
  album_data <- html_text(album_html)
  album_data <- as.data.frame(album_data)
  album_data <- album_data[2:length(album_data$album_data),]
  album_data <- as.data.frame(album_data)
  album_data$album_data <- as.character(album_data$album_data)
  #albumdata has no hyphens
  
  album_hyphen <- album_data
  album_hyphen$album_data <-gsub("[[:blank:]]", "-", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\.", "-", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("é", "e", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\$", "s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\+", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\(", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\)", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub(":", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("&", "-", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("/", "-", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\*", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub(",", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("\\?-", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("!", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("#", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("--+", "-", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("-$", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("^-", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("'", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Dont", "Don-t", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("BOATS", "Boat-s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Trues", "True-s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("6s", "6", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Youll", "You-ll", album_hyphen$album_data)
  album_hyphen$album_data <- gsub(".", "", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("B4-DA-ss", "b4-da", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("BADAss", "bada", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Didnt", "didn-t", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Winters", "winter-s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Suns", "sun-s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("sign", "ign", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Theres", "There-s", album_hyphen$album_data)
  album_hyphen$album_data <- gsub("Yall", "y-all", album_hyphen$album_data)
  
  
  
  # hard coding 21 savage and playboi carti and pnb rock
  if (artist == "21-Savage") {
    album_hyphen$album_data[1] <- "I-am-i-was-deluxe"
    album_hyphen$album_data[2] <- "I-am-i-was"
  }
  if (artist == "Playboi-Carti") {
    album_hyphen$album_data[6] <- "Young-mi-fit"
  }
  if (artist == "PnB-Rock") {
    album_hyphen$album_data[2] <- "THE-THROWAWAY"
  }
  
  test <- rbind(test, album_hyphen)
  
  #get view count of all songs in an album
  for (album_name in album_hyphen$album_data) {
    empty <- data.frame()
    album_url <- paste("https://genius.com/albums/", artist, sep = "")
    album_url <- paste(album_url, "/", sep = "")
    album_url <- paste(album_url, album_name, sep = "")
    webpage <- read_html(album_url)
    #using css selectors
    views_html <- html_nodes(webpage, '.chart_row-content-title , .chart_row-metadata_element--large')
    views_data <- html_text(views_html)
    views_data <- as.data.frame(views_data)
    views_data <- mutate(views_data, views_data = as.character(views_data))
    views_data <- filter(views_data, grepl("Missing Lyrics", views_data)==FALSE)
    views_data <- mutate(views_data,  ID = row_number())
    count <- c(1:length(views_data$ID))
    for (count in count){
      if (grepl("Lyrics", views_data$views_data[count+1])) {
        if (grepl("Lyrics", views_data$views_data[count])) {
          empty <- rbind(empty, 0)}
      } else {
        if (grepl("\\d", views_data$views_data[count+1])) {
          empty <- rbind(empty, views_data$views_data[count+1])
          empty[,1] <- as.character(empty[,1])
        } else {
          if (grepl("Lyrics", views_data$views_data[count])) {
            empty <- rbind(empty, 0)}
        }
      }
    }
    views_data <- empty
    views_data <- rename(views_data, views_data = names(empty))
    views_data <- filter(views_data, grepl("[MK]|0$", views_data))
    
    titles_html <- html_nodes(webpage, '.chart_row-content-title')
    titles_data <- html_text(titles_html)
    titles_data <- as.data.frame(titles_data)
    titles_data$titles_data <- gsub("\r?\n|\r", "", titles_data$titles_data)
    titles_data$titles_data <- trimws(titles_data$titles_data)
    
    album <- cbind(titles_data, views_data)
    views_data <- album
    
    views_dataM <- filter(views_data, grepl(".M.", views_data))
    views_dataM$views_data <- gsub('\\s+', '', views_dataM$views_data)
    views_dataM$views_data <- gsub('M', '', views_dataM$views_data)
    views_dataM <- mutate(views_dataM, views_data = as.numeric(views_data) *1000000)
    views_dataK <- filter(views_data, grepl(".K.", views_data))
    views_dataK$views_data <- gsub('\\s+', '', views_dataK$views_data)
    views_dataK$views_data <- gsub('K', '', views_dataK$views_data)
    views_dataK <- mutate(views_dataK, views_data = as.numeric(views_data) *1000)
    
    album <- rbind(views_dataK, views_dataM)
    album$titles_data <- gsub(' Lyrics', '', album$titles_data)
    album <- rename(album,  song = "titles_data",
                    viewcount = "views_data")
    
    album <- mutate(album, album = album_name)
    album <- mutate(album, artist = artist)
    if (length(album) == 4) {
      all_views <- rbind(all_views, album)
    }
  }
  
}
allviews <- all_views

all_art <- rename(all_artists, artist_clean = artist) #from other 
artist_both <- cbind(all_art, artist_hyphen)
allviews <- merge(allviews, artist_both)
allviews <- select(allviews, artist_clean, song, viewcount)
allviews <- allviews %>%
  distinct(song, artist_clean, .keep_all = TRUE)

allviews$artist_clean <- gsub("Stefflon Don", "Stefflon Don Freestyle", allviews$artist_clean)
allviews$artist_clean <- gsub("A Boogie wit da Hoodie", "A Boogie Wit Da Hoodie", allviews$artist_clean)
allviews$artist_clean <- gsub("Ab-Soul", "Ab Soul", allviews$artist_clean)
allviews$artist_clean <- gsub("Ski Mask the Slump God", "Ski Mask The Slump God", allviews$artist_clean)
years <- select(artistcount, artist, year)
allviews <- rename(allviews, artist=artist_clean)
all_viewcounts <- merge(allviews, years)


write.csv(all_viewcounts, "viewcount_xxl.csv")
