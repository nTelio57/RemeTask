using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using RemeTask.Dtos.Workspace;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class WorkspaceProfile : Profile
    {
        public WorkspaceProfile()
        {
            CreateMap<Workspace, WorkspaceReadDto>();
            CreateMap<WorkspaceCreateDto, Workspace>();
            CreateMap<WorkspaceUpdateDto, Workspace>();
            CreateMap<Workspace, WorkspaceUpdateDto>();
        }
    }
}
