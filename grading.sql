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

select e.FirstName,e.LastName,InvoiceID  from Invoice join Employee e  where  e.title='Sales Support Agent';

/*7.Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.*/


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



















