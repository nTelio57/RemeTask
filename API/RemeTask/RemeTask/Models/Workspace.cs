using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class Workspace
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public User Owner { get; set; }
        public int? OwnerId { get; set; }
        public ICollection<UserWorkspace> Users { get; set; }
        public ICollection<TaskGroup> TaskGroups { get; set; }
    }
}
