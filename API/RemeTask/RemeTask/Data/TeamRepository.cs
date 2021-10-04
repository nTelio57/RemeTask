using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class TeamRepository : ITeamRepository
    {
        private readonly RemetaskContext _context;
        public TeamRepository(RemetaskContext context)
        {
            _context = context;
        }

        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task CreateTeam(Team team)
        {
            if (team == null)
                throw new ArgumentNullException(nameof(team));
            await _context.Teams.AddAsync(team);
        }

        public async Task<IEnumerable<Team>> GetAllTeams()
        {
            return await _context.Teams.ToListAsync();
        }

        public async Task<Team> GetTeamById(int id)
        {
            return await _context.Teams.FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task UpdateTeam(Team team)
        {
            
        }

        public async Task DeleteTeam(Team team)
        {
            if (team == null)
                throw new ArgumentNullException(nameof(team));
            _context.Teams.Remove(team);
        }
    }
}
