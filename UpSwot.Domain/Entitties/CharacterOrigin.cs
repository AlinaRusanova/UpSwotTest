
using UpSwot.Domain.Entitties.Addition;

namespace UpSwot.Domain.Entitties
{
    public class CharacterOrigin: Entity
    {
        public string Name { get; set; }
        public string Url { get; set; }
        public string Type { get; set; } = "unknown";
        public string Dimension { get; set; } = "unknown";
    }
}
