using UpSwot.Domain.Entitties;
using UpSwot.Persistence.Models;

namespace UpSwot.Persistence.Services.IServices
{
    public interface IPersonService
    {
        Task<List<PersonDto>> GetPersonByName(string name);
    }
}
