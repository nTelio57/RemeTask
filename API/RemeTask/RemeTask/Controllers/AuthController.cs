using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.VisualBasic.CompilerServices;
using RemeTask.Auth;
using RemeTask.Data;
using RemeTask.Dtos.User;
using RemeTask.Models;
using RemeTask.Utilities;

namespace RemeTask.Auth
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IAuthRepository _repository;
        private readonly IMapper _mapper;
        public AuthController(IAuthRepository jwtAuthenticationRepo, IMapper mapper)
        {
            _repository = jwtAuthenticationRepo;
            _mapper = mapper;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(AuthRequest authRequest)
        {
            var existingUser = await _repository.GetUserByEmail(authRequest.Email);

            if (existingUser != null)
            {
                return BadRequest(new AuthResult
                {
                    Errors = new[] {"User with this email address already exists"}
                });
            }

            var salt = Crypto.GenerateSalt();

            var newUser = new User
            {
                Email = authRequest.Email,
                Password = Crypto.Hash(authRequest.Password+salt),
                Salt = salt
            };

            await _repository.AddNewUser(newUser);
            await _repository.SaveChanges();

            var token = await _repository.GenerateToken(authRequest.Email);
            return Ok(new AuthResult
            {
                Success = true,
                Token = token,
                User = _mapper.Map<UserReadDto>(newUser)
            });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(AuthRequest authRequest)
        {
            var existingUser = await _repository.GetUserByLogin(authRequest.Email, authRequest.Password);

            if (existingUser == null)
            {
                return BadRequest(new AuthResult
                {
                    Errors = new[] { "Wrong credentials" }
                });
            }

            var token = await _repository.GenerateToken(authRequest.Email);
            return Ok(new AuthResult
            {
                Success = true,
                Token = token,
                User = _mapper.Map<UserReadDto>(existingUser)
            });
        }

    }
}
