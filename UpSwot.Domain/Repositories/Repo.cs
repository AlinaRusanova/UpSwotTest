using System.Text.Json;

namespace UpSwot.Domain.Repositories
{
    public class Repo: IRepo, IDisposable
    {
        private static readonly HttpClient client = new HttpClient();
        bool _disposed;

        public async Task<T> GetDataFromTheRickAndMortyApiResult<T>(string url)
        {
            if (string.IsNullOrEmpty(url))
            { throw new ArgumentNullException(); }

            HttpResponseMessage response = await client.GetAsync(url);

            string responseBody = await response.Content.ReadAsStringAsync();

            var entityResponse = JsonSerializer.Deserialize<T>(responseBody, new JsonSerializerOptions() { PropertyNameCaseInsensitive = true  });
            return entityResponse;
        }

        protected virtual void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
                client.Dispose();

            _disposed = true;
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

    }
}
