using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class TaskNote : Entity
    { 
        public string Content { get; set; }
        public DateTime CreatedOn { get; set; }
        public User CreatedBy { get; set; }
        public string CreatedById { get; set; }
        public Task Task { get; set; }
        public int TaskId { get; set; }
    }
}
