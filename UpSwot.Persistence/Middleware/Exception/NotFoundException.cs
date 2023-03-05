
namespace UpSwot.Persistence.Exceptions
{
    public class NotFoundException : Exception
    {
        public NotFoundException(string name, string obj) : base($"{obj} {name} not found.") { }
    }
}
