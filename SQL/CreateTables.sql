Use [TravelEasyDb]

GO
CREATE TABLE Airports(
[AirportId] INT NOT NULL IDENTITY(1,1),
[AirportName] NVARCHAR(50) NOT NULL UNIQUE,
[AirportCountry] NVARCHAR(50) NOT NULL,
[AirportCity] NVARCHAR(50) NOT NULL,
CONSTRAINT [PK_Airports] PRIMARY KEY CLUSTERED ([AirportId] ASC)
);
GO


GO
CREATE TABLE Routes(
[RouteId] INT NOT NULL IDENTITY(1,1),
[DepartureAirportID] int NOT NULL,
[ArrivalAirportID] int NOT NULL,
[DistanceKm] int NOT NULL,
CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED ([RouteId] ASC),
CONSTRAINT [FK_Routes_Airoports_DepartureAirportID] FOREIGN KEY ([DepartureAirportID]) REFERENCES [dbo].[Airports] ([AirportId]),
CONSTRAINT [FK_Routes_Airoports_ArrivalAirportID] FOREIGN KEY ([ArrivalAirportID]) REFERENCES [dbo].[Airports] ([AirportId])
);
GO


GO
CREATE TABLE Positions(
[PositionId] INT NOT NULL IDENTITY(1,1),
[TitlePosition] NVARCHAR(50) NOT NULL UNIQUE,
[DescPosition] NVARCHAR(50),
CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([PositionId] ASC)
);
GO

GO
CREATE TABLE Employees(
[EmployeeId] INT NOT NULL IDENTITY(1,1),
[FullName] NVARCHAR(50) NOT NULL,
[SomeInfo] NVARCHAR(50),  -- addition table
[PositionId] int NOT NULL,
CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeId] ASC),
CONSTRAINT [FK_Employees_Positions_PositionId] FOREIGN KEY ([PositionId]) REFERENCES [dbo].[Positions] ([PositionId])
);
GO


GO
CREATE TABLE CrewTeams(
[CrewTeamId] INT NOT NULL IDENTITY(1,1),
[FlightId] int NOT NULL,
[ChiefPilotID] int NOT NULL,
[CoPilotID] int NOT NULL,
[Stewardess_1_Id] int NOT NULL,
[Stewardess_2_Id] int NOT NULL,
[Stewardess_3_Id] int NOT NULL,
CONSTRAINT [PK_CrewTeams] PRIMARY KEY CLUSTERED ([CrewTeamId] ASC),
CONSTRAINT [FK_CrewTeams_Flights_FlightId] FOREIGN KEY ([FlightId]) REFERENCES [dbo].[Employees] ([EmployeeId]),
CONSTRAINT [FK_CrewTeams_Employees_ChiefPilotID] FOREIGN KEY ([ChiefPilotID]) REFERENCES [dbo].[Employees] ([EmployeeId]),
CONSTRAINT [FK_CrewTeams_Employees_CoPilotID] FOREIGN KEY ([CoPilotID]) REFERENCES [dbo].[Employees] ([EmployeeId]),
CONSTRAINT [FK_CrewTeams_Employees_Stewardess_1_Id] FOREIGN KEY ([Stewardess_1_Id]) REFERENCES [dbo].[Employees] ([EmployeeId]),
CONSTRAINT [FK_CrewTeams_Employees_Stewardess_2_Id] FOREIGN KEY ([Stewardess_2_Id]) REFERENCES [dbo].[Employees] ([EmployeeId]),
CONSTRAINT [FK_CrewTeams_Employees_Stewardess_3_Id] FOREIGN KEY ([Stewardess_3_Id]) REFERENCES [dbo].[Employees] ([EmployeeId]),
);
GO

GO
CREATE TABLE Planes(
[PlaneId] INT NOT NULL IDENTITY(1,1),
[Model] NVARCHAR(50) NOT NULL,
[SomeTechData] NVARCHAR(50) NOT NULL,  -- addition table
CONSTRAINT [PK_Planes] PRIMARY KEY CLUSTERED ([PlaneId] ASC)
);
GO

GO
CREATE TABLE Flights(
[FlightId] INT NOT NULL IDENTITY(1,1),
[Date] date NOT NULL,
[RouteId] int NOT NULL,
[PlaneId] int NOT NULL,
[CrewTeamID] int NOT NULL,
[DepartureTime] date NOT NULL,
[ArrivalTime] date NOT NULL
CONSTRAINT [PK_Flights] PRIMARY KEY CLUSTERED ([FlightId] ASC),
CONSTRAINT [FK_Flights_Routes_RouteID] FOREIGN KEY ([RouteID]) REFERENCES [dbo].[Routes] ([RouteID]),
CONSTRAINT [FK_Flights_Planes_PlaneId] FOREIGN KEY ([PlaneId]) REFERENCES [dbo].[Planes] ([PlaneId]),
CONSTRAINT [FK_Flights_CrewTeams_CrewTeamID] FOREIGN KEY ([CrewTeamID]) REFERENCES [dbo].[CrewTeams] ([CrewTeamID]),
);
GO


GO
CREATE TABLE PassengersPersonalInfo(
[PassengerId] INT NOT NULL IDENTITY(1,1),
[FullName] NVARCHAR(50) NOT NULL,
[Passport] NVARCHAR(50) NOT NULL, 
[ClubMember] int NOT NULL,  --enum yes/no
CONSTRAINT [PK_PassengersPersonalInfo] PRIMARY KEY CLUSTERED ([PassengerId] ASC)
);
GO

GO
CREATE TABLE TicketOnSales(
[TS_Id] INT NOT NULL IDENTITY(0,1), -- id квитка на в≥дкритий(запланований) рейс
[FlightId] int NOT NULL, 
[Seat] NVARCHAR(50) NOT NULL, 
[Availability] int NOT NULL, -- 0/1
[Price] int NOT NULL, 
CONSTRAINT [PK_TicketOnSales] PRIMARY KEY CLUSTERED ([TS_Id] ASC),
CONSTRAINT [FK_TicketOnSales_Flights_FlightId] FOREIGN KEY ([FlightId]) REFERENCES [dbo].[Flights] ([FlightId])
);
GO

GO
CREATE TABLE SoldTickets(
[ST_Id] INT NOT NULL IDENTITY(1,1), 
[TS_Id] INT NOT NULL, -- таблиц€ оновлюЇтьс€ в момент куп≥вл≥ квитка, але оск≥льки пасажир може його повернути то залишаю зв€зану запис в перел≥ку квитк≥в на майбутн≥ рейси, 0-рейс в≥дбувс€
[FlightId] int NOT NULL, 
[DateOfSale] smalldatetime NOT NULL, 
[PassengerId] int NOT NULL, 
[Price] int NOT NULL, 
[Seat] NVARCHAR(50) NOT NULL,
CONSTRAINT [PK_SoldTickets] PRIMARY KEY CLUSTERED ([ST_Id] ASC),
CONSTRAINT [FK_TSoldTickets_TicketOnSales_TS_Id] FOREIGN KEY ([TS_Id]) REFERENCES [dbo].[TicketOnSales] ([TS_Id]),
CONSTRAINT [FK_TSoldTickets_Flights_FlightId] FOREIGN KEY ([FlightId]) REFERENCES [dbo].[Flights] ([FlightId]),
CONSTRAINT [FK_TSoldTickets_PassengersPersonalInfo_PassengerId] FOREIGN KEY (PassengerId) REFERENCES [dbo].[PassengersPersonalInfo] (PassengerId)
);
GO