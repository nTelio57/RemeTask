using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Data
{
    public interface ITaskGroupRepository
    {
        Task<bool> SaveChanges();
        Task CreateTaskGroup(TaskGroup taskGroup);
        Task<IEnumerable<TaskGroup>> GetAllTaskGroups();
        Task<TaskGroup> GetTaskGroupById(int id);
        Task UpdateTaskGroup(TaskGroup taskGroup);
        Task DeleteTaskGroup(TaskGroup taskGroup);
        Task<IEnumerable<TaskGroup>> GetTaskGroupsByUserId(int id);
        Task<IEnumerable<TaskGroup>> GetTaskGroupsByTeamId(int id);
        Task<RTTask> GetTaskByGroup(int groupId, int taskId);
    }
}
