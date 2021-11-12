using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Dtos.TaskGroup;

namespace RemeTask.Dtos.Workspace
{
    public class WorkspaceReadDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Owner { get; set; }
        public IEnumerable<TaskGroupReadDto> TaskGroups { get; set; }
    }
}
