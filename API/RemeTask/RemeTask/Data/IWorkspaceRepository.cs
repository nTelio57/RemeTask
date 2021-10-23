using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface IWorkspaceRepository
    {
        Task<bool> SaveChanges();
        Task CreateWorkspace(Workspace workspace);
        Task<IEnumerable<Workspace>> GetAllWorkspaces();
        Task<IEnumerable<TaskGroup>> GetTaskGroupsByWorkspaceId(int id);
        Task<Workspace> GetWorkspaceById(int id);
        Task<IEnumerable<Workspace>> GetWorkspacesByUserId(int id);
        Task<IEnumerable<User>> GetUsersByWorkspaceId(int id);
        Task UpdateWorkspace(Workspace workspace);
        Task DeleteWorkspace(Workspace workspace);
    }
}
