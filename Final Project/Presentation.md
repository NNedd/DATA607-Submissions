Presentation
========================================================
author: N Ob
date: May 18, 2017
autosize: true
output:
  prettydoc::html_pretty:
    theme: cayman
    highlight: github

First Slide
========================================================

For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.

- Bullet 1
- Bullet 2
- Bullet 3

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-2](Presentation-figure/unnamed-chunk-2-1.png)

Our project
========================================================
In response to a tweet reviewing a movie, recommend a movie based on:
- ratings in the MovieLens Database 
- overall twitter reviews of the initial movie


Our approach
========================================================
We tried to follow the Cross Industry Standard Process for Data Minining (CRISP-DM)approach:

![Dataminig Process Diagram](CRISP-DM_Process_Diagram.png)

Data Sources
========================================================

- Twitter feed @FilmReviewIn140 : for initial tweets
![FilmReviewIn140ex](FilmReviewIn140.PNG)


========================================================
- Standford's large movie review dataset (http://ai.stanford.edu/~amaas/data/sentiment/) : to train sentiment analysis model
  - several text files identifed as positive or negative movie reviews
- Movielens large database (https://grouplens.org/datasets/movielens/): to select the top 10 rated movies (based on genre)
  - multiple zipped csv files (for project used movies and ratings)
- General twitter search (I rated 'movie-name' #imdb)

Classifying tweets
========================================================
- M





