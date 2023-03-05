using UpSwot.Domain.Entitties.Addition;

namespace UpSwot.Domain.Entitties
{
    public class Episodes: Entity
    {
        public string Name { get; set; }
        public string Episode { get; set; }
        public string[] Characters { get; set; }
        public string Url { get; set; }
        public List<string> ListOfCharactersName { get; set; } = new();
    }
}
