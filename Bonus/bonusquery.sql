-- ProblemSet<Bonus>, November <28> <2017> 
-- Submission by <subashree.asokkumar@accenture.com>  

/*1.List all the actors who acted in at least one film in 2nd half of the 19th century and in at least one film in the 1st half of the 20th century*/

select distinct p.fname from Person p, Movie m, Movie m1, Cast c, Cast c1 where c.pid = p.id and c.mid = m.id and m.year between 1850 and 1900 and c1.pid = p.id
and c1.mid = m1.id and m1.year between 1901 and 1950;

/*2.List all the directors who directed a film in a leap year*/

select fname,m.year from  Director d join Moviedirector md on d.id=md.did join Movie m on m.id=md.mid where m.year % 4=0 and m.year % 100 !=0 or m.year % 400=0;

/*3.List all the movies that have the same year as the movie 'Shrek (2001)', but a better rank. (Note: bigger value of rank implies a better rank)*/

select name from Movie where year in (select year from Movie where name='Shrek (2001)') and rank>5;

/*4.List first name and last name of all the actors who played in the movie 'Officer 444 (1926)'*/

select fname,lname from Person p join Cast c on c.pid=p.id join Movie m on mid=c.mid where m.name='Officer 444 (1926)'; 

/*5.List all directors in descending order of the number of films they directed*/

select fname,lname,count(md.mid) as no_of_flims from Director d join Moviedirector md on md.did=d.id group by d.id order by no_of_flims DESC;

/*6.Find the film(s) with the largest cast.*/

/*7.Find the film(s) with the smallest cast.*/

/*8.In both the above cases, also return the size of the cast.*/

/*9.Find all the actors who acted in films by at least 10 distinct directors (i.e. actors who worked with at least 10 distinct directors).*/

/*10.Find all actors who acted only in films before 1960.*/

select p.fname ,p.lname from Person p join Cast c on c.pid=p.id join Movie m on c.mid=m.id where m.year < 1960;

/*11.Find the films with more women actors than men.*/

select * from(select m.name  from Movie m join Cast c on c.mid=m.id  join Person p on c.pid=p.id and p.gender='F' group by m.id having count(*)>
(select count(*) from Movie m ,Cast c1,Person p where c1.mid = m.id AND c1.pid = p.id AND p.gender='M'));

/*12.For every pair of male and female actors that appear together in some film, find the total number of films in which they appear together. Sort the answers in decreasing order of the total number of films.

select * from(select gender,p.id,m.id from Person p ,Cast c,Movie m where  c.mid=m.id and c.pid=p.id group by m.id having m.id=p.id) ;

/*13.For every actor, list the films he/she appeared in their debut year. Sort the results by last name of the actor.

14.For every actor, list the films he/she appeared in their debut year. Sort the results by last name of the actor.

15.The Bacon number of an actor is the length of the shortest path between the actor and Kevin Bacon in the "co-acting" graph. That is, Kevin Bacon has Bacon number 0; all actors who acted in the same film as KB have Bacon number 1; all actors who acted in the same film as some actor with Bacon number 1 have Bacon number 2, etc. Return all actors whose Bacon number is 2.

16.Suppose you write a single SELECT-FROM-WHERE SQL query that returns all actors who have finite Bacon numbers. How big is the query?


17.A decade is a sequence of 10 consecutive years. For example 1965, 1966, ..., 1974 is a decade, and so is 1967, 1968, ..., 1976. Find the decade with the largest number of films.
Rank the actors based on their popularity, and compute a list of all actors in descending order of their popularity ranks. You need to come up with your own metric for computing the popularity ranking.
This may include information such as the number of movies that an actor has acted in; the 'popularity' of these movies' directors (where the directors' popularity is the number of movies they have directed), etc.
Be creative in how you choose your criteria of computing the actors' popularity. For this answer, in addition to the query, also turn in the criteria you used to rank the actors.*/




