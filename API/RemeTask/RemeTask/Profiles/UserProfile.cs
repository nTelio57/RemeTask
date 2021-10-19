using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using RemeTask.Dtos.User;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<User, UserReadDto>()
                .ForMember(dst => dst.Workspaces, src => src.MapFrom(mbr => mbr.Workspaces.Select(x => x.Workspace)));
            CreateMap<UserCreateDto, User>();
            CreateMap<UserUpdateDto, User>();
            CreateMap<User, UserUpdateDto>();
        }
    }
}
