using System.ComponentModel.DataAnnotations;

namespace AmpleChat_API.Services.Models
{
    public class LoginModel
    {
        [Required]
        public string UserNameOrEmail { get; set; }

        [Required]
        public string Password { get; set; }

        public bool IsValid()
        {
            var usernameOrEmail = !string.IsNullOrEmpty(UserNameOrEmail);
            var password = !string.IsNullOrEmpty(Password);

            return usernameOrEmail && password;
        }
    }
}
