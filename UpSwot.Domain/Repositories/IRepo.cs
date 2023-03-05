
namespace UpSwot.Domain.Repositories
{
    public interface IRepo
    {
        Task<T> GetDataFromTheRickAndMortyApiResult<T>(string url);
    }
}
