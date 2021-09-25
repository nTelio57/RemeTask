using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface IAuthRepository
    {
        Task<bool> SaveChanges();
        Task<User> GetUserByEmail(string email);
        Task<string> GenerateToken(string email);
        Task AddNewUser(User user);
        Task<User> GetUserByLogin(string email, string password);
    }
}
