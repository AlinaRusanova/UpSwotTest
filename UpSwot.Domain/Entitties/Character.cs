using UpSwot.Domain.Entitties.Addition;
namespace UpSwot.Domain.Entitties
{
    public class Character: Entity
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public string Species { get; set; }
        public string Type { get; set; }
        public string Gender { get; set; }
        public CharacterOrigin Origin { get; set; }
        public IEnumerable<string> Episode { get; set; }
    }
}
