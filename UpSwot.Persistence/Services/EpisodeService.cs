using System.Text;
using System.Text.RegularExpressions;
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

            var listWithCharacterNames = await FillCharactersDataWithMultyURL(choosenEpisode);  //FillCharactersData(choosenEpisode);

            if (listWithCharacterNames.ListOfCharactersName.Find(x => x.Contains(checkPersonDto.PersonName, StringComparison.OrdinalIgnoreCase)).Count() > 0)
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

        private async Task<Episodes> FillCharactersDataWithMultyURL(Episodes choosenEpisode)
        {
            var urlCharacter = "https://rickandmortyapi.com/api/character/{0}";

            var pattern = "https://rickandmortyapi.com/api/character/";

            var sb = new StringBuilder();

            foreach (var item in choosenEpisode.Characters)
            {
                var id = Regex.Split(item, pattern)[1];
                sb.Append(id + ",");
            }

            sb.Length = sb.Length - 1;
            sb.ToString();

            var listOfCharacters = await _repo.GetDataFromTheRickAndMortyApiResult<Character[]>(String.Format(urlCharacter,sb));

            choosenEpisode.ListOfCharactersName = listOfCharacters.Select(n => n.Name).ToList();

            return choosenEpisode;
        }
    }
}
