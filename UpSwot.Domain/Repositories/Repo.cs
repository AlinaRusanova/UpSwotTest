
using System.Text.Json;

namespace UpSwot.Domain.Repositories
{
    public class Repo: IRepo
    {
        private static readonly HttpClient client = new HttpClient();

        public async Task<T> GetDataFromTheRickAndMortyApiResult<T>(string url)
        {
            if (string.IsNullOrEmpty(url))
            { throw new ArgumentNullException(); }

            HttpResponseMessage response = await client.GetAsync(url);

            string responseBody = await response.Content.ReadAsStringAsync();

            var entityResponse = JsonSerializer.Deserialize<T>(responseBody, new JsonSerializerOptions() { PropertyNameCaseInsensitive = true });
            return entityResponse;
        }
    }
}
