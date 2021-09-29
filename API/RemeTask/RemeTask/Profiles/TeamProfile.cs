using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using RemeTask.Dtos.Team;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class TeamProfile : Profile
    {
        public TeamProfile()
        {
            CreateMap<Team, TeamReadDto>();
            CreateMap<TeamCreateDto, Team>();
            CreateMap<TeamUpdateDto, Team>();
            CreateMap<Team, TeamUpdateDto>();
        }
    }
}
