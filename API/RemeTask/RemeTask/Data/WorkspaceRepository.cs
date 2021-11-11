using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class WorkspaceRepository : Repository<Workspace>
    {
        protected override DbSet<Workspace> Entities { get; }
        public WorkspaceRepository(RemetaskContext context) : base(context)
        {
            Entities = context.Workspaces;
        }

        public override async Task Create(Workspace workspace)
        {
            if (workspace == null)
                throw new ArgumentNullException(nameof(workspace));
            await Context.Workspaces.AddAsync(workspace);
            await Context.UserWorkspaces.AddAsync(new UserWorkspace{UserId = workspace.Owner, Workspace = workspace});
        }

        public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByWorkspaceId(int id)
        {
            return await Context.TaskGroups.Include(x => x.Tasks).Where(x => x.WorkspaceId == id).ToListAsync();
        }

        public async Task<IEnumerable<Workspace>> GetWorkspacesByUserId(string id)
        {
            return await Context.UserWorkspaces
                .Include(x => x.Workspace)
                .Include(x => x.Workspace.TaskGroups)
                    .ThenInclude(x => x.Tasks).Where(x => x.UserId == id)
                .Select(x => x.Workspace)
                .ToListAsync();
        }

        public async Task<IEnumerable<User>> GetUsersByWorkspaceId(int id)
        {
            return await Context.UserWorkspaces.Include(x => x.User).Where(x => x.WorkspaceId == id).Select(x => x.User).ToListAsync();
        }
    }
}
