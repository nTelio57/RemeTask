using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using RemeTask.Data;
using RemeTask.Dtos.Invitation;
using RemeTask.Dtos.Workspace;
using RemeTask.Models;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class InvitationController : ControllerBase
    {
        private readonly IInvitationRepository _repository;
        private readonly IMapper _mapper;
        public InvitationController(IInvitationRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpGet("{id}", Name = "GetInvitationById")]
        public async Task<IActionResult> GetInvitationById(int id)
        {
            var invitation = await _repository.GetInvitationById(id);
            if (invitation == null)
                return NotFound();
            return Ok(_mapper.Map<InvitationReadDto>(invitation));
        }

        [HttpPost]
        public async Task<IActionResult> CreateInvitation(InvitationCreateDto invitationCreateDto)
        {
            var invitationModel = _mapper.Map<Invitation>(invitationCreateDto);

            await _repository.CreateInvitation(invitationModel);
            await _repository.SaveChanges();

            var invitationReadDto = _mapper.Map<InvitationReadDto>(invitationModel);
            return CreatedAtRoute(nameof(GetInvitationById), new { Id = invitationReadDto.Id }, invitationReadDto);
        }

        [HttpGet("by-users-id/{id}", Name = "GetInvitationsByUserId")]
        public async Task<IActionResult> GetInvitationsByUserId(int id)
        {
            var invitations = await _repository.GetInvitationsByUserId(id);
            return Ok(_mapper.Map<IEnumerable<InvitationReadDto>>(invitations));
        }

        [HttpGet("by-workspace-id/{id}", Name = "GetInvitationsByWorkspaceId")]
        public async Task<IActionResult> GetInvitationsByWorkspaceId(int id)
        {
            var invitations = await _repository.GetInvitationsByWorkspaceId(id);
            return Ok(_mapper.Map<IEnumerable<InvitationReadDto>>(invitations));
        }

        [HttpPost("respond")]
        public async Task<IActionResult> RespondInvitation(InvitationResponseDto invitationResponseDto)
        {
            var invitation = await _repository.GetInvitationById(invitationResponseDto.InvitationId);
            if (invitation == null)
                return NotFound();

            if (invitationResponseDto.Response)
            {
                await _repository.AcceptInvitation(invitation);
            }
            await _repository.DeleteInvitation(invitation);
            await _repository.SaveChanges();
            
            return Ok();
        }
    }
}
