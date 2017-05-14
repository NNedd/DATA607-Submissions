
if("stringi" %in% rownames(installed.packages()) == FALSE) {install.packages("stringi")}
library(stringi)
if("twitteR" %in% rownames(installed.packages()) == FALSE) {install.packages("twitteR")}
library(twitteR)
if("ROAuth" %in% rownames(installed.packages()) == FALSE) {install.packages("ROAuth")}
library(ROAuth)
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)
if("xtable" %in% rownames(installed.packages()) == FALSE) {install.packages("xtable")}
library(xtable)
if("DT" %in% rownames(installed.packages()) == FALSE) {install.packages("DT")}
library(DT)
# if("e1071" %in% rownames(installed.packages()) == FALSE) {install.packages("e1071")}
# library(e1071)
# if("class" %in% rownames(installed.packages()) == FALSE) {install.packages("class")}
# library(class)
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr")}
library(stringr)
if("base64enc" %in% rownames(installed.packages()) == FALSE) {install.packages("base64enc")}
library(base64enc)
# if("wordcloud" %in% rownames(installed.packages()) == FALSE) {install.packages("wordcloud")}
# library(wordcloud)

options(httr_oauth_cache=FALSE)


consumerKey = "EcMaLIydRm6jEr3fws7JqtLxX"
consumerSecret = "n3qTYOR4N0YAdZzstm7A4eKq51iyn73XhohX4R3zeUYEiOui20"
accessToken = "862671453082320896-b1KMTD7JVQ8ugqKYczuTlePhfGsaPm3"
accessTokenSecret = "cqtDYbDGyBMEQXI41ZsovtsI7YbJmHZJxnERnzR6oYKSj"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

allTweets <- userTimeline('FilmReviewIn140', n = 346)
head(allTweets)
allTweetsdf <- do.call("rbind", lapply(allTweets, as.data.frame))

head(allTweetsdf)

#Process Tweets


#Interested in the text column of data frame.  For the purposed of this project valid reviews have the following format:
#Name of Movie (in all caps), - , Movie Review, | , Grade

#Extract Movie Names:  All characters up until " - " (with spaces)
movieNames <- str_extract(allTweetsdf$text, ".+?(?= \\- )")  
#movieNames <- str_replace(movieNames, "\\(.*?\\)", "")
movieNames <- str_trim(movieNames, side="both")
#Convert to dataframe
movieNamesdf <- data.frame(movieNames, row.names = NULL, stringsAsFactors = FALSE)


#Extract Movie Review
movieReviews <- str_extract(allTweetsdf$text, "\\- ([^|]*)")
movieReviews <- str_replace(movieReviews, "-", "")
movieReviews <- str_trim(movieReviews, side="both")
movieReviewsdf <- data.frame(movieReviews, row.names = NULL, stringsAsFactors = FALSE)

#Extract Grade
movieGrades <- str_extract(allTweetsdf$text, "([[:upper:]]{1}[+|-]{0,1})$")
movieGrades <- str_trim(movieGrades, side="both")
movieGradesdf <- data.frame(movieGrades, row.names = NULL, stringsAsFactors = FALSE)

#Merge Data frames
Tweetsdf <- bind_cols(movieNamesdf, movieReviewsdf, movieGradesdf)
Tweetsdf <- na.omit(Tweetsdf)

datatable(Tweetsdf)


