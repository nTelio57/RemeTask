using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.User
{
    public class UserCreateDto
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }

        public bool HasEmptyInfo()
        {
            return 
                Email == null || 
                Password == null;
        }
    }
}
