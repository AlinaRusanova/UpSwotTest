using UpSwot.Domain.Entitties;
using UpSwot.Domain.Repositories;
using UpSwot.Persistence.Exceptions;
using UpSwot.Persistence.Models;
using UpSwot.Persistence.Services.IServices;

namespace UpSwot.Persistence.Services
{
    public class EpisodeService:IEpisodeService
    {
        private readonly IRepo _repo;
        public EpisodeService(IRepo repo)
        {
            _repo = repo;
        }

        public async Task<bool> GetEpisodesByName(CheckPersonDto checkPersonDto)
        {
            string url = $"https://rickandmortyapi.com/api/episode";

            var listOfEpisodes = await _repo.GetDataFromTheRickAndMortyApiResult<EpisodesResponse>(url);

            var choosenEpisode = listOfEpisodes.Results.Where(n => n.Name.ToLower() == checkPersonDto.EpisodeName.ToLower() /*|| n.Episode == checkPersonDto.EpisodeName*/).FirstOrDefault(); 

            if (choosenEpisode == null)
            {
              throw  new NotFoundException(checkPersonDto.EpisodeName,"Episode");
            }

           var listWithCharacterNames = await FillCharactersData(choosenEpisode);

            if(listWithCharacterNames.ListOfCharactersName.Contains(checkPersonDto.PersonName))
                return true;

            return false;
        }

        private async Task<Episodes> FillCharactersData(Episodes choosenEpisode)
        {

            foreach (var item in choosenEpisode.Characters)
            {
                if (!string.IsNullOrEmpty(item))
                {
                    var origin = await _repo.GetDataFromTheRickAndMortyApiResult<Character>(item);
                    choosenEpisode.ListOfCharactersName.Add(origin.Name);
                }
            }
            return choosenEpisode;
        }
    }
}
