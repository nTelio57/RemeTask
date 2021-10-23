using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class Invitation
    {
        [Key]
        public int Id { get; set; }
        public DateTime InvitationDate { get; set; }

        public int? WorkspaceId { get; set; }
        public Workspace Workspace { get; set; }
        public int? InviteeId { get; set; }
        public User Invitee { get; set; }
        public int? InviterId { get; set; }
        public User Inviter { get; set; }
    }
}
