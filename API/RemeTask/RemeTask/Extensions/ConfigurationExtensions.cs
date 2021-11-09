using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.DependencyInjection;
using RemeTask.Auth;
using RemeTask.Data;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

namespace RemeTask.Extensions
{
    public static class ConfigurationExtensions
    {
        public static IServiceCollection AddRepositoriesDependencies(this IServiceCollection services)
        {
            return services
                .AddScoped<ITaskRepository, TaskRepository>()
                .AddScoped<ITaskGroupRepository, TaskGroupRepository>()
                .AddScoped<IWorkspaceRepository, WorkspaceRepository>()
                .AddScoped<IInvitationRepository, InvitationRepository>();
        }

        public static IServiceCollection AddAuthorizationDependencies(this IServiceCollection services, IConfiguration configuration)
        {
            return services
                .AddTransient<ITokenManager, TokenManager>()
                .AddScoped<IUserRepository>(sp => new UserRepository(sp.GetService<RemetaskContext>(), configuration["JwtSettings:Secret"]));
        }

        public static AuthenticationBuilder AddJwtAuthentication(this IServiceCollection services, IConfiguration configuration)
        {
             return services.AddAuthentication(options =>
                 {
                     options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                     options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                     options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
                 })
                 .AddJwtBearer(options =>
                 {
                     options.TokenValidationParameters.ValidAudience = configuration["JwtSettings:ValidAudience"];
                     options.TokenValidationParameters.ValidIssuer = configuration["JwtSettings:ValidIssuer"];
                     options.TokenValidationParameters.IssuerSigningKey =
                         new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["JwtSettings:Secret"]));
                 });
        }

        public static IServiceCollection AddSwagger(this IServiceCollection services)
        {
            return services.AddSwaggerGen(x =>
            {
                x.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Description = "JWT Authorization header using the bearer scheme",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.ApiKey
                });
                x.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {new OpenApiSecurityScheme{Reference = new OpenApiReference
                    {
                        Id = "Bearer",
                        Type = ReferenceType.SecurityScheme
                    }}, new List<string>()}
                });
            });
        }
    }
}
