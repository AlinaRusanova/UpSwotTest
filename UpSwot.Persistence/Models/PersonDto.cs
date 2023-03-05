
namespace UpSwot.Persistence.Models
{
    public class PersonDto
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public string Species { get; set; }
        public string Type { get; set; }
        public string Gender { get; set; }
        public OriginDto Origin { get; set; }
    }
}
