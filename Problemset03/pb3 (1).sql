-- ProblemSet<No.3>, November <23> <2017> 
 -- Submission by <subashree.asokkumar@accenture.com>  

/*1.Find the titles of all movies directed by Steven Spielberg. (1 point possible)*/

select title from movie where director='steven spielberg';


/*2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)*/

select year from Movie m join Rating r on m.mId=r.mID
where stars='4' or stars='5' order by year;

/*3.Find the titles of all movies that have no ratings. (1 point possible)

select title from Movie where mID not in(select mID from rating); 




/*4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. (1 point possible)*/

select name from Reviewer r join Rating rt on r.rID=rt.rID where 
ratingdate is NULL;



/*5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. (1 point possible)*/

select r.name, m.title, rt.stars, rt.ratingDate
FROM Rating rt join Reviewer r on rt.rID = r.rID
 join Movie m on m.mID=rt.mID
order by r.name,m.title, stars;



/*6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. (1 point possible)*/

select name, title from Reviewer r, Movie m, Rating rt, Rating r1
where rt.mID=m.mID and r.rID=rt.rID 
  and rt.rID = r1.rID and r1.mID = m.mID
  and rt.stars < r1.stars and rt.ratingDate < r1.ratingDate;

/*7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. (1 point possible)*/

select  title,max(stars) from Movie m join Rating rt on
m.mID=rt.mID group by rt.mID order by title;



/*8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)*/

select rt.mID,title,max(stars)-min(stars) as rating_spread
from Movie m join Rating rt on
m.mID=rt.mID group by title order by rating_spread ;


/*9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)*/

select average1-average2 as diff_bw_beforeandafter80 from (select avg(avgbefore80) as average1 from (select mid,avg(stars)as avgbefore80 from rating where mid in (select mid from movie where year<1980)  group by mid) a) c join
(select avg(avgafter80) as average2 from (select mid,avg(stars)as avgafter80 from rating where mid in (select mid from movie where year>1980)  group by mid) b) d

/*10.Find the names of all reviewers who rated Gone with the Wind. (1 point possible)*/

select rt.rID,name from reviewer r
join rating rt on r.rID=rt.rID join movie m on m.mID=rt.mID
where title='Gone with the Wind'; 

 

/*11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. (1 point possible)*/

select name,title,stars from reviewer r
join rating rt on r.rID=rt.rID join movie m on m.mID=rt.mID
where director=name;

/*12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) (1 point possible)*/

select name,title from reviewer r
join rating rt on r.rID=rt.rID join movie m on m.mID=rt.mID
order by name,title; 

/*13.Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)*/

select title
from Movie
where mID not in (select mID
from Rating
where rID in (select rID
from Reviewer
where name = "Chris Jackson") )



/*14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. (1 point possible)*/

SELECT DISTINCT Re1.name, Re2.name
FROM Rating R1, Rating R2, Reviewer Re1, Reviewer Re2
WHERE R1.mID = R2.mID
AND R1.rID = Re1.rID
AND R2.rID = Re2.rID
AND Re1.name < Re2.name
ORDER BY Re1.name, Re2.name;

/*15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. (1 point possible)*/


select name, title,min( stars) from movie m join rating rt 
on m.mID=rt.mID join Reviewer r on r.rID=rt.rID group by rt.mID;

/*16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. (1 point possible)*/

select  title,avg( stars) from movie m join rating rt 
on m.mID=rt.mID join Reviewer r on r.rID=rt.rID group by rt.mID 
order by title;

/*17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) (1 point possible)*/

select name
from Rating rt join Reviewer r on rt.rID=r.rID
group by rt.rID
having count(rt.rID) >= 3

/*18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)*/

select title, director
from Movie
where director in (select director
from Movie
group by director
having count(director) >= 2)
order by director, title


/*19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)*/

select m.title, avg(r.stars) as strs from rating r
join movie m on m.mid = r.mid group by r.mid
having strs = (select max(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

/*20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) (1 point possible)*/

select m.title, avg(r.stars) as strs from rating r
join movie m on m.mid = r.mid group by r.mid
having strs = (select min(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

/*21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. (1 point possible)*/

select director ,title from movie m join rating rt on
m.mID=rt.mID and director is not NULL group by director 
order by max(stars)

