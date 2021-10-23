using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class InvitationRepository : IInvitationRepository
    {
        private readonly RemetaskContext _context;
        public InvitationRepository(RemetaskContext context)
        {
            _context = context;
        }

        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task CreateInvitation(Invitation invitation)
        {
            if (invitation == null)
                throw new ArgumentNullException(nameof(invitation));
            await _context.Invitations.AddAsync(invitation);
        }

        public async Task<Invitation> GetInvitationById(int id)
        {
            return await _context.Invitations
                .Include(x =>x.Workspace)
                .Include(x => x.Invitee)
                .Include(x => x.Inviter)
                .FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task<IEnumerable<Invitation>> GetInvitationsByUserId(int id)
        {
            return await _context.Invitations.Include(x => x.Workspace).Include(x => x.Inviter)
                .Where(x => x.Invitee.Id == id).ToListAsync();
        }

        public async Task<IEnumerable<Invitation>> GetInvitationsByWorkspaceId(int id)
        {
            return await _context.Invitations.Include(x => x.Workspace).Include(x => x.Inviter).Include(x =>x.Invitee)
                .Where(x => x.Workspace.Id == id).ToListAsync();
        }

        public async Task DeleteInvitation(Invitation invitation)
        {
            if (invitation == null)
                throw new ArgumentNullException(nameof(invitation));
            _context.Invitations.Remove(invitation);
        }

        public async Task AcceptInvitation(Invitation invitation)
        {
            if (invitation == null)
                throw new ArgumentNullException(nameof(invitation));
            await _context.UserWorkspaces.AddAsync(new UserWorkspace{User = invitation.Invitee, Workspace = invitation.Workspace});
        }
    }
}
