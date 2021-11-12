using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class InvitationSeed
    {
        public static void Seed(RemetaskContext context)
        {
            var invitation1 = new Invitation
            {
                Id = 1,
                InvitationDate = new DateTime(2021, 10, 19),
                InviteeId = UserSeed.IdBasic,
                InviterId = UserSeed.IdPro,
                WorkspaceId = 3
            };
            var invitation2 = new Invitation
            {
                Id = 2,
                InvitationDate = new DateTime(2021, 10, 18),
                InviteeId = UserSeed.IdBasic2,
                InviterId = UserSeed.IdPro,
                WorkspaceId = 3
            };

            foreach (var invitation in new[]{invitation1, invitation2})
            {
                var result = context.Invitations.FirstOrDefault(x => x.Id == invitation.Id);
                if (result == null)
                    context.Invitations.AddAsync(invitation);
            }
        }
    }
}
