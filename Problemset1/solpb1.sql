/*<1.List full details of all hotels>*/

select * from hotel;

/*Record Count: 6*/

/*<2.List full details of all hotels in New York>*/

select * from hotel where city='New York';

/* Record Count: 2;*/

/*<3.List the names and cities of all guests,ordered according to their cities>*/

select * from guest order by city;

/*Record Count: 6*/

/*<4. List all the non-smoking rooms in ascending order of price>*/

select * from room where type='N' order by price;

/*Record Count: 8*/

/*<5. List the number of hotels there are>*/

select count(hotel_no) from hotel;

/*Record Count: 1*/

/*<6. List the cities in which the guest live.each city should belisted only once>*/

select distinct(city) from guest;

/*Record Count: 4*/

/*<7. List the average price of  a room>*/

select avg(price) from room;

/*Record Count: 1*/


/*<8. List hotel names,their roo numbers,and the type of that room>*/

select name,room_no,type from room r join hotel h 
on r.hotel_no=h.hotel_no;

/*Record Count: 12*/


/*<9. List hotel names,booking date,room number for all hotels in new york>*/

select name,date_from,date_to,room_no from booking b join hotel h 
on b.hotel_no=h.hotel_no where city='New York'; 

/*Record Count: 3*/

/*<10.What is the number of bookings that started in the month of September?>*/

select count(guest_no) as sep_booking from booking
where extract(month from date_from)=9;

/*Record Count: 1*/


/*<11.List the names and cities of guests who began a stay in New York in August.>*/

select g.Name,g.City from guest g  join booking b on
g.guest_No=b.guest_No inner join Hotel h on
h.Hotel_no=b.Hotel_No where h.City='New York' and 
EXTRACT(month FROM b.Date_From)=8;


/*Record Count: 2*/


/*<12. List the hotel names and room numbers of any hotel rooms that have not been booked>*/

select h.name,r.room_no from hotel h inner join room r on 
h.hotel_no=r.hotel_no 
where h.hotel_no not in (select hotel_no from booking); 

/*Record Count: 2*/


/*<13. List the hotel name and city of the hotel with the highest priced room.>*/

select h.name,h.city from hotel h join room r 
on h.hotel_no=r.hotel_no where 
price=(select max(price) from room);

/*Record Count: 1*/


/*<14.  List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston> */

select h.name,h.city,r.room_no,r.price from hotel h
inner join room r on h.hotel_no=r.hotel_no
where r.price<
(select MIN(r.price) from room r inner join
 hotel h on h.hotel_no=r.hotel_no where h.city='Boston');

/*Record Count: 2*/

/*<15.List the average price of a room grouped by city.>*/

select avg(price) from room r join 
hotel h on r.hotel_no=h.hotel_no group by h.city;

/*Record Count: 2*/

