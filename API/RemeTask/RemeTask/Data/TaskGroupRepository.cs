using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Data
{
    public class TaskGroupRepository : Repository<TaskGroup>
    {
        protected override DbSet<TaskGroup> Entities { get; }
        public TaskGroupRepository(RemetaskContext context) : base(context)
        {
            Entities = context.TaskGroups;
        }

        protected override IQueryable<TaskGroup> IncludeDependencies(IQueryable<TaskGroup> queryable)
        {
            return queryable.Include(x => x.Tasks);
        }

        /*public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByUserId(int id)
        {
            return await _context.TaskGroups.Include(x => x.Tasks).Where(x => x.UserId == id).ToListAsync();
        }*/

        public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByWorkspaceId(int id)
        {
            return await Context.TaskGroups.Include(x => x.Tasks).Where(x => x.WorkspaceId == id).ToListAsync();
        }

        public async Task<RTTask> GetTaskByGroup(int groupId, int taskId)
        {
            var group = await GetById(groupId);
            if (group is null)
                return null;
            return group.Tasks.FirstOrDefault(x => x.Id == taskId);
        }
    }
}
