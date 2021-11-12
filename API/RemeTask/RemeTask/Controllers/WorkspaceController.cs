using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RemeTask.Data;
using RemeTask.Dtos.TaskGroup;
using RemeTask.Dtos.User;
using RemeTask.Dtos.Workspace;
using RemeTask.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class WorkspaceController : ControllerBase
    {
        private readonly WorkspaceRepository _repository;
        private readonly IMapper _mapper;
        public WorkspaceController(IRepository<Workspace> repository, IMapper mapper)
        {
            _repository = repository as WorkspaceRepository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateWorkspace(WorkspaceCreateDto workspaceCreateDto)
        {
            var workspaceModel = _mapper.Map<Workspace>(workspaceCreateDto);

            await _repository.Create(workspaceModel);
            await _repository.SaveChanges();

            var workspaceReadDto = _mapper.Map<WorkspaceReadDto>(workspaceModel);
            return CreatedAtRoute(nameof(GetWorkspaceById), new { Id = workspaceReadDto.Id }, workspaceReadDto);
        }

        [HttpGet]
        [Authorize(Roles = UserRoles.Admin)]
        public async Task<IActionResult> GetAllWorkspaces()
        {
            var workspace = await _repository.GetAll();
            return Ok(_mapper.Map<IEnumerable<WorkspaceReadDto>>(workspace));
        }

        [HttpGet("{id}/task-groups", Name = "GetTaskGroupsByWorkspaceId")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetTaskGroupsByWorkspaceId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByWorkspaceId(id);
            if (taskGroups == null)
                return NotFound();
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }

        [HttpGet("{id}", Name = "GetWorkspaceById")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetWorkspaceById(int id)
        {
            var workspace = await _repository.GetById(id);
            if (workspace == null)
                return NotFound();
            return Ok(_mapper.Map<WorkspaceReadDto>(workspace));
        }

        [HttpGet("by-users-id/{id}", Name = "GetWorkspacesByUserId")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetWorkspacesByUserId(string id)
        {
            var workspaces = await _repository.GetWorkspacesByUserId(id);
            return Ok(_mapper.Map<IEnumerable<WorkspaceReadDto>>(workspaces));
        }

        [HttpGet("users/{id}", Name = "GetUsersByWorkspaceId")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> GetUsersByWorkspaceId(int id)
        {
            var users = await _repository.GetUsersByWorkspaceId(id);
            return Ok(_mapper.Map<IEnumerable<UserReadDto>>(users));
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> DeleteWorkspace(int id)
        {
            var workspaceModel = await _repository.GetById(id);
            if (workspaceModel == null)
                return NotFound();

            await _repository.Delete(workspaceModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Basic,Pro,Admin")]
        public async Task<IActionResult> UpdateWorkspace(int id, WorkspaceUpdateDto workspaceUpdateDto)
        {
            var workspaceModel = await _repository.GetById(id);
            if (workspaceModel == null)
                return NotFound();

            _mapper.Map(workspaceUpdateDto, workspaceModel);
            await _repository.Update(workspaceModel);
            await _repository.SaveChanges();
            return NoContent();
        }
    }
}
