﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = System.Threading.Tasks.Task;

namespace RemeTask.Data
{
    public interface ITaskGroupRepository
    {
        Task<bool> SaveChanges();
        Task CreateTaskGroup(TaskGroup task);
        Task<TaskGroup> GetTaskGroupById(int id);
        Task UpdateTaskGroup(TaskGroup task);
        Task DeleteTaskGroup(TaskGroup task);
    }
}
