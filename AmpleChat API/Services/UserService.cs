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

        public async Task<bool> CreateAccount(RegisterModel model)
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

        public bool LoginAccount(LoginModel model)
        {
            var user = databaseService.Users.Where(i => i.UserName == model.UserNameOrEmail || i.Email == model.UserNameOrEmail).FirstOrDefault();

            if (user == null)
                return false;

            return Verify(model.Password, user.Password);
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
