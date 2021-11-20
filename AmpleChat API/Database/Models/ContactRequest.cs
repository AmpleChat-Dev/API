
namespace AmpleChat_API.Database.Models
{
    public class ContactRequest
    {
        public int Id { get; set; }
        public bool Accepted { get; set; }
        public int UserId { get; set; }
        public Account User { get; set; }
    }
}

