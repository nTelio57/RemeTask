using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Data
{
    public interface ITaskRepository
    {
        Task<bool> SaveChanges();
        Task CreateTask(RTTask task);
        Task<RTTask> GetTaskById(int id);
        Task UpdateTask(RTTask task);
        Task DeleteTask(RTTask task);
    }
}
