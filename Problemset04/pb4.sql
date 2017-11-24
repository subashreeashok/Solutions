-- ProblemSet<No.4>, November <23> <2017> 
 -- Submission by <subashree.asokkumar@accenture.com>  


/*1.Find the names of all students who are friends with someone named Gabriel. (1 point possible)*/

select name from Highschooler where ID in(select ID1 from Friend
                                          where ID2 in
                                          (select ID from Highschooler 
                                           where name='Gabriel'));



/*2.For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. (1 point possible)*/


select distinct sName, sGrade, lName, lGrade, gradeDiff
from (select h1.name as sName, h1.grade as sGrade, 
      h2.name as lName, h2.grade as lGrade,
      h1.grade-h2.grade as gradeDiff 
     from Highschooler h1, Likes, Highschooler h2
     where h1.ID=ID1 and h2.ID=ID2) as LF
     where gradeDiff>=2;

/*3.For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order. (1 point possible)*/

 select h1.name, h1.grade, h2.name, h2.grade  from Likes l1,
 Likes l2, Highschooler h1, Highschooler h2
where l1.ID1=l2.ID2 and l2.ID1=l1.ID2 and
l1.ID1=h1.ID and l1.ID2=h2.ID and h1.name<h2.name;

/*4.Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade. (1 point possible)

select name,grade from Highschooler where ID not in 
(select ID1 from Likes union select ID2 from Likes) 
order by grade, name;


/*5.For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. (1 point possible)*/

select distinct H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Likes, Highschooler H2
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and H2.ID 
not in (select ID1 from Likes);

/*6.Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. (1 point possible)*/

select name, grade from Highschooler
where ID not in (select ID1 from Highschooler H1, Friend, 
                 Highschooler H2 where H1.ID = Friend.ID1
                 and Friend.ID2 = H2.ID and H1.grade <> H2.grade)
order by grade, name;

/*7.For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. (1 point possible)*/

select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Likes, Highschooler H2, Highschooler H3, Friend F1, Friend F2
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and
  H2.ID not in (select ID2 from Friend where ID1 = H1.ID) and
  H1.ID = F1.ID1 and F1.ID2 = H3.ID and
  H3.ID = F2.ID1 and F2.ID2 = H2.ID;

/*8.Find the difference between the number of students in the school and the number of different first names. (1 point possible)*/

select st.sNum-nm.nNum from 
(select count(*) as sNum from Highschooler) as st,
(select count(distinct name) as nNum from Highschooler) as nm;

/*9.Find the name and grade of all students who are liked by more than one other student. (1 point possible)*/

select name, grade 
from (select ID2, count(ID2) as numLiked from Likes group by ID2) as LK, Highschooler
where numLiked>1 and ID2=ID;

/*10.For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C. (1 point possible)*/

select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2,
Highschooler H3
where L1.ID2 = L2.ID1
and L2.ID2 <> L1.ID1
and L1.ID1 = H1.ID and L1.ID2 = H2.ID and L2.ID2 = H3.ID;

/*11.Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.(1 point possible)*/

select h.name, h.grade 
from highschooler h
where h.grade not in 
(select h1.grade from highschooler h1, 
 friend f1 where h.id=f1.id1 and h1.id=f1.id2)

/*12.What is the average number of friends per student? (Your result should be just one number.) (1 point possible)*/

select avg (n) from (select count(f.id1) as n from friend f
                     group by f.id1) as avg_frd

/*13.Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.*/

select count(f.id1) from friend f, highschooler h
where h.id=f.id2 and not h.name='Cassandra' and f.id2 in
(select f2.id1 from friend f2, highschooler h2 where
 f.id2=f2.id1 and h2.id=f2.id2 and h2.name='Cassandra')


/*14.Find the name and grade of the student(s) with the greatest number of friends. (1 point possible)*/

select h.name, h.grade from highschooler h, friend f 
where h.id = f.id1 group by f.id1 
having count(f.id2) = (select max(fr.num) from
(select count(id2) as num from friend group by id1) as fr)



