Use [TravelEasyDb]


SET IDENTITY_INSERT [dbo].[Airports] ON
INSERT INTO Airports (AirportId, AirportName, AirportCountry, AirportCity) VALUES 
(1,'Zhuliany', 'Ukraine','Kyiv'),
(2,'Lviv', 'Ukraine','Lviv')
SET IDENTITY_INSERT [dbo].[Airports] OFF


SET IDENTITY_INSERT [dbo].[Routes] ON
INSERT INTO Routes (RouteId, DepartureAirportID, ArrivalAirportID, DistanceKm) VALUES 
(1,1,2,500),
(2,2,1,500)
SET IDENTITY_INSERT [dbo].[Routes] OFF

SET IDENTITY_INSERT [dbo].[Positions] ON
INSERT INTO Positions (PositionId, TitlePosition, DescPosition) VALUES 
(1,'ChiefPilot',''),
(2,'CoPilot',''),
(3,'Stewardess','')
SET IDENTITY_INSERT [dbo].[Positions] OFF


SET IDENTITY_INSERT [dbo].[Employees] ON
INSERT INTO Employees (EmployeeId, FullName, SomeInfo,PositionId) VALUES 
(1,'Maximillian Bowers','',1),
(2,'Kristen Best','',2),
(3,'Shane Cordova','',3),
(4,'Antony Brock','',3),
(5,'Lilia Zimmerman','',3)
SET IDENTITY_INSERT [dbo].[Employees] OFF
--

SET IDENTITY_INSERT [dbo].[CrewTeams] ON
INSERT INTO CrewTeams (CrewTeamId, FlightId, ChiefPilotID,CoPilotID, Stewardess_1_Id,Stewardess_2_Id,Stewardess_3_Id) VALUES 
(1,1,1,2,3,4,5)
SET IDENTITY_INSERT [dbo].[CrewTeams] OFF

SET IDENTITY_INSERT [dbo].[Planes] ON
INSERT INTO Planes (PlaneId, Model, SomeTechData) VALUES 
(1,'Test','')
SET IDENTITY_INSERT [dbo].[Planes] OFF


SET IDENTITY_INSERT [dbo].[Flights] ON
INSERT INTO Flights (FlightId, Date, RouteId, PlaneId, CrewTeamID, DepartureTime, ArrivalTime) VALUES 
(1,'2023-03-05',1,1,1,'2023-03-05 10:10:00','2023-03-05 11:10:00'),
(2,'2023-03-06',2,1,1,'2023-03-06 12:20:00','2023-03-06 13:20:00'),
(3,'2023-03-07',1,1,1,'2023-03-07 10:10:00','2023-03-07 11:10:00'),
(4,'2023-03-08',2,1,1,'2023-03-08 12:20:00','2023-03-08 13:20:00'),
(5,'2023-03-09',1,1,1,'2023-03-09 10:10:00','2023-03-09 11:10:00'),
(6,'2023-03-10',2,1,1,'2023-03-10 12:20:00','2023-03-10 13:20:00'),
(7,'2023-03-11',1,1,1,'2023-03-11 10:10:00','2023-03-11 11:10:00'),
(8,'2023-03-12',2,1,1,'2023-03-12 12:20:00','2023-03-12 13:20:00'),
(9,'2023-03-13',1,1,1,'2023-03-13 10:10:00','2023-03-13 11:10:00'),
(10,'2023-03-14',2,1,1,'2023-03-14 12:20:00','2023-03-14 13:20:00')
SET IDENTITY_INSERT [dbo].[Flights] OFF


SET IDENTITY_INSERT [dbo].[PassengersPersonalInfo] ON
INSERT INTO PassengersPersonalInfo (PassengerId, FullName, Passport, ClubMember) VALUES 
(1,'Samuel Wallace','AA11111AA',0),
(2,'Sami Frederick','AA11222AA',0),
(3,'Dafydd Welsh','AA13331AA',0),
(4,'Clyde Tate','AA45611AA',0),
(5,'Armaan Knowles','AA56811AA',0)
SET IDENTITY_INSERT [dbo].[PassengersPersonalInfo] OFF


SET IDENTITY_INSERT [dbo].[TicketOnSales] ON
INSERT INTO TicketOnSales (TS_Id, FlightId, Seat, Availability, Price) VALUES 
(0,1,'',0,0),
(1,4,'A1',1,100)

SET IDENTITY_INSERT [dbo].[TicketOnSales] OFF


SET IDENTITY_INSERT [dbo].[SoldTickets] ON
INSERT INTO SoldTickets (ST_Id, TS_Id,PassengerId, FlightId,DateOfSale, Seat, Price) VALUES 
(1,0,1,1,'2023-02-05', 'A1', 100),
(2,0,1,2,'2023-02-05', 'A2', 100),
(3,0,1,3,'2023-03-01', 'A3', 100),
(4,0,1,4,'2023-02-07', 'A4', 100),
(5,0,1,5,'2023-02-07', 'A5', 100),
(6,0,1,6,'2023-02-16', 'A6', 100),
(7,0,2,1,'2023-02-13', 'A7', 100),
(8,0,2,2,'2023-02-02', 'A8', 100),
(9,0,2,3,'2023-03-03', 'A9', 100),
(10,0,2,4,'2023-03-01', 'A10', 100),
(11,0,2,5,'2023-02-25', 'A1', 100),
(12,0,3,3,'2023-02-25', 'A2', 100),
(13,0,3,4,'2023-02-24', 'A3', 100),
(14,0,3,5,'2023-02-03', 'A4', 100),
(15,0,3,6,'2023-02-01', 'A5', 100),
(16,0,4,3,'2023-02-01', 'A6', 100),
(17,0,4,4,'2023-02-28', 'A7', 100),
(18,0,4,5,'2023-02-14', 'A1', 100),
(19,0,4,6,'2023-02-06', 'A2', 100),
(20,0,5,1,'2023-02-25', 'A3', 100),
(21,0,5,2,'2023-02-15', 'A4', 100)

SET IDENTITY_INSERT [dbo].[SoldTickets] OFF