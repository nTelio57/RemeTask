using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using RemeTask.Dtos.TaskGroup;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class TaskGroupProfile : Profile
    {
        public TaskGroupProfile()
        {
            CreateMap<TaskGroup, TaskGroupReadDto>();
            CreateMap<TaskGroupCreateDto, TaskGroup>();
            CreateMap<TaskGroupUpdateDto, TaskGroup>();
            CreateMap<TaskGroup, TaskGroupUpdateDto>();
        }
    }
}
