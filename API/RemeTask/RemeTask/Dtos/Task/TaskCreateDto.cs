using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.Task
{
    public class TaskCreateDto
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime Deadline { get; set; }
        public bool IsCompleted { get; set; }
        public DateTime? CompletionDate { get; set; }
        public int Priority { get; set; }

        public int TaskGroupId { get; set; }
    }
}
