using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Dtos.User
{
    public class UserUpdateDto
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string Salt { get; set; }
    }
}
