using AmpleChat_API.Database;
using AmpleChat_API.Database.Models;
using AmpleChat_API.Services.Models;
using System.Threading.Tasks;
using System.Linq;
using static BCrypt.Net.BCrypt;

namespace AmpleChat_API.Services
{
    public class UserService
    {
        private readonly DatabaseService databaseService;
        public UserService(DatabaseService dbs)
        {
            databaseService = dbs;
        }

        public bool SingIn(LoginModel model)
        {
            if (!UserExists(model.UserNameOrEmail, model.UserNameOrEmail))
                return false;

            var user = databaseService.Users.Where(i => i.Email == model.UserNameOrEmail || i.UserName == model.UserNameOrEmail).FirstOrDefault();

            return Verify(model.Password, user.Password);
        }

        public async Task<bool> SignUp(RegisterModel model)
        {
            // need to check  how secure the password is
            // hash password
            var passwordHash = HashPassword(model.Password);

            await databaseService.Users.AddAsync(new User
            {
                UserName = model.UserName,
                Email = model.Email,
                Password = passwordHash,
            });

            await databaseService.SaveChangesAsync();

            return true;
        }

        public bool UserExists(string email, string username)
        {
            var result = databaseService.Users.Where(i => i.Email == email || i.UserName == username).FirstOrDefault();

            if (result == null)
                return false;

            return true;
        }
    }
}
