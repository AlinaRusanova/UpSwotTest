#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["UpSwotTest/UpSwotAPI.csproj", "UpSwotTest/"]
COPY ["UpSwot.Domain/UpSwot.Domain.csproj", "UpSwot.Domain/"]
COPY ["UpSwot.Persistence/UpSwot.Persistence.csproj", "UpSwot.Persistence/"]
RUN dotnet restore "UpSwotTest/UpSwotAPI.csproj"
COPY . .
WORKDIR "/src/UpSwotTest"
RUN dotnet build "UpSwotAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "UpSwotAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "UpSwotAPI.dll"]