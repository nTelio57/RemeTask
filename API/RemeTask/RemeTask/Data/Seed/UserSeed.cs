﻿using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Identity;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class UserSeed
    {
        public static string IdBasic = "6e58169a-cc76-45b9-8d20-ef40fda183a3";
        public static string IdBasic2 = "9a8865c2-9297-4675-a038-efbf192e75f3";
        public static string IdPro = "fdbba978-9941-41b6-b0d4-f76134357fd6";
        public static string IdAdmin = "570457bc-51a6-47d7-90a1-cc3cd1598563";

        public static void Seed(UserManager<User> userManager)
        {
            var admin = new User
            {
                Id = IdAdmin,
                Email = "admin@gmail.com",
                UserName = "Admin",
                Salt = "zoOCL2CFBCqEtTK5Ua197SwyVv2rckZoJEe+Ko8bUCU="
            };

            var pro = new User
            {
                Id = IdPro,
                Email = "pro@gmail.com",
                UserName = "Pro",
                Salt = "Dan/E7BW4F+mhY8qnbk5EbPYeSiwV5tn9JBAUnSLShM="
            };

            var basic = new User
            {
                Id = IdBasic,
                Email = "basic@gmail.com",
                UserName = "Basic",
                Salt = "kFcWCtYosDUdeiK0Gf+WcY0LcxdvcH3UtQQrvwf9fh8="
            };

            var basic2 = new User
            {
                Id = IdBasic2,
                Email = "basic2@gmail.com",
                UserName = "Basic2",
                Salt = "VoW7Vl2PL4g9erbq1ncE6cpQbVmHMR3dDhLGx9EYhbM="
            };

            CreateUser(userManager, admin, "test123", UserRoles.All);
            CreateUser(userManager, pro, "test123", UserRoles.AllNonAdmin);
            CreateUser(userManager, basic, "test123", new []{UserRoles.Basic});
            CreateUser(userManager, basic2, "test123", new[] { UserRoles.Basic });
        }

        private static void CreateUser(UserManager<User> userManager, User user, string password, IEnumerable<string> roles)
        {
            var isExisting = userManager.FindByEmailAsync(user.Email).Result;
            if (isExisting == null)
            {
                var result = userManager.CreateAsync(user, password+user.Salt).Result;
                if (result.Succeeded)
                {
                    userManager.AddToRolesAsync(user, roles).Wait();
                }
            }
        }
    }
}
