using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;

namespace RemeTask.Data
{
    public class RemetaskContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Task> Tasks { get; set; }
        public DbSet<TaskGroup> TaskGroups { get; set; }
        public DbSet<Workspace> Workspaces { get; set; }
        public DbSet<UserWorkspace> UserWorkspaces { get; set; }
        public RemetaskContext(DbContextOptions<RemetaskContext> opt) : base(opt)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserWorkspace>().HasKey(ut => new {ut.UserId, ut.WorkspaceId});
            SeedDatabase(modelBuilder);
        }

        void SeedDatabase(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);
            SeedWorkspaces(modelBuilder);
            SeedUserWorksapces(modelBuilder);
            SeedTaskGroups(modelBuilder);
            SeedTasks(modelBuilder);
            SeedNotes(modelBuilder);
        }

        void SeedUsers(ModelBuilder modelBuilder)
        {
            var user1 = new User { Id = 1, Email = "test@gmail.com", Password = "q4FNUQnZUklVgBx2JenlHcYFhq6drVS0Bh8E0ye8yiY=", Salt = "Ux7QC8+we1StSPeXbhGGrJFfdQSj7OzyjEPv3R9xuQ8=" };
            var user2 = new User { Id = 2, Email = "du@test.com", Password = "G9Jr7PFw0PecDsLlJhCM2LyxzWtKD40a/GmzAOqn77Y=", Salt = "p7JlJExiWZo/cR1sHBm2j1DPsTE8MXO3NAEWya9/Alo=" };
            var user3 = new User { Id = 3, Email = "vitrysenas@test.com", Password = "s+PMYaajIcGUnVFcGWaRIRxV3nPUGL4i4aa2MWN2Gdc=", Salt = "qf9CdzHJz2V323ul6v/qbg87Enbqa84RyRcQhHpV4/A=" };

            modelBuilder.Entity<User>().HasData(user1, user2, user3);
        }

        void SeedWorkspaces(ModelBuilder modelBuilder)
        {
            var workspace1 = new Workspace {Id = 1, Name = "Workspace1", Owner = 1};
            var workspace2 = new Workspace { Id = 2, Name = "Workspace2", Owner = 1 };
            var workspace3 = new Workspace { Id = 3, Name = "Workspace3", Owner = 2 };

            modelBuilder.Entity<Workspace>().HasData(workspace1, workspace2, workspace3);
        }

        void SeedUserWorksapces(ModelBuilder modelBuilder)
        {
            var userWorkspace1 = new UserWorkspace {WorkspaceId = 1, UserId = 1};
            var userWorkspace2 = new UserWorkspace { WorkspaceId = 2, UserId = 1 };
            var userWorkspace3 = new UserWorkspace { WorkspaceId = 2, UserId = 2 };

            modelBuilder.Entity<UserWorkspace>().HasData(userWorkspace1, userWorkspace2, userWorkspace3);
        }

        void SeedTaskGroups(ModelBuilder modelBuilder)
        {
            var taskGroup1 = new TaskGroup {Id = 1, Name = "Matematika", Tag = "MAT", WorkspaceId = 1};
            var taskGroup2 = new TaskGroup { Id = 2, Name = "Informatika", Tag = "INFO", WorkspaceId = 1 };
            var taskGroup3 = new TaskGroup { Id = 3, Name = "Anglu", Tag = "ENG", WorkspaceId = 2 };
            var taskGroup4 = new TaskGroup { Id = 4, Name = "Fizika", Tag = "FIZ", WorkspaceId = 1 };
            var taskGroup5 = new TaskGroup { Id = 5, Name = "Objektinis programavimas", Tag = "OOP", WorkspaceId = 1 };

            modelBuilder.Entity<TaskGroup>().HasData(taskGroup1, taskGroup2, taskGroup3, taskGroup4, taskGroup5);
        }

        void SeedNotes(ModelBuilder modelBuilder)
        {
            var note1 = new TaskNote
            {
                Id = 1,
                Content = "Labai ilgas uzrasas",
                CreatedById = 1,
                CreatedOn = new DateTime(2021, 10, 14),
                TaskId = 1
            };

            var note2 = new TaskNote
            {
                Id = 2,
                Content = "Labai ilgas uzrasas",
                CreatedById = 1,
                CreatedOn = new DateTime(2021, 10, 15),
                TaskId = 1
            };

            var note3 = new TaskNote
            {
                Id = 3,
                Content = "Labai ilgas uzrasas",
                CreatedById = 1,
                CreatedOn = new DateTime(2021, 10, 16),
                TaskId = 2
            };

            var note4 = new TaskNote
            {
                Id = 4,
                Content = "Labai ilgas uzrasas",
                CreatedById = 2,
                CreatedOn = new DateTime(2021, 10, 17),
                TaskId = 3
            };
        }

        void SeedTasks(ModelBuilder modelBuilder)
        {
            var task1 = new Task
            {
                Id = 1, Title = "Laboras1", 
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

            modelBuilder.Entity<Task>().HasData(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10);
        }
    }
}
