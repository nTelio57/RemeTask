using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.Workspace
{
    public class WorkspaceCreateDto
    {
        public string Name { get; set; }
        public int? OwnerId { get; set; }
    }
}
