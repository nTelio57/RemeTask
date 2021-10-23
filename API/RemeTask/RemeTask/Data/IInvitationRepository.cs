using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface IInvitationRepository
    {
        Task<bool> SaveChanges();
        Task CreateInvitation(Invitation invitation);
        Task<Invitation> GetInvitationById(int id);
        Task<IEnumerable<Invitation>> GetInvitationsByUserId(int id);
        Task<IEnumerable<Invitation>> GetInvitationsByWorkspaceId(int id);
        Task DeleteInvitation(Invitation invitation);
        Task AcceptInvitation(Invitation invitation);

    }
}
