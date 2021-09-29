using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.TaskGroup
{
    public class TaskGroupUpdateDto
    {
        public string Name { get; set; }
        public string Tag { get; set; }
        public int? UserId { get; set; }
        public int? TeamId { get; set; }
    }
}
