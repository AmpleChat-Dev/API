using AmpleChat_API.Services;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using AmpleChatLibrary.User;

namespace AmpleChat_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserService userService;

        public AccountController(UserService uss)
        {
            userService = uss;
        }

        [HttpPost]
        public IActionResult SignIn([FromBody] LoginModel model)
        {
            if(!ModelState.IsValid)
                return BadRequest("Model not complete");

            if (!userService.SingIn(model))
                return BadRequest("Login failed");

            return Ok("Login success");
        }

        [HttpPut]
        public async Task<IActionResult> CreateUser([FromBody] RegisterModel model)
        {
            if (!ModelState.IsValid || !model.IsValid())
                return BadRequest("Model not complete");

            if (userService.UserExists(model.Email, model.UserName))
                return BadRequest("This email/username has already been taken");

            var userCreated = await userService.SignUp(model);
             
            if (userCreated)
                return Ok("User created");

            return BadRequest("Could not create user");
        }

    }
}
