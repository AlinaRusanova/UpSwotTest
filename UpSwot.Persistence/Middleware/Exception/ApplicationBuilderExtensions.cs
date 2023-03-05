using Microsoft.AspNetCore.Builder;

namespace UpSwot.Persistence.Exceptions
{
    public static class ApplicationBuilderExtensions
    {
        public static IApplicationBuilder AddGlobalErrorHandler(this IApplicationBuilder applicationBuilder)
     => applicationBuilder.UseMiddleware<GlobalExceptionHandlingMiddleware>();
    }
}
