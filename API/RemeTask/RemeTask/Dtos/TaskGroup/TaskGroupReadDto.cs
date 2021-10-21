using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Dtos.Task;

namespace RemeTask.Dtos.TaskGroup
{
    public class TaskGroupReadDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Tag { get; set; }
        public string UserId { get; set; }
        public string WorkspaceId { get; set; }
        public IEnumerable<TaskReadDto> Tasks { get; set; }
    }
}
