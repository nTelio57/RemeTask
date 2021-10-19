﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class WorkspaceRepository : IWorkspaceRepository
    {
        private readonly RemetaskContext _context;
        public WorkspaceRepository(RemetaskContext context)
        {
            _context = context;
        }

        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task CreateWorkspace(Workspace workspace)
        {
            if (workspace == null)
                throw new ArgumentNullException(nameof(workspace));
            await _context.Workspaces.AddAsync(workspace);
        }

        public async Task<IEnumerable<Workspace>> GetAllWorkspaces()
        {
            return await _context.Workspaces.ToListAsync();
        }

        public async Task<Workspace> GetWorkspaceById(int id)
        {
            return await _context.Workspaces.Include(x=> x.TaskGroups).FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task<IEnumerable<TaskGroup>> GetTaskGroupsByWorkspaceId(int id)
        {
            return await _context.TaskGroups.Include(x => x.Tasks).Where(x => x.WorkspaceId == id).ToListAsync();
        }

        public async Task UpdateWorkspace(Workspace workspace)
        {
            
        }

        public async Task DeleteWorkspace(Workspace workspace)
        {
            if (workspace == null)
                throw new ArgumentNullException(nameof(workspace));
            _context.Workspaces.Remove(workspace);
        }
    }
}
