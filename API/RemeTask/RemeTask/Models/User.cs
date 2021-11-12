using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace RemeTask.Models
{
    public class User : IdentityUser
    {
        public string Salt { get; set; }
        
        public ICollection<UserWorkspace> Workspaces { get; set; }
    }
}
