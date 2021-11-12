using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public class SeedData
    {
        private readonly RemetaskContext _context;
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public SeedData(RemetaskContext context, UserManager<User> userManager, RoleManager<IdentityRole> roleManager)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public void Seed()
        {
            _context.Database.EnsureCreated();

            RoleSeed.Seed(_roleManager);
            UserSeed.Seed(_userManager);
            WorkspaceSeed.Seed(_context);
            UserWorkspaceSeed.Seed(_context);
            TaskGroupSeed.Seed(_context);
            TaskSeed.Seed(_context);
            InvitationSeed.Seed(_context);

            _context.SaveChanges();
        }
    }
}
