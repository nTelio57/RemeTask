using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.Invitation
{
    public class InvitationCreateDto
    {
        public DateTime InvitationDate { get; set; }
        [Required]
        public int? WorkspaceId { get; set; }
        [Required]
        public string InviteeId { get; set; }
        [Required]
        public string InviterId { get; set; }
    }
}
