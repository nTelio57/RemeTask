using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class UserWorkspaceSeed
    {
        public static void Seed(RemetaskContext context)
        {
            var userWorkspace1 = new UserWorkspace
            {
                WorkspaceId = 1,
                UserId = UserSeed.IdBasic
            };
            var userWorkspace2 = new UserWorkspace
            {
                WorkspaceId = 2,
                UserId = UserSeed.IdBasic2
            };
            var userWorkspace3 = new UserWorkspace
            {
                WorkspaceId = 3,
                UserId = UserSeed.IdPro
            };

            foreach (var userWorkspace in new[] { userWorkspace1, userWorkspace2, userWorkspace3 })
            {
                var result = context.UserWorkspaces.FirstOrDefault(x => x.WorkspaceId == userWorkspace.WorkspaceId && x.UserId == userWorkspace.UserId);
                if (result == null)
                    context.UserWorkspaces.AddAsync(userWorkspace);
            }
        }
    }
}
