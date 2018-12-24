#text and sentiment aanlysis
#length
free <- read.csv("freestyle_lyrics.csv")
free$lyrics <- as.character(free$lyrics)

#unnest tokens
unnest_xxl <-  free%>%
  unnest_tokens(word, lyrics)

#count how many times each word appears in each freestyle
count_xxl <- unnest_xxl %>%
  count(artist, word, sort = TRUE) %>%
  ungroup()

#count the total words in each album
totalwords_xxl <- count_xxl %>% 
  group_by(artist) %>% 
  summarize(totalwords = sum(n)) %>%
  ungroup()

#merge with original dataframe
words_xxl <- merge(free, totalwords_xxl)

#unique words
unique_total <- unnest_xxl %>%
  count(artist, word) %>%
  count(artist) %>%
  rename(unique = nn)

#merge with last dataframe
words_xxl <- merge(unique_total, words_xxl)
wordsfile_xxl <- select(words_xxl, artist, year, totalwords, unique)
write.csv(wordsfile_xxl, "words_xxl.csv")