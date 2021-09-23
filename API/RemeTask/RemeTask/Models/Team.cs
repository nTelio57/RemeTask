using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Models
{
    public class Team
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public User Owner { get; set; }
        public int? OwnerId { get; set; }
        public ICollection<UserTeam> Users { get; set; }
    }
}
