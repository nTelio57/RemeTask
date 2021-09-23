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
        public DbSet<Team> Teams { get; set; }
        public DbSet<UserTeam> UserTeams { get; set; }
        public RemetaskContext(DbContextOptions<RemetaskContext> opt) : base(opt)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserTeam>().HasKey(ut => new {ut.UserId, ut.TeamId});
            SeedDatabase(modelBuilder);
        }

        void SeedDatabase(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);
            SeedTeams(modelBuilder);
            SeedUserTeams(modelBuilder);
            SeedTaskGroups(modelBuilder);
            SeedTasks(modelBuilder);
        }

        void SeedUsers(ModelBuilder modelBuilder)
        {
            var user1 = new User { Id = 1, Email = "vienas@test.com", Password = "r08fhHamhLI9qMfjLWZqMduOPvKfIJhCmmxIy53RMUI=", Salt = "/CAuKyuKhVVR5B6oLjfQwAzC9eJIhju0xubUPMPiyWQ="};
            var user2 = new User { Id = 2, Email = "du@test.com", Password = "G9Jr7PFw0PecDsLlJhCM2LyxzWtKD40a/GmzAOqn77Y=", Salt = "p7JlJExiWZo/cR1sHBm2j1DPsTE8MXO3NAEWya9/Alo=" };
            var user3 = new User { Id = 3, Email = "vitrysenas@test.com", Password = "s+PMYaajIcGUnVFcGWaRIRxV3nPUGL4i4aa2MWN2Gdc=", Salt = "qf9CdzHJz2V323ul6v/qbg87Enbqa84RyRcQhHpV4/A=" };

            modelBuilder.Entity<User>().HasData(user1, user2, user3);
        }

        void SeedTeams(ModelBuilder modelBuilder)
        {
            var team1 = new Team {Id = 1, Name = "Team1", OwnerId = 1};

            modelBuilder.Entity<Team>().HasData(team1);
        }

        void SeedUserTeams(ModelBuilder modelBuilder)
        {
            var userTeam1 = new UserTeam {TeamId = 1, UserId = 1};
            var userTeam2 = new UserTeam { TeamId = 1, UserId = 2 };

            modelBuilder.Entity<UserTeam>().HasData(userTeam1, userTeam2);
        }

        void SeedTaskGroups(ModelBuilder modelBuilder)
        {
            var taskGroup1 = new TaskGroup {Id = 1, Name = "Matematika", Tag = "MAT", UserId = 1};
            var taskGroup2 = new TaskGroup { Id = 2, Name = "Informatika", Tag = "INFO", UserId = 1 };
            var taskGroup3 = new TaskGroup { Id = 3, Name = "Anglu", Tag = "ENG", UserId = 2 };
            var taskGroup4 = new TaskGroup { Id = 4, Name = "Fizika", Tag = "FIZ", TeamId = 1 };
            var taskGroup5 = new TaskGroup { Id = 5, Name = "Objektinis programavimas", Tag = "OOP", TeamId = 1 };

            modelBuilder.Entity<TaskGroup>().HasData(taskGroup1, taskGroup2, taskGroup3, taskGroup4, taskGroup5);
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
