using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using RemeTask.Data;
using RemeTask.Dtos.Task;
using RemeTask.Models;
using System.Collections.Generic;
using System.Threading.Tasks;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly TaskRepository _repository;
        private readonly IMapper _mapper;
        private readonly UserManager<User> _userManager;

        public TaskController(IRepository<RTTask> repository, IMapper mapper, UserManager<User> userManager)
        {
            _repository = repository as TaskRepository;
            _mapper = mapper;
            _userManager = userManager;
        }

        [HttpPost]
        [Roles(UserRoles.Basic, UserRoles.Pro, UserRoles.Admin)]
        public async Task<IActionResult> CreateTask(TaskCreateDto taskCreateDto)
        {
            var taskModel =  _mapper.Map<RTTask>(taskCreateDto);

            await _repository.Create(taskModel);
            await _repository.SaveChanges();

            var taskReadDto = _mapper.Map<TaskReadDto>(taskModel);
            return CreatedAtRoute(nameof(GetTaskById), new {Id = taskReadDto.Id}, taskReadDto);
        }

        [HttpGet]
        [Authorize(Roles = UserRoles.Admin)]
        public async Task<IActionResult> GetAllTasks()
        {
            var task = await _repository.GetAll();
            return Ok(_mapper.Map<IEnumerable<TaskReadDto>>(task));
        }

        [HttpGet("{id}", Name = "GetTaskById")]
        [Roles(UserRoles.Basic, UserRoles.Pro, UserRoles.Admin)]
        public async Task<IActionResult> GetTaskById(int id)
        {
            var task = await _repository.GetById(id);
            var userId = User.FindFirst(CustomClaims.UserId)?.Value;

            if (task == null)
                return NotFound();
            
            var canEdit = await _repository.CanUserEdit(userId, task);
            if(!canEdit)
                return Forbid();

            return Ok(_mapper.Map<TaskReadDto>(task));
        }

        [HttpDelete("{id}")]
        [Roles(UserRoles.Basic, UserRoles.Pro, UserRoles.Admin)]
        public async Task<IActionResult> DeleteTask(int id)
        {
            var taskModel = await _repository.GetById(id);
            if (taskModel == null)
                return NotFound();

            await _repository.Delete(taskModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        [Roles(UserRoles.Basic, UserRoles.Pro, UserRoles.Admin)]
        public async Task<IActionResult> UpdateTask(int id, TaskUpdateDto taskUpdateDto)
        {
            var taskModel = await _repository.GetById(id);
            if (taskModel == null)
                return NotFound();

            _mapper.Map(taskUpdateDto, taskModel);
            await _repository.Update(taskModel);
            await _repository.SaveChanges();
            return NoContent();
        }
    }
}
