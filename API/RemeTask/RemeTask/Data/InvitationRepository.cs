using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class InvitationRepository : Repository<Invitation>
    {
        protected override DbSet<Invitation> Entities { get; }
        public InvitationRepository(RemetaskContext context) : base(context)
        {
            Entities = context.Invitations;
        }

        public async Task<Invitation> GetInvitationById(int id)
        {
            return await Context.Invitations
                .Include(x =>x.Workspace)
                .Include(x => x.Invitee)
                .Include(x => x.Inviter)
                .FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task<IEnumerable<Invitation>> GetInvitationsByUserId(string id)
        {
            return await Context.Invitations.Include(x => x.Workspace).Include(x => x.Inviter)
                .Where(x => x.Invitee.Id == id).ToListAsync();
        }

        public async Task<IEnumerable<Invitation>> GetInvitationsByWorkspaceId(int id)
        {
            return await Context.Invitations.Include(x => x.Workspace).Include(x => x.Inviter).Include(x =>x.Invitee)
                .Where(x => x.Workspace.Id == id).ToListAsync();
        }

        public async Task AcceptInvitation(Invitation invitation)
        {
            if (invitation == null)
                throw new ArgumentNullException(nameof(invitation));
            await Context.UserWorkspaces.AddAsync(new UserWorkspace{User = invitation.Invitee, Workspace = invitation.Workspace});
        }
    }
}
