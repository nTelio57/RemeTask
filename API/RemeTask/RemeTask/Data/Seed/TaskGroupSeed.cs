using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;

namespace RemeTask.Data.Seed
{
    public static class TaskGroupSeed
    {
        public static void Seed(RemetaskContext context)
        {
            var taskGroup1 = new TaskGroup
            {
                Id = 1,
                Name = "Task group 1",
                Tag = "TG1",
                WorkspaceId = 1
            };
            var taskGroup2 = new TaskGroup
            {
                Id = 2,
                Name = "Task group 2",
                Tag = "TG2",
                WorkspaceId = 2
            };
            var taskGroup3 = new TaskGroup
            {
                Id = 3,
                Name = "Task group 3",
                Tag = "TG3",
                WorkspaceId = 3
            };
            var taskGroup4 = new TaskGroup
            {
                Id = 4,
                Name = "Task group 4",
                Tag = "TG4",
                WorkspaceId = 1
            };

            foreach (var taskGroup in new[] { taskGroup1, taskGroup2, taskGroup3, taskGroup4})
            {
                var result = context.TaskGroups.FirstOrDefault(x => x.Id == taskGroup.Id);
                if (result == null)
                    context.TaskGroups.AddAsync(taskGroup);
            }
        }
    }
}
