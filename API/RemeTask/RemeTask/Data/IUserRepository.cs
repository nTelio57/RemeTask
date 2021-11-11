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
        Task<User> GetUserByEmail(string email);
        Task<string> GenerateToken(string email);
        Task AddNewUser(User user);
        Task<User> GetUserByLogin(string email, string password);
        Task<User> GetUserById(string id);
        Task<IEnumerable<User>> GetUsersByEmail(string email);
        Task UpdateUser(User user);
    }
}
