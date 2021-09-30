using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using RemeTask.Models;
using RemeTask.Utilities;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public class UserRepository : IUserRepository
    {
        private readonly RemetaskContext _context;

        private readonly string _key;

        public UserRepository(RemetaskContext context, string key)
        {
            _context = context;
            _key = key;
        }

        public async Task<bool> SaveChanges()
        {
            return await _context.SaveChangesAsync() >= 0;
        }

        public async Task<string> GenerateToken(string email)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenKey = Encoding.ASCII.GetBytes(_key);
            var tokenDescriptor = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Email, email)
                }),
                Expires = DateTime.UtcNow.AddMonths(1),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(tokenKey), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public async Task<User> GetUserByEmail(string email)
        {
            return await _context.Users.FirstOrDefaultAsync(x => x.Email == email);
        }

        public async Task AddNewUser(User user)
        {
            await _context.Users.AddAsync(user);
        }

        public async Task<User> GetUserByLogin(string email, string password)
        {
            User user = await _context.Users.FirstOrDefaultAsync(x => x.Email == email);
            if (user == null || !user.Password.Equals(Crypto.Hash(password + user.Salt)))
                return null;
            return user;
        }

        public async Task<User> GetUserById(int id)
        {
            return await _context.Users.FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task UpdateUser(User user)
        {
            
        }
    }
}
