using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.Invitation
{
    public class InvitationCreateDto
    {
        public DateTime InvitationDate { get; set; }

        public int? WorkspaceId { get; set; }
        public int? InviteeId { get; set; }
        public int? InviterId { get; set; }
    }
}
