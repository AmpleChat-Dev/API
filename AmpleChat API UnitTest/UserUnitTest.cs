using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using AmpleChat_API.Controllers;
using AmpleChat_API.Services;
using AmpleChat_API.Database;
using AmpleChatLibrary.User;
using Xunit;

namespace AmpleChat_API_UnitTest
{
    public class UserUnitTest
    {
        private static RegisterModel CreateValidRegisterModel()
        {
            return new RegisterModel {
                Email = "test@amplechat.com",
                Password = "P@ssW0rd!654654564",
                UserName = "sickusername"
            };
        }

        private static LoginModel CreateValidLoginModelUserName(RegisterModel model)
        {
            return new LoginModel
            {
                UserNameOrEmail = model.UserName,
                Password = model.Password
            };
        }

        private static LoginModel CreateValidLoginModelEmail(RegisterModel model)
        {
            return new LoginModel
            {
                UserNameOrEmail = model.Email,
                Password = model.Password
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
            var userService = new AccountService(CreateDbService("test1"));

            var userController = new AccountController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (ObjectResult) await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode);
        }

        [Fact(DisplayName = "Creat a user but with invalid data, user should not be created")]
        public async void Create_InValid_User()
        {
            var userService = new AccountService(CreateDbService("test2"));

            var userController = new AccountController(userService);

            var model = CreateInValidRegisterModel();

            var createRequest = (ObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest.StatusCode.Value);
        }

        [Fact(DisplayName = "Create a user and try to create that exact same user, should not create the 2nd user")]
        public async void Create_Duplicate_User()
        {
            var userService = new AccountService(CreateDbService("test3"));

            var userController = new AccountController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (ObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var createRequest2 = (ObjectResult) await userController.CreateUser(model);

            Assert.Equal(400, createRequest2.StatusCode);
        }

        [Fact(DisplayName = "Login after creating an account")]
        public async void Login() 
        {
            var userService = new AccountService(CreateDbService("test4"));

            var userController = new AccountController(userService);

            var model = CreateValidRegisterModel();

            var createRequest = (ObjectResult)await userController.CreateUser(model);

            Assert.Equal(200, createRequest.StatusCode.Value);

            var loginRequestUserName = (ObjectResult) userController.SignIn(CreateValidLoginModelUserName(model));

            var loginRequestEmail = (ObjectResult) userController.SignIn(CreateValidLoginModelEmail(model));

            Assert.Equal(200, loginRequestUserName.StatusCode);
            Assert.Equal(200, loginRequestEmail.StatusCode);
        }
    }
}
