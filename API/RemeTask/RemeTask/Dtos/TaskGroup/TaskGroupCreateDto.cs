using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.TaskGroup
{
    public class TaskGroupCreateDto
    {
        public string Name { get; set; }
        public string Tag { get; set; }
        [Required]
        public int? WorkspaceId { get; set; }
    }
}
