FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["local-hands-gateway.csproj", "."]
RUN dotnet restore "local-hands-gateway.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "local-hands-gateway.csproj" -c Release -o /app/build
RUN dotnet publish "local-hands-gateway.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "local-hands-gateway.dll"]
