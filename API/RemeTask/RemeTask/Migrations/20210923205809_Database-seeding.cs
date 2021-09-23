using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RemeTask.Migrations
{
    public partial class Databaseseeding : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "CompletionDate",
                table: "Tasks",
                type: "datetime2",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "TaskGroups",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "TaskGroups",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Tasks",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "UserTeams",
                keyColumns: new[] { "TeamId", "UserId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "UserTeams",
                keyColumns: new[] { "TeamId", "UserId" },
                keyValues: new object[] { 1, 2 });

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "TaskGroups",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "TaskGroups",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "TaskGroups",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Teams",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.AlterColumn<DateTime>(
                name: "CompletionDate",
                table: "Tasks",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldNullable: true);
        }
    }
}
