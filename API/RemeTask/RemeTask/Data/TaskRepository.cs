using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Data
{
    public class TaskRepository : Repository<RTTask>
    {
        protected override DbSet<RTTask> Entities { get; }
        public TaskRepository(RemetaskContext context) : base(context)
        {
            Entities = context.Tasks;
        }
        
        public async Task<bool> CanUserEdit(string userId, RTTask task)
        {
            TaskGroup taskGroup = await Context.TaskGroups.Where(x => x.Id == task.TaskGroupId).FirstOrDefaultAsync();
            Workspace workspace = await Context.Workspaces.Where(x => x.Id == taskGroup.WorkspaceId).FirstOrDefaultAsync();

            return Context.UserWorkspaces.Count(x => x.WorkspaceId == workspace.Id && x.UserId == userId) > 0;
        }
    }
}
