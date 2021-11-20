using AmpleChat_API.Database;
using AmpleChat_API.Database.Models;
using AmpleChatLibrary.User;
using System.Threading.Tasks;
using System.Linq;
using static BCrypt.Net.BCrypt;

namespace AmpleChat_API.Services
{
    public class AccountService
    {
        private readonly DatabaseService databaseService;
        public AccountService(DatabaseService dbs)
        {
            databaseService = dbs;
        }

        public bool PasswordLogin(LoginModel model)
        {
            if (!AccountExists(model.UserNameOrEmail, model.UserNameOrEmail))
                return false;

            var user = databaseService.Accounts.Where(i => i.Email == model.UserNameOrEmail || i.UserName == model.UserNameOrEmail).FirstOrDefault();

            return Verify(model.Password, user.Password);
        }

        public async Task<bool> RegisterAccount(RegisterModel model)
        {
            // need to check  how secure the password is
            // hash password
            var passwordHash = HashPassword(model.Password);

            await databaseService.Accounts.AddAsync(new Account
            {
                UserName = model.UserName,
                Email = model.Email,
                Password = passwordHash,
            });

            await databaseService.SaveChangesAsync();

            return true;
        }

        public bool AccountExists(string email, string username)
        {
            var result = databaseService.Accounts.Where(i => i.Email == email || i.UserName == username).FirstOrDefault();

            if (result == null)
                return false;

            return true;
        }
    }
}
