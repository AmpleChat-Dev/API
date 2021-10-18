using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using AmpleChat_API.Controllers;
using AmpleChat_API.Services;
using AmpleChat_API.Database;
using AmpleChat_API.Services.Models;
using Xunit;

namespace AmpleChat_API_UnitTest
{
    public class UserUnitTest : IDisposable
    {
        private readonly DatabaseService DatabaseService;
        
        private static RegisterModel CreateValidRegisterModel()
        {
            return new RegisterModel {
                Email = "test@amplechat.com",
                Password = "P@ssW0rd!",
                UserName = "sickusername"
            };
        }

        private static RegisterModel CreateInValidRegisterModel()
        {
            return new RegisterModel {
                Email = string.Empty,
                Password = string.Empty,
                UserName = string.Empty
            };
        }

        public UserUnitTest()
        {
            DatabaseService = new DatabaseService(new DbContextOptionsBuilder<DatabaseService>().UseInMemoryDatabase(databaseName: "test_db").Options);
        }

        [Fact(DisplayName = "Create a user with valid data, user should be created")]
        public async void Create_Valid_User()
        {
            var userService = new UserService(DatabaseService);

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult) await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode);
        }

        [Fact(DisplayName = "Creat a user but with invalid data, user should not be created")]
        public async void Create_InValid_User()
        {
            var userService = new UserService(DatabaseService);

            var userController = new UserController(userService);

            var model = CreateInValidRegisterModel();

            var createRequest = (BadRequestObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest.StatusCode.Value);
        }

        [Fact(DisplayName = "Create a user and try to create that exact same user, should not create the 2nd user")]
        public async void Create_Duplicate_User()
        {
            var userService = new UserService(DatabaseService);

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var createRequest2 = (BadRequestObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest2.StatusCode);
        }

        // Delete all users from the db 
        public void Dispose()
        {
            var allUsers = DatabaseService.Users.ToList();

            foreach (var user in allUsers)
                DatabaseService.Users.Remove(user);
        }

    }
}
