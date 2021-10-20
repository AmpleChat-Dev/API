using AmpleChat_API.Services;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using AmpleChat_API.Services.Models;

namespace AmpleChat_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService userService;

        public UserController(UserService uss)
        {
            userService = uss;
        }

        [HttpPost("new")]
        public async Task<IActionResult> CreateUser([FromBody] RegisterModel model)
        {

            if (!ModelState.IsValid || !model.IsValid())
                return BadRequest("Model not complete");

            if (userService.UserExists(model.Email, model.UserName))
                return BadRequest("This email/username has already been taken");

            var userCreated = await userService.CreateAccount(model);
             
            if (userCreated)
                return Ok("User created");

            return BadRequest("Could not create user");
        }

    }
}
