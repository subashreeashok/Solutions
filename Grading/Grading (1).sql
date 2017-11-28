-- ProblemSet<Grading Set>, November <28> <2017> 
-- Submission by <subashree.asokkumar@accenture.com>  

/*1.Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.*/

select CustomerId,FirstNAme,LastName,Country from Customer where Country not like '%USA%';

/*2.Provide a query only showing the Customers from Brazil.*/

select CustomerId,FirstNAme,LastName,Country from Customer where Country  like '%Brazil%';

/*3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the 
customer's full name, Invoice ID, Date of the invoice and billing country.*/

Select FirstName,LAstName,InvoiceId,InvoiceDate,BillingCountry from Customer c join Invoice i on c.CustomerId=i.InvoiceId where c.Country='Brazil';

/*4.Provide a query showing only the Employees who are Sales Agents.*/

  Select EmployeeId,FirstName,LastName from Employee where Title like '%Agent%';

/*5.Provide a query showing a unique/distinct list of billing countries from the Invoice table.*/

Select distinct(BillingCountry) from Invoice;

/*6.Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.*/

select e.FirstName,e.LastName ,i.InvoiceId from Invoice i join Customer c on i.CustomerId=c.CustomerId join Employee e on c.SupportRepId=e.EmployeeId group by i.InvoiceId;

/*7.Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.*/

select i.Total as InvoiceTotal,c.FirstName,c.Country,e.FirstName from Invoice i,Customer c,Employee e where i.CustomerId=c.CustomerId and e.EmployeeId=c.SupportRepId;

/*8. How many Invoices were there in 2009 and 2011?*/

select count(InvoiceDate) from Invoice where InvoiceDate in(Select InvoiceDate from Invoice where InvoiceDate like '%2009%' union Select InvoiceDate 
from Invoice where InvoiceDate like '%2011%');

/*9. What are the respective total sales for each of those years?*/

select total from Invoice where InvoiceDate in(Select InvoiceDate from Invoice where InvoiceDate like '%2009%' union Select InvoiceDate 
from Invoice where InvoiceDate like '%2011%');

/*10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.*/

select count(*) from  InvoiceLine where InvoiceId=37;

/*11.Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY*/

select count(*),InvoiceId from  InvoiceLine group by(InvoiceId);

/*12.  Provide a query that includes the purchased track name with each invoice line item.*/

select t.Name from Track t join InvoiceLine i on t.TrackId=i.TrackId;

/*13.Provide a query that includes the purchased track name AND artist name with each invoice line item.*/

select t.Name,a.Name from Artist a join Album al on a.ArtistId=al.ArtistId join Track t on t.AlbumId=al.AlbumId join InvoiceLine i on  t.trackid=i.trackid;

/*14. Provide a query that shows the # of invoices per country. HINT: GROUP BY*/

select count(*) from Invoice group by BillingCountry; 

/*15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.*/

select count(*),p.name from Playlist pl join Playlist p on p.PlaylistId=pl.PlaylistID group by pl.PlaylistID;

/*16.Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.*/

select t.NAme,al.Title,m.Name,g.Name from Album al,Track t,MediaType m,Genre g on al.AlbumID=t.AlbumID and g.GenreId=t.GenreId and m.MediaTypeId=t.MediaTypeID; 

/*17. Provide a query that shows all Invoices but includes the # of invoice line items.*/

select count(InvoiceLineId) as Invoices from Invoice i join InvoiceLine il on i.InvoiceID=il.InvoiceId group by i.InvoiceId;

/*18. Provide a query that shows total sales made by each sales agent.*/

select sum(total),e.FirstName as Sales from Customer c,Invoice i,Employee e where e.EmployeeId=c.SupportRepId and c.CustomerId=i.CustomerId group by EmployeeId ;

/*19. Which sales agent made the most in sales in 2009?*/

select e.FirstName,max(Sales) from(select sum(total) as Sales,i.InvoiceDate, e.FirstName
  from Customer c,Invoice i,Employee e where e.EmployeeId=c.SupportRepId and c.CustomerId=i.CustomerId
 group by EmployeeId having i.InvoiceDate like '%2009%');

/*20.Which sales agent made the most in sales over all*/

select e.FirstName,max(Sales) from(select sum(total) as Sales,i.InvoiceDate, e.FirstName
  from Customer c,Invoice i,Employee e where e.EmployeeId=c.SupportRepId and c.CustomerId=i.CustomerId
 group by EmployeeId);

/*21. Provide a query that shows the count of customers assigned to each sales agent.*/

select count(CustomerId) as Customers from Customer c,Employee e where e.EmployeeId=c.SupportRepId  group by e.EmployeeId having e.Title='Sales Support Agent';

/*22.Provide a query that shows the total sales per country.*/

select sum(total) as Total_sales,BillingCountry as Country from Invoice group by BillingCountry;

/*23.Which country's customers spent the most?*/

select max(Total_Sales),Country from (select sum(total) as Total_sales,BillingCountry as Country from Invoice group by BillingCountry);

/*24.Provide a query that shows the most purchased track of 2013.*/

select t.TrackID,t.Name,i.InvoiceDate from Invoice i join InvoiceLine il on i.InvoiceId=il.InvoiceID join Track t on il.TrackId=t.TrackId where InvoiceDate like '%2013%' ;

/*25.Provide a query that shows the top 5 most purchased tracks over all.*/

select t.Name,t.TrackID,count(il.InvoiceLineId)  FROM Track t, InvoiceLine il WHERE il.TrackId = t.TrackId GROUP BY t.Name order by count(il.InvoiceLineId) desc Limit 5;

/*26.Provide a query that shows the top 3 best selling artists.*/

select a.name, t.TrackId,count(il.InvoiceLineId) from Artist a, InvoiceLine il, Track t, Album al where il.TrackId = t.TrackId and t.AlbumId = al.AlbumId and 
al.ArtistId = art.ArtistId group by art.Name order by count(il.InvoiceLineId)  desc Limit 3;

/*27.Provide a query that shows the most purchased Media Type.*/

select max(media_type),mt.Name from (select mt.Name,count(il.InvoiceLineId) as "media_type" from MediaType mt, InvoiceLine il, Track t 
where il.TrackId = t.TrackId and t.MediaTypeId = mt.MediaTypeId group by mt.Name );
















