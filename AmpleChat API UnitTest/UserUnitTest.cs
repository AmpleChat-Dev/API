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
    public class UserUnitTest
    {
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
        }

        public static DatabaseService CreateDbService(string db)
        {
            return new DatabaseService(new DbContextOptionsBuilder<DatabaseService>().UseInMemoryDatabase(databaseName: db).Options);
        }

        [Fact(DisplayName = "Create a user with valid data, user should be created")]
        public async void Create_Valid_User()
        {
            var userService = new UserService(CreateDbService("test1"));

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult) await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode);
        }

        [Fact(DisplayName = "Creat a user but with invalid data, user should not be created")]
        public async void Create_InValid_User()
        {
            var userService = new UserService(CreateDbService("test2"));

            var userController = new UserController(userService);

            var model = CreateInValidRegisterModel();

            var createRequest = (BadRequestObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest.StatusCode.Value);
        }

        [Fact(DisplayName = "Create a user and try to create that exact same user, should not create the 2nd user")]
        public async void Create_Duplicate_User()
        {
            var userService = new UserService(CreateDbService("test3"));

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var createRequest2 = (BadRequestObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest2.StatusCode);
        }

        [Fact(DisplayName = "Login a existing user with his email credentials")]
        public async void Login_Valid_User_Email()
        {
            var userService = new UserService(CreateDbService("test3"));

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var loginRequest = (OkObjectResult) userController.LoginUser(new LoginModel {
                UserNameOrEmail = model.Email,
                Password = model.Password
            });

            Assert.Equal(200, loginRequest.StatusCode.Value);
        }

        [Fact(DisplayName = "Login a existing user with his username credentials")]
        public async void Login_Valid_User_Username()
        {
            var userService = new UserService(CreateDbService("test3"));

            var userController = new UserController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (OkObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var loginRequest = (OkObjectResult)userController.LoginUser(new LoginModel
            {
                UserNameOrEmail = model.UserName,
                Password = model.Password
            });

            Assert.Equal(200, loginRequest.StatusCode.Value);
        }
    }
}
