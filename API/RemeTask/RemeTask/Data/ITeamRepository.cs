using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface ITeamRepository
    {
        Task<bool> SaveChanges();
        Task CreateTeam(Team team);
        Task<IEnumerable<Team>> GetAllTeams();
        Task<IEnumerable<TaskGroup>> GetTaskGroupsByTeamId(int id);
        Task<Team> GetTeamById(int id);
        Task UpdateTeam(Team team);
        Task DeleteTeam(Team team);
    }
}
