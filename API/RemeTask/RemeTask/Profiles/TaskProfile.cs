using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using RemeTask.Dtos.Task;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class TaskProfile : Profile
    {
        public TaskProfile()
        {
            CreateMap<Task, TaskReadDto>();
            CreateMap<TaskCreateDto, Task>();
            CreateMap<TaskUpdateDto, Task>();
            CreateMap<Task, TaskUpdateDto>();
        }
    }
}
