using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class Invitation : Entity
    {
        public DateTime InvitationDate { get; set; }

        public int WorkspaceId { get; set; }
        public Workspace Workspace { get; set; }
        [ForeignKey("Invitee")]
        public string InviteeId { get; set; }
        public User Invitee { get; set; }
        [ForeignKey("Inviter")]
        public string InviterId { get; set; }
        public User Inviter { get; set; }
    }
}
