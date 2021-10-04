using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using RemeTask.Data;
using RemeTask.Dtos.Task;
using RemeTask.Dtos.TaskGroup;
using RemeTask.Models;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TaskGroupController : ControllerBase
    {
        private readonly ITaskGroupRepository _repository;
        private readonly IMapper _mapper;
        public TaskGroupController(ITaskGroupRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateTaskGroup(TaskGroupCreateDto taskGroupCreateDto)
        {
            var taskGroupModel = _mapper.Map<TaskGroup>(taskGroupCreateDto);

            await _repository.CreateTaskGroup(taskGroupModel);
            await _repository.SaveChanges();

            var taskGroupReadDto = _mapper.Map<TaskGroupReadDto>(taskGroupModel);
            return CreatedAtRoute(nameof(GetTaskGroupById), new { Id = taskGroupReadDto.Id }, taskGroupReadDto);
        }

        [HttpGet]
        public async Task<IActionResult> GetAllTaskGroups()
        {
            var taskGroup = await _repository.GetAllTaskGroups();
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroup));
        }

        [HttpGet("{id}", Name = "GetTaskGroupById")]
        public async Task<IActionResult> GetTaskGroupById(int id)
        {
            var taskGroup = await _repository.GetTaskGroupById(id);
            if (taskGroup == null)
                return NotFound();
            return Ok(_mapper.Map<TaskGroupReadDto>(taskGroup));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTaskGroup(int id)
        {
            var taskGroupModel = await _repository.GetTaskGroupById(id);
            if (taskGroupModel == null)
                return NotFound();

            await _repository.DeleteTaskGroup(taskGroupModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTaskGroup(int id, TaskUpdateDto taskGroupUpdateDto)
        {
            var taskGroupModel = await _repository.GetTaskGroupById(id);
            if (taskGroupModel == null)
                return NotFound();

            _mapper.Map(taskGroupUpdateDto, taskGroupModel);
            await _repository.UpdateTaskGroup(taskGroupModel);
            await _repository.SaveChanges();
            return NoContent();
        }

        [HttpGet("by-user-id/{id}", Name = "GetTaskGroupsByUserId")]
        public async Task<IActionResult> GetTaskGroupsByUserId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByUserId(id);
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }

        [HttpGet("by-team-id/{id}", Name = "GetTaskGroupsByTeamId")]
        public async Task<IActionResult> GetTaskGroupsByTeamId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByTeamId(id);
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }
    }
}
