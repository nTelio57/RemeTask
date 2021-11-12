using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RemeTask.Data;
using RemeTask.Dtos.Task;
using RemeTask.Dtos.TaskGroup;
using RemeTask.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TaskGroupController : ControllerBase
    {
        private readonly TaskGroupRepository _repository;
        private readonly IMapper _mapper;
        public TaskGroupController(IRepository<TaskGroup> repository, IMapper mapper)
        {
            _repository = repository as TaskGroupRepository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateTaskGroup(TaskGroupCreateDto taskGroupCreateDto)
        {
            var taskGroupModel = _mapper.Map<TaskGroup>(taskGroupCreateDto);

            await _repository.Create(taskGroupModel);
            await _repository.SaveChanges();

            var taskGroupReadDto = _mapper.Map<TaskGroupReadDto>(taskGroupModel);
            return CreatedAtRoute(nameof(GetTaskGroupById), new { Id = taskGroupReadDto.Id }, taskGroupReadDto);
        }

        [HttpGet]
        [Authorize(Roles = UserRoles.Admin)]
        public async Task<IActionResult> GetAllTaskGroups()
        {
            var taskGroup = await _repository.GetAll();
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroup));
        }

        [HttpGet("{id}", Name = "GetTaskGroupById")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetTaskGroupById(int id)
        {
            var taskGroup = await _repository.GetById(id);
            if (taskGroup == null)
                return NotFound();
            return Ok(_mapper.Map<TaskGroupReadDto>(taskGroup));
        }

        [HttpGet("{id}/tasks", Name = "GetTasksByTaskGroupId")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetTasksByTaskGroupId(int id)
        {
            var taskGroup = await _repository.GetById(id);
            if (taskGroup == null)
                return NotFound();
            return Ok(_mapper.Map<IEnumerable<TaskReadDto>>(taskGroup.Tasks));
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> DeleteTaskGroup(int id)
        {
            var taskGroupModel = await _repository.GetById(id);
            if (taskGroupModel == null)
                return NotFound();

            await _repository.Delete(taskGroupModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> UpdateTaskGroup(int id, TaskGroupUpdateDto taskGroupUpdateDto)
        {
            var taskGroupModel = await _repository.GetById(id);
            if (taskGroupModel == null)
                return NotFound();

            _mapper.Map(taskGroupUpdateDto, taskGroupModel);
            await _repository.Update(taskGroupModel);
            await _repository.SaveChanges();
            return NoContent();
        }

        /*[HttpGet("by-user-id/{id}", Name = "GetTaskGroupsByUserId")]
        public async Task<IActionResult> GetTaskGroupsByUserId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByUserId(id);
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }*/

        [HttpGet("{groupId}/task/{taskId}", Name = "GetTaskByGroup")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetTaskByGroup(int groupId, int taskId)
        {
            var task = await _repository.GetTaskByGroup(groupId, taskId);
            if (task == null)
                return NotFound();

            return Ok(_mapper.Map<TaskReadDto>(task));
        }

        /*[HttpGet("by-workspace-id/{id}", Name = "GetTaskGroupsByWorkspaceId")]
        public async Task<IActionResult> GetTaskGroupsByWorkspaceId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByWorkspaceId(id);
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }*/
    }
}
