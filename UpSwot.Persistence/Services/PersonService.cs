using UpSwot.Domain.Entitties;
using UpSwot.Domain.Repositories;
using UpSwot.Persistence.Models;
using UpSwot.Persistence.Services.IServices;

namespace UpSwot.Persistence.Services
{
    public class PersonService: IPersonService
    {
        private readonly IRepo _repo;
        public PersonService(IRepo repo)
        {
            _repo = repo;   
        }
        
        public async Task<List<PersonDto>> GetPersonByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            { throw new ArgumentNullException(); }

            string url = $"https://rickandmortyapi.com/api/character/?name={name}";

            var entityResponse = await _repo.GetDataFromTheRickAndMortyApiResult<CharacterResponse>(url);

            var model = new List<PersonDto>();

            if (entityResponse.Results == null)
            { 
                return model;
            }
            var entityWithFullOriginData = await GetOriginData(entityResponse);
            model = await MappingToDto(entityWithFullOriginData);

            return model;
        }

        private async Task<CharacterResponse> GetOriginData(CharacterResponse entity)
        {
            
            foreach (var item in entity.Results)
            {
                if (!string.IsNullOrEmpty(item.Origin.Url))
                {
                    var origin = await _repo.GetDataFromTheRickAndMortyApiResult<CharacterOrigin>(item.Origin.Url);
                    item.Origin.Name = origin.Name;
                    item.Origin.Type = origin.Type;
                    item.Origin.Dimension = origin.Dimension;
                }   
            }
            return entity;
        }

        private async Task<List<PersonDto>> MappingToDto(CharacterResponse entity)
        {
            return entity.Results.Select(e => new PersonDto() {Name = e.Name, Status = e.Status,Species = e.Species, Type = e.Type, Gender = e.Gender, 
                            Origin = new OriginDto() {Name = e.Origin.Name, Type = e.Origin.Type, Dimension = e.Origin.Dimension } })
                   .ToList();
        }

    }
}
