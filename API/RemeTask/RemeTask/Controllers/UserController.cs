using System.Collections.Generic;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using RemeTask.Auth;
using RemeTask.Data;
using RemeTask.Dtos.User;
using RemeTask.Models;
using RemeTask.Utilities;
using System.Linq;
using System.Threading.Tasks;

namespace RemeTask.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserManager<User> _userManager;
        private readonly IUserRepository _repository;
        private readonly IMapper _mapper;
        private readonly ITokenManager _tokenManager;
        private readonly IPasswordValidator<User> _passwordValidator;

        public UserController(UserManager<User> userManager, IUserRepository userRepository, IMapper mapper, ITokenManager tokenManager, IPasswordValidator<User> passwordValidator)
        {
            _userManager = userManager;
            _repository = userRepository;
            _mapper = mapper;
            _tokenManager = tokenManager;
            _passwordValidator = passwordValidator;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register(UserCreateDto authRequest)
        {
            var user = await _userManager.FindByEmailAsync(authRequest.Email);
            if (user != null)
            {
                return BadRequest(new AuthResult
                {
                    Errors = new[] {"User with this email address already exists."}
                });
            }
            var result = await _passwordValidator.ValidateAsync(_userManager, null, authRequest.Password);
            if (!result.Succeeded)
                return BadRequest(new AuthResult
                {
                    Errors = result.Errors.Select(x => x.Description)
                });

            var salt = Crypto.GenerateSalt();
            var newUser = new User
            {
                UserName = authRequest.Email,
                Email = authRequest.Email,
                Salt = salt
            };

            var createdUser = await _userManager.CreateAsync(newUser, authRequest.Password + salt);
            if(!createdUser.Succeeded)
                return BadRequest(new AuthResult
                {
                    Errors = new[] { "Could not create a user." }
                });

            await _userManager.AddToRoleAsync(newUser, UserRoles.Basic);
            var accessToken = await _tokenManager.CreateAccessTokenAsync(newUser);

            return CreatedAtAction(nameof(Register), new AuthResult
            {
                Success = true,
                Token = accessToken,
                User = _mapper.Map<UserReadDto>(newUser)
            });
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login(AuthRequest authRequest)
        {
            var user = await _userManager.FindByEmailAsync(authRequest.Email);
            if (user == null)
            {
                return BadRequest(new AuthResult
                {
                    Errors = new[] { "Wrong credentials." }
                });
            }

            var isPasswordValid = await _userManager.CheckPasswordAsync(user, authRequest.Password + user.Salt);
            if (!isPasswordValid)
            {
                return BadRequest(new AuthResult
                {
                    Errors = new[] { "Wrong credentials." }
                });
            }

            var accessToken = await _tokenManager.CreateAccessTokenAsync(user);
            return Ok(new AuthResult
            {
                Success = true,
                Token = accessToken,
                User = _mapper.Map<UserReadDto>(user)
            });
        }

        [Authorize]
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUser(string id, UserUpdateDto userUpdateDto)
        {
            var userModel = await _userManager.FindByIdAsync(id);
            if (userModel == null)
                return NotFound();

            _mapper.Map(userUpdateDto, userModel);
            await _repository.UpdateUser(userModel);
            await _repository.SaveChanges();
            return NoContent();
        }

        [Authorize]
        [Roles(UserRoles.Basic, UserRoles.Pro, UserRoles.Admin)]
        [HttpGet("by-email/{email}", Name = "GetUsersByEmail")]
        public async Task<IActionResult> GetUsersByEmail(string email)
        {
            var invitations = await _repository.GetUsersByEmail(email);
            return Ok(_mapper.Map<IEnumerable<UserReadDto>>(invitations));
        }

    }
}
