#A new Schema will be created.  Note that the schema that will be used is data607Assignment2nn.
#If you have a schema with this name that already exists (and you do not want edited) you should change the
#schema name in the following two lines.


CREATE SCHEMA IF NOT EXISTS data607Assignment2nn;

use data607Assignment2nn;

CREATE USER IF NOT EXISTS 'data607nn'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON data607Assignment2nn . * TO 'data607nn'@'localhost';

DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Reviewers;
DROP TABLE IF EXISTS Movies;



#The first table to be created is the reviewers table.  It will store information about each reviewr.

CREATE TABLE Reviewers 
	(ReviewerID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
     ReviewerName VARCHAR(15) NOT NULL);

INSERT INTO Reviewers
(ReviewerName)
VALUES
('MarvaB'),
('NoelleM'),
('JacquieH'),
('JackieK'),
('WaveneyH');


#The second table to be creatd is the movies table.  It will store information about the movies reviewed.
#The name of the movie, the release data and the world wide box office gross in US dollars.
     
CREATE TABLE Movies 
	(MovieID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
     MovieName VARCHAR(30) NOT NULL,
     ReleaseDate DATE,
     BoxOfficeGross BIGINT);
     
INSERT INTO Movies
(MovieName, ReleaseDate, BoxOfficeGross)
VALUES
	('Rogue One','2016-12-14', 1034000000),
	('Hidden Figures', '2017-02-15',107700000 ),
	('Doctor Strange', '2016-10-13', 664400000),
	('The Jungle Book', '2016-04-04', 966600000),
	('Captain America: Civil War','2016-04-27', 1132000000),
	('Deadpool','2016-01-21',760300000);



#The third table is the Ratings table.  Ratings can be 
CREATE TABLE Ratings
	(RatingsID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
     Reviewer INT,
     Movie INT,
     Rating INT,
     CONSTRAINT FOREIGN KEY (Reviewer) 
		REFERENCES Reviewers (ReviewerID)
		ON DELETE SET NULL,
     CONSTRAINT FOREIGN KEY (Movie)
		REFERENCES Movies (MovieID)
        ON DELETE SET NULL);
        
INSERT INTO Ratings
(Reviewer,Movie,Rating)
VALUES
	(1,1,2), (1,2,5), (1,3,4), (1,4,4), (1,5,5), (1,6,3),
    (2,1,5), (2,2,3), (2,3,3), (2,4,3), (2,5,3), (2,6,3),
    (3,1,4), (3,2,4), (3,3,3), (3,4,5), (3,5,4), (3,6,5),
	(4,1,5), (4,2,5), (4,3,5), (4,4,5), (4,5,5), (4,6,5),
	(5,1,2), (5,2,5), (5,3,2), (5,4,5), (5,5,2), (5,6,1);


select * from Reviewers;
select * from Movies;
select * from Ratings;

#A list data in ratings table

SELECT Reviewers.ReviewerName, Movies.MovieName, Ratings.Rating FROM Ratings
RIGHT JOIN Reviewers
	ON Ratings.Reviewer = Reviewers.ReviewerID
LEFT JOIN Movies
	ON Ratings.Movie = Movies.MovieID
ORDER BY MovieName;