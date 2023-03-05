using UpSwot.Persistence.Models;

namespace UpSwot.Persistence.Services.IServices
{
    public interface IEpisodeService
    {
        Task<bool> GetEpisodesByName(CheckPersonDto checkPersonDto);
    }
}
