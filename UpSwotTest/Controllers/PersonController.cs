using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using UpSwot.Persistence.Models;
using UpSwot.Persistence.Services.IServices;

namespace UpSwotTest.Controllers
{
    [Route("api/v1")]
    [ApiController]
    public class PersonController : Controller
    {
        private readonly IPersonService _personService;
        private readonly IEpisodeService _episodeService;
        public PersonController(IPersonService personService, IEpisodeService episodeService)
        {
            _personService = personService;
            _episodeService = episodeService;
        }

        [HttpGet("person", Name = nameof(GetPersonByName))]
        [ResponseCache(Duration = 600, VaryByQueryKeys = new[] { "name" })]
        public async Task<ActionResult<List<PersonDto>>> GetPersonByName([FromQuery]string name)
        {
            var response = await _personService.GetPersonByName(name);

            if (response.Count == 0) return NotFound($"{name} not found.");

            return Ok(response);
        }


        [HttpPost("check-person", Name = nameof(CheckPerson))]
        [ResponseCache(Duration = 600)]
        public async Task<ActionResult> CheckPerson(CheckPersonDto checkPersonDto)
        {

            var sw = new Stopwatch();
            sw.Start();
            var checkPerson = await GetPersonByName(checkPersonDto.PersonName);

            if (checkPerson.Result.ToString().Contains("NotFoundObjectResult"))
                return checkPerson.Result;

            var result = await _episodeService.GetEpisodesByName(checkPersonDto);

            sw.Stop();

            return Ok(result);
        }

    }
}