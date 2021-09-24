using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Data
{
    public class TaskRepository : ITaskRepository
    {
        private readonly RemetaskContext _context;
        public TaskRepository(RemetaskContext context)
        {
            _context = context;
        }

        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task CreateTask(RTTask task)
        {
            if (task == null)
                throw new ArgumentNullException(nameof(task));
            await _context.Tasks.AddAsync(task);
        }

        public async Task<RTTask> GetTaskById(int id)
        {
            return await _context.Tasks.FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task UpdateTask(RTTask task)
        {
        }

        public async Task DeleteTask(RTTask task)
        {
            if (task == null)
                throw new ArgumentNullException(nameof(task));
            _context.Tasks.Remove(task);
        }
    }
}
