using UpSwot.Domain.Repositories;
using UpSwot.Persistence.Exceptions;
using UpSwot.Persistence.Services;
using UpSwot.Persistence.Services.IServices;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddResponseCaching();

builder.Services.AddScoped<IRepo, Repo>();
builder.Services.AddScoped<IPersonService, PersonService>();
builder.Services.AddScoped<IEpisodeService, EpisodeService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthorization();

app.MapControllers();

app.AddGlobalErrorHandler();
app.UseResponseCaching();

app.Run();
