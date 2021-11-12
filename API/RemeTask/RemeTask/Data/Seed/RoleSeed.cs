using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class RoleSeed
    {
        public static void Seed(RoleManager<IdentityRole> roleManager)
        {
            foreach (var role in UserRoles.All)
            {
                var roleExist = roleManager.RoleExistsAsync(role).Result;
                if (!roleExist)
                {
                    roleManager.CreateAsync(new IdentityRole(role)).Wait();
                }
            }
        }
    }
}
