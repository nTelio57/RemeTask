using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Dtos.Workspace;

namespace RemeTask.Dtos.User
{
    public class UserReadDto
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public IEnumerable<WorkspaceReadDto> Workspaces { get; set; }
        
    }
}
