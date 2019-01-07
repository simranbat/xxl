# xxl

This project scrapes http://genius.com to get data to compare the past 5 XXL Freshman Classes.

**freestyle_lyrics.csv** is the culminating csv file of all the freestyles and **scrape_genius.R** is the code to get there

**text_analysis.R** tokenizes the lyrics to find wordcount and number of unique words; **words_xxl.csv** is the csv file with the resulting statistics as variables.  
 
**top10.R** scrapes genius.com to get the top 10 songs of each artists, but summarizes down to the number of instances that top 10 song is his or hers, as opposed to a feature on somebody else's song; **original_xxl.csv** is the same as **words_xxl.csv** but with this new counted variable.

**viewcount_xxl.R** scrapes each artist's page to get the top 6 albums, then scrapes the pages of the albums to get the viewcounts for all the songs.  The objects "artist_hyphen" and "artistcount" from **top10.R** are required to run this code.  The resulting file **viewcount_xxl.csv** has over 2000 rows. The song titles are not cleanly formatted because for the purposes of this analysis, only the viewcount per artist was important to me.  


A dashboard containing the text and data analysis can be found here: https://public.tableau.com/profile/simran.batra1879#!/vizhome/XXLFreshmanClass/Dashboard2

As a note, if you're looking through the code you may notice that there are places where I had to hard code and directly input some data or alter an artist's name so the data would merge properly.  This is because when scraping, there are a lot of inconsistencies that you can't automate.  The general methodology of this project for the amount of artists that I was looking at was that I had to use a loop to scrape the websites of every artist to generate a list of links, then I had to use a loop to go through every link to scrape those pages.  This posed difficult because, for example, sometimes in links, "$" would convert to "s" whereas other times it would just disappear (example https://genius.com/artists/Joey-bada vs. https://genius.com/artists/Ty-dolla-sign). Sometimes "you're" in a link would go to "youre" and other times it would go to "you-re."  Especially for the last file **viewcount_xxl.R** where I had to check the links for over 300 albums, this kind of work is nearly impossible to automate completely (i.e. without hard coding).  This is all to say that if you use any of the files to produce similar data for different artist, it inevitable will be tedious.  These files will only serve as guideliness and not code that can be copied directly.  
