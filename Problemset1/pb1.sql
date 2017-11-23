-- ProblemSet<No.1>, November <14> <2017> 
 -- Submission by <subashree.asokkumar@accenture.com>  



create table hotel

        (hotel_no varchar2 (6),

         name varchar2 (20),

         city varchar2 (20),

         constraint pk_hotel

         primary key (hotel_no));
  
   
 create table guest(guest_no varchar2(10),
                   name varchar2(20),city varchar2(20),
                   constraint pk_gno primary key(guest_no)); 
                   
                   
 create table room
        (room_no number (6),
         hotel_no varchar2 (20),
         type varchar2 (20),
         price varchar2(20),
         constraint pk_room
         primary key (room_no),
        constraint fk_hno foreign key(hotel_no)
        references hotel(hotel_no)
        );   


  create table booking (hotel_no varchar2(10),
                      guest_no varchar2(10),date_from date,
                     date_to date,room_no number(10),
                     constraint pk_date primary key(date_from,date_to),
                     constraint fk1_hno foreign key(hotel_no) 
                      references hotel(hotel_no),
                      constraint fk_gno foreign key(guest_no) references
                      guest(guest_no),
                      constraint fk_rno foreign key(room_no) references 
                      room(room_no)
                     );
                     
insert into hotel values('H111','Empire Hotel','New York');
insert into hotel values('H235','Park Place','New York');
insert into hotel values('H432','Brownstone Hotel','Toronto');
insert into hotel values('H498','James Plaza','Toronto');
insert into hotel values('H193','Devon Hotel','Boston');
insert into hotel values('H437','Clairmont Hotel','Boston');

select * from hotel;

HOTEL_NO	NAME	  CITY
H111	Empire Hotel	  New York
H235	Park Place	  New York
H432	Brownstone Hotel  Toronto
H498	James Plaza	  Toronto
H193	Devon Hotel	  Boston
H437	Clairmont Hotel	  Boston



insert into room values(313,'H111','S','145.00');
insert into room values(412,'H111','N','145.00');
insert into room values(1267,'H235','N','175.00');
insert into room values(1289,'H235','N','195.00');
insert into room values(876,'H432','S','124.00');
insert into room values(898,'H432','S','124.00');
insert into room values(345,'H498','N','160.00');
insert into room values(467,'H498','N','180.00');
insert into room values(1001,'H193','S','150.00');
insert into room values(1201,'H193','N','175.00');
insert into room values(257,'H437','N','140.00');
insert into room values(223,'H437','N','155.00');


select * from room;

ROOM_NO	HOTEL_NO  TYPE	PRICE
313	H111	S	145.00
412	H111	N	145.00
1267	H235	N	175.00
1289	H235	N	195.00
876	H432	S	124.00
898	H432	S	124.00
345	H498	N	160.00
467	H498	N	180.00
1001	H193	S	150.00
1201	H193	N	175.00



insert into guest values('G256','Adam Wayne','Pittsburgh');
insert into guest values('G367','Tara Cummings','Baltimore');
insert into guest values('G879','Vanessa Parry','Pittsburgh');
insert into guest values('G230','Tom Hancock','Philadelphia');
insert into guest values('G467','Robert Swift','Atlanta');
insert into guest values('G190','Edward Cane','Baltimore');   

select * from guest;

GUEST_NO  NAME	          CITY
G256	Adam Wayne	Pittsburgh
G367	Tara Cummings	Baltimore
G879	Vanessa Parry	Pittsburgh
G230	Tom Hancock	Philadelphia
G467	Robert Swift	Atlanta
G190	Edward Cane	Baltimore



insert into booking values('H111','G256','10-aug-99','15-aug-99',412);
insert into booking values('H111','G367','18-aug-99','21-aug-99',412);
insert into booking values('H235','G879','5-sep-99','12-sep-99',1267);
insert into booking values('H498','G230','15-sep-99','18-sep-99',467);
insert into booking values('H498','G256','30-nov-99','02-dec-99',345);
insert into booking values('H498','G467','03-nov-99','05-nov-99',345);
insert into booking values('H193','G190','15-nov-99','19-nov-99',1001);
insert into booking values('H193','G367','12-sep-99','14-sep-99',1001);
insert into booking values('H193','G367','01-oct-99','06-oct-99',1201);
insert into booking values('H437','G190','04-oct-99','06-oct-99',223);
insert into booking values('H437','G879','14-sep-99','17-sep-99',223);

select * from booking

HOTEL_NO GUEST_NO  DATE_FROM		DATE_TO	               ROOM_NO
H111	G256	1999-08-10T00:00:00Z	1999-08-15T00:00:00Z	412
H111	G367	1999-08-18T00:00:00Z	1999-08-21T00:00:00Z	412
H235	G879	1999-09-05T00:00:00Z	1999-09-12T00:00:00Z	1267
H498	G230	1999-09-15T00:00:00Z	1999-09-18T00:00:00Z	467
H498	G256	1999-11-30T00:00:00Z	1999-12-02T00:00:00Z	345
H498	G467	1999-11-03T00:00:00Z	1999-11-05T00:00:00Z	345
H193	G190	1999-11-15T00:00:00Z	1999-11-19T00:00:00Z	1001
H193	G367	1999-09-12T00:00:00Z	1999-09-14T00:00:00Z	1001
H193	G367	1999-10-01T00:00:00Z	1999-10-06T00:00:00Z	1201
H437	G190	1999-10-04T00:00:00Z	1999-10-06T00:00:00Z	223
H437	G879	1999-09-14T00:00:00Z	1999-09-17T00:00:00Z	223


