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
using RemeTask.Dtos.Workspace;
using RemeTask.Models;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class WorkspaceController : ControllerBase
    {
        private readonly IWorkspaceRepository _repository;
        private readonly IMapper _mapper;
        public WorkspaceController(IWorkspaceRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateWorkspace(WorkspaceCreateDto workspaceCreateDto)
        {
            var workspaceModel = _mapper.Map<Workspace>(workspaceCreateDto);

            await _repository.CreateWorkspace(workspaceModel);
            await _repository.SaveChanges();

            var workspaceReadDto = _mapper.Map<WorkspaceReadDto>(workspaceModel);
            return CreatedAtRoute(nameof(GetWorkspaceById), new { Id = workspaceReadDto.Id }, workspaceReadDto);
        }

        [HttpGet]
        public async Task<IActionResult> GetAllWorkspaces()
        {
            var workspace = await _repository.GetAllWorkspaces();
            return Ok(_mapper.Map<IEnumerable<WorkspaceReadDto>>(workspace));
        }

        [HttpGet("{id}/task-groups", Name = "GetTaskGroupsByWorkspaceId")]
        public async Task<IActionResult> GetTaskGroupsByWorkspaceId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByWorkspaceId(id);
            if (taskGroups == null)
                return NotFound();
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }

        [HttpGet("{id}", Name = "GetWorkspaceById")]
        public async Task<IActionResult> GetWorkspaceById(int id)
        {
            var workspace = await _repository.GetWorkspaceById(id);
            if (workspace == null)
                return NotFound();
            return Ok(_mapper.Map<WorkspaceReadDto>(workspace));
        }

        [HttpGet("by-users-id/{id}", Name = "GetWorkspacesByUserId")]
        public async Task<IActionResult> GetWorkspacesByUserId(int id)
        {
            var workspaces = await _repository.GetWorkspacesByUserId(id);
            return Ok(_mapper.Map<IEnumerable<WorkspaceReadDto>>(workspaces));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWorkspace(int id)
        {
            var workspaceModel = await _repository.GetWorkspaceById(id);
            if (workspaceModel == null)
                return NotFound();

            await _repository.DeleteWorkspace(workspaceModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateWorkspace(int id, WorkspaceUpdateDto workspaceUpdateDto)
        {
            var workspaceModel = await _repository.GetWorkspaceById(id);
            if (workspaceModel == null)
                return NotFound();

            _mapper.Map(workspaceUpdateDto, workspaceModel);
            await _repository.UpdateWorkspace(workspaceModel);
            await _repository.SaveChanges();
            return NoContent();
        }
    }
}
