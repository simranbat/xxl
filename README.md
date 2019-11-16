# xxl

This project scrapes http://genius.com to get data to compare the past 5 XXL Freshman Classes.

**freestyle_lyrics.csv** is the culminating csv file of all the freestyles and **scrape_genius.R** is the code to get there

**text_analysis.R** tokenizes the lyrics to find wordcount and number of unique words; **words_xxl.csv** is the csv file with the resulting statistics as variables.  
 
**top10.R** scrapes genius.com to get the top 10 songs of each artists, but summarizes down to the number of instances that top 10 song is his or hers, as opposed to a feature on somebody else's song; **original_xxl.csv** is the same as **words_xxl.csv** but with this new counted variable.

**viewcount_xxl.R** scrapes each artist's page to get the top 6 albums, then scrapes the pages of the albums to get the viewcounts for all the songs.  The objects "artist_hyphen" and "artistcount" from **top10.R** are required to run this code.  The resulting file **viewcount_xxl.csv** has over 2000 rows. The song titles are not cleanly formatted because for the purposes of this analysis, only the viewcount per artist was important to me.  


A dashboard containing the text and data analysis can be found here: https://public.tableau.com/profile/simran.batra1879#!/vizhome/XXLFreshmanClass/Dashboard2
