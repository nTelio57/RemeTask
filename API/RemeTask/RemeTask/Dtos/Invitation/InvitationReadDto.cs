using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Dtos.User;
using RemeTask.Dtos.Workspace;

namespace RemeTask.Dtos.Invitation
{
    public class InvitationReadDto
    {
        public int Id { get; set; }
        public DateTime InvitationDate { get; set; }
        
        public WorkspaceReadDto Workspace { get; set; }
        public UserReadDto Invitee { get; set; }
        public UserReadDto Inviter { get; set; }
    }
}
