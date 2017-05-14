

url <- "http://files.grouplens.org/datasets/movielens/"
dataset_small <- "ml-latest-small"
dataset_full <- "ml-latest"
data_folder <- "movielensdata"
archive_type <- ".zip"

# Choose dataset version
dataset <- dataset_full
dataset_zip <- paste0(dataset, archive_type)

# Download the data and unzip it
if (!file.exists(file.path(data_folder, dataset_zip))) {
  download.file(paste0(url, dataset_zip), file.path(data_folder, dataset_zip))
}
unzip(file.path(data_folder, dataset_zip), exdir = data_folder, overwrite = F)

# Display the unzipped files
list.files('data/', recursive=T)




movieData <- read.csv("movielensdata/ml-latest/movies.csv", stringsAsFactors = FALSE)
ratingsData <- read.csv("movielensdata/ml-latest/ratings.csv", stringsAsFactors = FALSE)

#summarise ratings - average movie rating

ratingsData2 <- ratingsData %>% 
  group_by(movieId) %>% 
  summarise (
    n = n(),
    avgRating = mean(rating)
    
  )



#movieData$title <- str_replace(movieData$title, "\\(.*?\\)", "")
movieData$title <- str_trim(movieData$title, side="both")



testmovie <- sample_n(Tweetsdf,2)
testmovie$movieGrades[1] <- "positive"
testmovie$movieGrades[2] <- "negative"

lengthin <- nrow(testmovie)
lengthmov <- nrow(movieData)

alltop10 <- NULL
allTopMovies <- NULL

topmovies <- NULL
indexfound <- 0

i <- 1
j <- 1

for (i in 1:lengthin)
{
  moviefound <- toupper(testmovie$movieNames[i])
  for (j in 1:lengthmov)
  {
    moviein <- toupper(movieData$title[j])
    if(moviefound == moviein){
      indexfound <- j
      
    }
    else
    {
      moviein2 <- str_replace(moviein, "\\(.*?\\)", "")
      moviein2 <- str_trim(moviein2, "both")
      if(moviefound == moviein2){
        indexfound <- j
      }
      else if(str_detect(moviein2, "^.*,\\s\\bTHE$")){
          check <- 1
          moviein3 <- gsub(", THE", "", moviein2)
          moviein4 <- paste("THE", moviein3, sep = " ")
          if(moviein4 == moviefound){
            indexfound <- j
            
          }
      }
      else{
          indexfound1 <- 0
      }
    }
    j <- j+1
  }
    
  if (indexfound != 0)
  {
    if(testmovie$movieGrades[i] == "positive")
    {
      genre <- movieData$genres[indexfound]
      movielist <- movieData[which(movieData$genres == genre), ]
      for (k in 1:nrow(movielist))
      {
        movierating <- ratingsData2[which(ratingsData2$movieId == movielist$movieId[k]),]
        topmovies <-cbind(Movie = movielist$title[k], Rating = movierating$avgRating[1], Index = i)
        allTopMovies <- rbind(allTopMovies, topmovies)
        test<- 1
      }
    }
    else
    {
      genre <- movieData$genres[indexfound]
      movielist <- movieData[which(movieData$genres != genre), ]
      for (k in 1:nrow(movielist))
      {
        movierating <- ratingsData2[which(ratingsData2$movieId == movielist$movieId[k]),]
        topmovies <-cbind(Movie = movielist$title[k], Rating = movierating$avgRating[1], Index = i)
        allTopMovies <- rbind(allTopMovies, topmovies)
        test1 <- 2
      }
    }
  }
  if(indexfound == 0)
  {
    #genre <- movieData$genres[indexfound]
    movielist <- movieData
    for (k in 1:nrow(movielist))
    {
      movierating <- ratingsData2[which(ratingsData2$movieId == movielist$movieId[k]),]
      topmovies <-cbind(Movie = movielist$title[k], Rating = movierating$avgRating[1], Index = i)
      allTopMovies <- rbind(allTopMovies, topmovies)
      test2 <- 3
      
      
    }
  }
  TopMoviesdf <- as.data.frame(allTopMovies)
  TopMoviesdf <- arrange(TopMoviesdf, desc(Rating))
  TopMoviesdf <- subset(TopMoviesdf, Movie != movieData$title[indexfound])
  top10movies <- TopMoviesdf[1:10,]
  alltop10 <- rbind(alltop10, top10movies)
  indexfound <- 0
  i <- i+1
}

