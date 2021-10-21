﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using RemeTask.Data;

namespace RemeTask.Migrations
{
    [DbContext(typeof(RemetaskContext))]
    partial class RemetaskContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 64)
                .HasAnnotation("ProductVersion", "5.0.10");

            modelBuilder.Entity("RemeTask.Models.Task", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime?>("CompletionDate")
                        .HasColumnType("datetime");

                    b.Property<DateTime>("Deadline")
                        .HasColumnType("datetime");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<bool>("IsCompleted")
                        .HasColumnType("tinyint(1)");

                    b.Property<int>("Priority")
                        .HasColumnType("int");

                    b.Property<int>("TaskGroupId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("TaskGroupId");

                    b.ToTable("Tasks");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Deadline = new DateTime(2021, 10, 14, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 3,
                            TaskGroupId = 2,
                            Title = "Laboras1"
                        },
                        new
                        {
                            Id = 2,
                            CompletionDate = new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Deadline = new DateTime(2021, 10, 17, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = true,
                            Priority = 2,
                            TaskGroupId = 1,
                            Title = "Laboras2"
                        },
                        new
                        {
                            Id = 3,
                            Deadline = new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 3,
                            TaskGroupId = 1,
                            Title = "Kontras"
                        },
                        new
                        {
                            Id = 4,
                            Deadline = new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 3,
                            TaskGroupId = 2,
                            Title = "Pakartotinis lab1"
                        },
                        new
                        {
                            Id = 5,
                            CompletionDate = new DateTime(2021, 11, 13, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Deadline = new DateTime(2021, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = true,
                            Priority = 1,
                            TaskGroupId = 4,
                            Title = "Tarpinis egzas"
                        },
                        new
                        {
                            Id = 6,
                            Deadline = new DateTime(2021, 12, 18, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 5,
                            TaskGroupId = 2,
                            Title = "Lab3"
                        },
                        new
                        {
                            Id = 7,
                            Deadline = new DateTime(2021, 11, 14, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 2,
                            TaskGroupId = 4,
                            Title = "Testas1"
                        },
                        new
                        {
                            Id = 8,
                            Deadline = new DateTime(2021, 12, 23, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 3,
                            TaskGroupId = 1,
                            Title = "Anglu egzas"
                        },
                        new
                        {
                            Id = 9,
                            CompletionDate = new DateTime(2021, 11, 13, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Deadline = new DateTime(2021, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = true,
                            Priority = 4,
                            TaskGroupId = 4,
                            Title = "Lab6"
                        },
                        new
                        {
                            Id = 10,
                            Deadline = new DateTime(2021, 10, 17, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Description = "Labai didelis aprasymas",
                            IsCompleted = false,
                            Priority = 1,
                            TaskGroupId = 2,
                            Title = "Pakartotinis egzas"
                        });
                });

            modelBuilder.Entity("RemeTask.Models.TaskGroup", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("Tag")
                        .HasColumnType("text");

                    b.Property<int?>("WorkspaceId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("WorkspaceId");

                    b.ToTable("TaskGroups");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "Matematika",
                            Tag = "MAT",
                            WorkspaceId = 1
                        },
                        new
                        {
                            Id = 2,
                            Name = "Informatika",
                            Tag = "INFO",
                            WorkspaceId = 1
                        },
                        new
                        {
                            Id = 3,
                            Name = "Anglu",
                            Tag = "ENG",
                            WorkspaceId = 2
                        },
                        new
                        {
                            Id = 4,
                            Name = "Fizika",
                            Tag = "FIZ",
                            WorkspaceId = 1
                        },
                        new
                        {
                            Id = 5,
                            Name = "Objektinis programavimas",
                            Tag = "OOP",
                            WorkspaceId = 1
                        });
                });

            modelBuilder.Entity("RemeTask.Models.TaskNote", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Content")
                        .HasColumnType("text");

                    b.Property<int>("CreatedById")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime");

                    b.Property<int>("TaskId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("CreatedById");

                    b.HasIndex("TaskId");

                    b.ToTable("TaskNote");
                });

            modelBuilder.Entity("RemeTask.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("text");

                    b.Property<string>("Password")
                        .HasColumnType("text");

                    b.Property<string>("Salt")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Users");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Email = "test@gmail.com",
                            Password = "q4FNUQnZUklVgBx2JenlHcYFhq6drVS0Bh8E0ye8yiY=",
                            Salt = "Ux7QC8+we1StSPeXbhGGrJFfdQSj7OzyjEPv3R9xuQ8="
                        },
                        new
                        {
                            Id = 2,
                            Email = "du@test.com",
                            Password = "G9Jr7PFw0PecDsLlJhCM2LyxzWtKD40a/GmzAOqn77Y=",
                            Salt = "p7JlJExiWZo/cR1sHBm2j1DPsTE8MXO3NAEWya9/Alo="
                        },
                        new
                        {
                            Id = 3,
                            Email = "vitrysenas@test.com",
                            Password = "s+PMYaajIcGUnVFcGWaRIRxV3nPUGL4i4aa2MWN2Gdc=",
                            Salt = "qf9CdzHJz2V323ul6v/qbg87Enbqa84RyRcQhHpV4/A="
                        });
                });

            modelBuilder.Entity("RemeTask.Models.UserWorkspace", b =>
                {
                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<int>("WorkspaceId")
                        .HasColumnType("int");

                    b.HasKey("UserId", "WorkspaceId");

                    b.HasIndex("WorkspaceId");

                    b.ToTable("UserWorkspaces");

                    b.HasData(
                        new
                        {
                            UserId = 1,
                            WorkspaceId = 1
                        },
                        new
                        {
                            UserId = 1,
                            WorkspaceId = 2
                        },
                        new
                        {
                            UserId = 2,
                            WorkspaceId = 2
                        });
                });

            modelBuilder.Entity("RemeTask.Models.Workspace", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<int>("Owner")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Workspaces");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "Workspace1",
                            Owner = 1
                        },
                        new
                        {
                            Id = 2,
                            Name = "Workspace2",
                            Owner = 1
                        },
                        new
                        {
                            Id = 3,
                            Name = "Workspace3",
                            Owner = 2
                        });
                });

            modelBuilder.Entity("RemeTask.Models.Task", b =>
                {
                    b.HasOne("RemeTask.Models.TaskGroup", "TaskGroup")
                        .WithMany("Tasks")
                        .HasForeignKey("TaskGroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("TaskGroup");
                });

            modelBuilder.Entity("RemeTask.Models.TaskGroup", b =>
                {
                    b.HasOne("RemeTask.Models.Workspace", "Workspace")
                        .WithMany("TaskGroups")
                        .HasForeignKey("WorkspaceId");

                    b.Navigation("Workspace");
                });

            modelBuilder.Entity("RemeTask.Models.TaskNote", b =>
                {
                    b.HasOne("RemeTask.Models.User", "CreatedBy")
                        .WithMany()
                        .HasForeignKey("CreatedById")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("RemeTask.Models.Task", "Task")
                        .WithMany("TaskNotes")
                        .HasForeignKey("TaskId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("CreatedBy");

                    b.Navigation("Task");
                });

            modelBuilder.Entity("RemeTask.Models.UserWorkspace", b =>
                {
                    b.HasOne("RemeTask.Models.User", "User")
                        .WithMany("Workspaces")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("RemeTask.Models.Workspace", "Workspace")
                        .WithMany("Users")
                        .HasForeignKey("WorkspaceId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");

                    b.Navigation("Workspace");
                });

            modelBuilder.Entity("RemeTask.Models.Task", b =>
                {
                    b.Navigation("TaskNotes");
                });

            modelBuilder.Entity("RemeTask.Models.TaskGroup", b =>
                {
                    b.Navigation("Tasks");
                });

            modelBuilder.Entity("RemeTask.Models.User", b =>
                {
                    b.Navigation("Workspaces");
                });

            modelBuilder.Entity("RemeTask.Models.Workspace", b =>
                {
                    b.Navigation("TaskGroups");

                    b.Navigation("Users");
                });
#pragma warning restore 612, 618
        }
    }
}
