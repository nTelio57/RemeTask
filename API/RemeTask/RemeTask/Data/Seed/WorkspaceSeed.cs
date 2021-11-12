using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class WorkspaceSeed
    {
        public static void Seed(RemetaskContext context)
        {
            var workspace1 = new Workspace
            {
                Id = 1,
                Name = "Workspace 1",
                Owner = UserSeed.IdBasic
            };
            var workspace2 = new Workspace
            {
                Id = 2,
                Name = "Workspace 2",
                Owner = UserSeed.IdBasic2
            };
            var workspace3 = new Workspace
            {
                Id = 3,
                Name = "Workspace 3",
                Owner = UserSeed.IdPro
            };

            foreach (var workspace in new[]{workspace1, workspace2, workspace3})
            {
                var result = context.Workspaces.FirstOrDefault(x => x.Id == workspace.Id);
                if (result == null)
                    context.Workspaces.AddAsync(workspace);
            }
        }
    }
}
