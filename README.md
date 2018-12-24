# xxl
data scraping of genius.com to get xxl freshman class freestyle lyrics from the past 5 years

freestyle_lyrics.csv is the culminating csv file of said lyrics and scrape_genius.R is the code to get there

text_analysis.R tokenizes the lyrics to find wordcount and number of unique words; words_xxl.csv is the csv file with the resulting statistics as variables.  

top10.R scrapes genius.com to get the top 10 songs of each artists, but summarizes down to the number of instances that top 10 song is his or hers, as opposed to a feature on somebody else's song; original_xxl.csv is the same as words_xxl.csv but with this new counted variable.

a dashboard containing preliminary text and data analysis can be found here: https://public.tableau.com/profile/simran.batra1879#!/vizhome/XXLFreshmanClass/Dashboard2
