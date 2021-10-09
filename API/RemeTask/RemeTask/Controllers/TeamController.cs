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
using RemeTask.Dtos.Team;
using RemeTask.Models;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TeamController : ControllerBase
    {
        private readonly ITeamRepository _repository;
        private readonly IMapper _mapper;
        public TeamController(ITeamRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateTeam(TeamCreateDto teamCreateDto)
        {
            var teamModel = _mapper.Map<Team>(teamCreateDto);

            await _repository.CreateTeam(teamModel);
            await _repository.SaveChanges();

            var teamReadDto = _mapper.Map<TeamReadDto>(teamModel);
            return CreatedAtRoute(nameof(GetTeamById), new { Id = teamReadDto.Id }, teamReadDto);
        }

        [HttpGet]
        public async Task<IActionResult> GetAllTeams()
        {
            var team = await _repository.GetAllTeams();
            return Ok(_mapper.Map<IEnumerable<TeamReadDto>>(team));
        }

        [HttpGet("{id}/task-groups", Name = "GetTaskGroupsByTeamId")]
        public async Task<IActionResult> GetTaskGroupsByTeamId(int id)
        {
            var taskGroups = await _repository.GetTaskGroupsByTeamId(id);
            if (taskGroups == null)
                return NotFound();
            return Ok(_mapper.Map<IEnumerable<TaskGroupReadDto>>(taskGroups));
        }

        [HttpGet("{id}", Name = "GetTeamById")]
        public async Task<IActionResult> GetTeamById(int id)
        {
            var team = await _repository.GetTeamById(id);
            if (team == null)
                return NotFound();
            return Ok(_mapper.Map<TeamReadDto>(team));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTeam(int id)
        {
            var teamModel = await _repository.GetTeamById(id);
            if (teamModel == null)
                return NotFound();

            await _repository.DeleteTeam(teamModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTeam(int id, TeamUpdateDto teamUpdateDto)
        {
            var teamModel = await _repository.GetTeamById(id);
            if (teamModel == null)
                return NotFound();

            _mapper.Map(teamUpdateDto, teamModel);
            await _repository.UpdateTeam(teamModel);
            await _repository.SaveChanges();
            return NoContent();
        }
    }
}
