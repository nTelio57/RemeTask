using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class TaskGroup
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Tag { get; set; }

        public int? UserId { get; set; }
        public User User { get; set; }
        public int? WorkspaceId { get; set; }
        public Workspace Workspace { get; set; }
        public ICollection<Task> Tasks { get; set; }
    }
}
