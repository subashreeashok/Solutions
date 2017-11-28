-- ProblemSet<Problem set: 5>, November <28> <2017> 
-- Submission by <subashree.asokkumar@accenture.com>  

/*1.Give the organiser's name of the concert in the Assembly Rooms after the first of Feb, 1997. (1 point possible)*/

select m.m_name as organiser_name,m.m_no,c.concert_no from musician m join concert c on m.m_no=c.concert_organiser where 
concert_venue='assembly rooms'and con_date > '1997-02-01';

/*2.Find all the performers who played guitar or violin and were born in England.*/

select m.m_name,place_country,instrument from performer p ,musician m, place pl on p.perf_is=m.m_no 
and pl.place_no=m.born_in where instrument='violin' or instrument='guitar' and place_country='england';

/*3.List the names of musicians who have conducted concerts in USA together with the towns and dates of these concerts. (1 point possible)*/

select m.m_name,place_country from place p  join musician m on m.born_in=p.place_no join concert c on m.m_no=c.concert_organiser where place_country='usa'; 

/*4.How many concerts have featured at least one composition by Andy Jones? List concert date, venue and the composition's title. (1 point possible)*/


/*5.List the different instruments played by the musicians and avg number of musicians who play the instrument. (1 point possible)*/

select instrument,avg(count) as avg_musicians from (select instrument,count( perf_is) as count from performer group by instrument) group by instrument

/*6.List the names, dates of birth and the instrument played of living musicians who play a instrument which Theo also plays. (1 point possible)*/

select m.m_name,m.born,p.instrument from musician m join performer p on m.m_no=p.perf_no where died is null and p.instrument=(
select p.instrument from musician m join performer p on m.m_no=p.perf_no where m.m_name like '%theo%')


/*7.List the name and the number of players for the band whose number of players is greater than the average number of players in each band. (1 point possible)*/

select b.band_name,p.band_id,count(p.player) as no_of_players from plays_in p join band b on p.band_id=b.band_no 
group by p.band_id having no_of_players>
(select (sum(count)/count(band_id)) from (select count(band_id) as count,band_id from plays_in group by band_id ));


/*8.List the names of musicians who both conduct and compose and live in Britain. (1 point possible)*/

select distinct(m_name)from musician m join place  on living_in=place_no 
join has_composed h  on h.cmpr_no=m.m_no  
join concert c on c.concert_organiser=m.m_no  
where place_country in ('england','scotland','wales');

/*9.Show the least commonly played instrument and the number of musicians who play it. (1 point possible)*/

select * from (select p.instrument,count(perf_is) as count_of_performer from performer p 
join musician m on p.perf_is=m.m_no group by p.instrument)tb
where tb.count_of_performer in ( select min(count_of_performer) from (select p.instrument,count(perf_is) as count_of_performer from performer p
join musician m on p.perf_is=m.m_no group by p.instrument));

/*10.List the bands that have played music composed by Sue Little; Give the titles of the composition in each case. (1 point possible)*/


/*11.List the name and town of birth of any performer born in the same city as James First.(1 point possible)*/

select m.m_name,p.place_town from musician m join place p on m.born_in=p.place_no where place_town=(select place_town from place p join 
musician m on m.born_in=p.place_no where m.m_name like '%James First%' );

/*12.Create a list showing for EVERY musician born in Britain the number of compositions and the number of instruments played. (1 point possible)*/


/*13.Give the band name, conductor and contact of the bands performing at the most recent concert in the Royal Albert Hall. (1 point possible)*/

select distinct(b.band_name),c.concert_organiser as conductor,b.band_contact from band b join concert c on c.concert_organiser=b.band_contact 
where b.band_contact in (select concert_organiser from concert where concert_venue like'%royal albert hall%'  
group by concert_organiser having con_date=max(con_date));





