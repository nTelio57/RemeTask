using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RemeTask.Models;
using Task = RemeTask.Models.Task;

namespace RemeTask.Data.Seed
{
    public static class TaskSeed
    {
        public static void Seed(RemetaskContext context)
        {
            var task1 = new Task
            {
                Id = 1,
                Title = "Laboras1",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 10, 14),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 3,
                TaskGroupId = 2
            };

            var task2 = new Task
            {
                Id = 2,
                Title = "Laboras2",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 10, 17),
                IsCompleted = true,
                CompletionDate = new DateTime(2021, 10, 13),
                Priority = 2,
                TaskGroupId = 1
            };

            var task3 = new Task
            {
                Id = 3,
                Title = "Kontras",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 10, 13),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 3,
                TaskGroupId = 1
            };

            var task4 = new Task
            {
                Id = 4,
                Title = "Pakartotinis lab1",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 10, 13),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 3,
                TaskGroupId = 2
            };

            var task5 = new Task
            {
                Id = 5,
                Title = "Tarpinis egzas",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 11, 12),
                IsCompleted = true,
                CompletionDate = new DateTime(2021, 11, 13),
                Priority = 1,
                TaskGroupId = 4
            };

            var task6 = new Task
            {
                Id = 6,
                Title = "Lab3",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 12, 18),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 5,
                TaskGroupId = 2
            };

            var task7 = new Task
            {
                Id = 7,
                Title = "Testas1",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 11, 14),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 2,
                TaskGroupId = 4
            };

            var task8 = new Task
            {
                Id = 8,
                Title = "Anglu egzas",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 12, 23),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 3,
                TaskGroupId = 1
            };

            var task9 = new Task
            {
                Id = 9,
                Title = "Lab6",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 11, 25),
                IsCompleted = true,
                CompletionDate = new DateTime(2021, 11, 13),
                Priority = 4,
                TaskGroupId = 4
            };

            var task10 = new Task
            {
                Id = 10,
                Title = "Pakartotinis egzas",
                Description = "Labai didelis aprasymas",
                Deadline = new DateTime(2021, 10, 17),
                IsCompleted = false,
                CompletionDate = null,
                Priority = 1,
                TaskGroupId = 2
            };

            foreach (var task in new[] {task1, task2, task3, task4, task5, task6, task7, task8, task9, task10})
            {
                var result = context.Tasks.FirstOrDefault(x => x.Id == task.Id);
                if(result == null)
                    context.Tasks.AddAsync(task);
            }
                
        }
    }
}
