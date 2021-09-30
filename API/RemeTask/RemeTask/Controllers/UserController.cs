using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.VisualBasic.CompilerServices;
using RemeTask.Auth;
using RemeTask.Data;
using RemeTask.Dtos.User;
using RemeTask.Models;
using RemeTask.Utilities;

namespace RemeTask.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _repository;
        private readonly IMapper _mapper;
        public UserController(IUserRepository jwtAuthenticationRepo, IMapper mapper)
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

        [Authorize]
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUser(int id, UserUpdateDto userUpdateDto)
        {
            var userModel = await _repository.GetUserById(id);
            if (userModel == null)
                return NotFound();

            _mapper.Map(userUpdateDto, userModel);
            await _repository.UpdateUser(userModel);
            await _repository.SaveChanges();
            return NoContent();
        }

    }
}
