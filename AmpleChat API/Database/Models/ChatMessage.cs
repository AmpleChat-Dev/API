namespace AmpleChat_API.Database.Models
{
	public class ChatMessage
	{
		public int Id { get; set; }
		public string Message { get; set; }
		public int UserId { get; set; }
		public Account User { get; set; }
	}

}
