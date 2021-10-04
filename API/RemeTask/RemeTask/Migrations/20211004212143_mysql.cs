using System;
using Microsoft.EntityFrameworkCore.Migrations;
using MySql.EntityFrameworkCore.Metadata;

namespace RemeTask.Migrations
{
    public partial class mysql : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    Email = table.Column<string>(type: "text", nullable: true),
                    Password = table.Column<string>(type: "text", nullable: true),
                    Salt = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Teams",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    OwnerId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Teams", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Teams_Users_OwnerId",
                        column: x => x.OwnerId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "TaskGroups",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    Tag = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    TeamId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaskGroups", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TaskGroups_Teams_TeamId",
                        column: x => x.TeamId,
                        principalTable: "Teams",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TaskGroups_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "UserTeams",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "int", nullable: false),
                    TeamId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserTeams", x => new { x.UserId, x.TeamId });
                    table.ForeignKey(
                        name: "FK_UserTeams_Teams_TeamId",
                        column: x => x.TeamId,
                        principalTable: "Teams",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserTeams_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Tasks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    Title = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    Deadline = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsCompleted = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    CompletionDate = table.Column<DateTime>(type: "datetime", nullable: true),
                    Priority = table.Column<int>(type: "int", nullable: false),
                    TaskGroupId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tasks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Tasks_TaskGroups_TaskGroupId",
                        column: x => x.TaskGroupId,
                        principalTable: "TaskGroups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Email", "Password", "Salt" },
                values: new object[] { 1, "vienas@test.com", "r08fhHamhLI9qMfjLWZqMduOPvKfIJhCmmxIy53RMUI=", "/CAuKyuKhVVR5B6oLjfQwAzC9eJIhju0xubUPMPiyWQ=" });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Email", "Password", "Salt" },
                values: new object[] { 2, "du@test.com", "G9Jr7PFw0PecDsLlJhCM2LyxzWtKD40a/GmzAOqn77Y=", "p7JlJExiWZo/cR1sHBm2j1DPsTE8MXO3NAEWya9/Alo=" });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Email", "Password", "Salt" },
                values: new object[] { 3, "vitrysenas@test.com", "s+PMYaajIcGUnVFcGWaRIRxV3nPUGL4i4aa2MWN2Gdc=", "qf9CdzHJz2V323ul6v/qbg87Enbqa84RyRcQhHpV4/A=" });

            migrationBuilder.InsertData(
                table: "TaskGroups",
                columns: new[] { "Id", "Name", "Tag", "TeamId", "UserId" },
                values: new object[,]
                {
                    { 1, "Matematika", "MAT", null, 1 },
                    { 2, "Informatika", "INFO", null, 1 },
                    { 3, "Anglu", "ENG", null, 2 }
                });

            migrationBuilder.InsertData(
                table: "Teams",
                columns: new[] { "Id", "Name", "OwnerId" },
                values: new object[] { 1, "Team1", 1 });

            migrationBuilder.InsertData(
                table: "TaskGroups",
                columns: new[] { "Id", "Name", "Tag", "TeamId", "UserId" },
                values: new object[,]
                {
                    { 4, "Fizika", "FIZ", 1, null },
                    { 5, "Objektinis programavimas", "OOP", 1, null }
                });

            migrationBuilder.InsertData(
                table: "Tasks",
                columns: new[] { "Id", "CompletionDate", "Deadline", "Description", "IsCompleted", "Priority", "TaskGroupId", "Title" },
                values: new object[,]
                {
                    { 2, new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2021, 10, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", true, 2, 1, "Laboras2" },
                    { 3, null, new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 3, 1, "Kontras" },
                    { 8, null, new DateTime(2021, 12, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 3, 1, "Anglu egzas" },
                    { 1, null, new DateTime(2021, 10, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 3, 2, "Laboras1" },
                    { 4, null, new DateTime(2021, 10, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 3, 2, "Pakartotinis lab1" },
                    { 6, null, new DateTime(2021, 12, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 5, 2, "Lab3" },
                    { 10, null, new DateTime(2021, 10, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 1, 2, "Pakartotinis egzas" }
                });

            migrationBuilder.InsertData(
                table: "UserTeams",
                columns: new[] { "TeamId", "UserId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 1, 2 }
                });

            migrationBuilder.InsertData(
                table: "Tasks",
                columns: new[] { "Id", "CompletionDate", "Deadline", "Description", "IsCompleted", "Priority", "TaskGroupId", "Title" },
                values: new object[] { 5, new DateTime(2021, 11, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2021, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", true, 1, 4, "Tarpinis egzas" });

            migrationBuilder.InsertData(
                table: "Tasks",
                columns: new[] { "Id", "CompletionDate", "Deadline", "Description", "IsCompleted", "Priority", "TaskGroupId", "Title" },
                values: new object[] { 7, null, new DateTime(2021, 11, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", false, 2, 4, "Testas1" });

            migrationBuilder.InsertData(
                table: "Tasks",
                columns: new[] { "Id", "CompletionDate", "Deadline", "Description", "IsCompleted", "Priority", "TaskGroupId", "Title" },
                values: new object[] { 9, new DateTime(2021, 11, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2021, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "Labai didelis aprasymas", true, 4, 4, "Lab6" });

            migrationBuilder.CreateIndex(
                name: "IX_TaskGroups_TeamId",
                table: "TaskGroups",
                column: "TeamId");

            migrationBuilder.CreateIndex(
                name: "IX_TaskGroups_UserId",
                table: "TaskGroups",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Tasks_TaskGroupId",
                table: "Tasks",
                column: "TaskGroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Teams_OwnerId",
                table: "Teams",
                column: "OwnerId");

            migrationBuilder.CreateIndex(
                name: "IX_UserTeams_TeamId",
                table: "UserTeams",
                column: "TeamId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Tasks");

            migrationBuilder.DropTable(
                name: "UserTeams");

            migrationBuilder.DropTable(
                name: "TaskGroups");

            migrationBuilder.DropTable(
                name: "Teams");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
