using System;
using System.Collections.Generic;

namespace AmpleChat_API.Database.Models
{
    public class Account
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public IList<Account> Contacts { get; set; } = new List<Account>();
        //public IList<ContactRequest> ContactRequests { get; set; } = new List<ContactRequest>();
        //public IList<ChatMessage> Messages { get; set; } = new List<ChatMessage>();
    }
}

