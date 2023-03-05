-- Список квитків з даними клієнта.
select st.ST_Id TicketId, st.PassengerId , ppi.FullName, ppi.Passport , st.DateOfSale, st.Price, st.Seat, 
		r.DepartureCity, r.ArrivalCity, 
		f.Date DateOfFlight
from PassengersPersonalInfo ppi
left join SoldTickets st on ppi.PassengerId = st.PassengerId
left join Flights f on st.FlightId = f.FlightId
left join (select r.RouteId,da.AirportCity DepartureCity, aa.AirportCity ArrivalCity from Routes r 
			left join Airports aa on r.ArrivalAirportID = aa.AirportId left join Airports da on r.DepartureAirportID = da.AirportId) r 
			on r.RouteId =  f.RouteId


-- Останні 5 проданих квитків
select TOP 5 st.ST_Id TicketId, st.DateOfSale, ppi.FullName PassengerFullName, st.Seat, st.Price, r.DepartureCity,r.ArrivalCity from SoldTickets st
left join Flights f on st.FlightId = f.FlightId
left join (select r.RouteId,da.AirportCity DepartureCity, aa.AirportCity ArrivalCity from Routes r 
			left join Airports aa on r.ArrivalAirportID = aa.AirportId left join Airports da on r.DepartureAirportID = da.AirportId) r 
			on r.RouteId =  f.RouteId
left join PassengersPersonalInfo ppi on ppi.PassengerId = st.PassengerId
order by DateOfSale desc


-- Топ 3 клієнтів за частотою польотів

select TOP 3 WITH TIES ppi.PassengerId , ppi.FullName, Count(st.ST_Id) CountTickets
from PassengersPersonalInfo ppi
left join SoldTickets st on ppi.PassengerId = st.PassengerId
Group By ppi.PassengerId, ppi.FullName
Order by CountTickets desc