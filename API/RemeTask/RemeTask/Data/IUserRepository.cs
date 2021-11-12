using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface IUserRepository
    {
        Task<bool> SaveChanges();
        Task<string> GenerateToken(string email);
        Task UpdateUser(User user);
        Task<IEnumerable<User>> GetUsersByEmail(string email);
    }
}
