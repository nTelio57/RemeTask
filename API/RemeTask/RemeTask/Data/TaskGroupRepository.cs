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
    public class TaskGroupRepository : ITaskGroupRepository
    {
        private readonly RemetaskContext _context;
        public TaskGroupRepository(RemetaskContext context)
        {
            _context = context;
        }
        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task CreateTaskGroup(TaskGroup taskGroup)
        {
            if (taskGroup == null)
                throw new ArgumentNullException(nameof(taskGroup));
            await _context.TaskGroups.AddAsync(taskGroup);
        }

        public async Task<IEnumerable<TaskGroup>> GetAllTaskGroups()
        {
            return await _context.TaskGroups.Include(x => x.Tasks).ToListAsync();
        }

        public async Task<TaskGroup> GetTaskGroupById(int id)
        {
            return await _context.TaskGroups.Include(x => x.Tasks).FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task UpdateTaskGroup(TaskGroup taskGroup)
        {
            
        }

        public async Task DeleteTaskGroup(TaskGroup taskGroup)
        {
            if (taskGroup == null)
                throw new ArgumentNullException(nameof(taskGroup));
            _context.TaskGroups.Remove(taskGroup);
        }

        /*public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByUserId(int id)
        {
            return await _context.TaskGroups.Include(x => x.Tasks).Where(x => x.UserId == id).ToListAsync();
        }*/

        public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByWorkspaceId(int id)
        {
            return await _context.TaskGroups.Include(x => x.Tasks).Where(x => x.WorkspaceId == id).ToListAsync();
        }

        public async Task<RTTask> GetTaskByGroup(int groupId, int taskId)
        {
            var group = await GetTaskGroupById(groupId);
            return group.Tasks.FirstOrDefault(x => x.Id == taskId);
        }
    }
}
