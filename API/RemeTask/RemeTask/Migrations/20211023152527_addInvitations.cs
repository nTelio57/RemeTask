using System;
using Microsoft.EntityFrameworkCore.Migrations;
using MySql.EntityFrameworkCore.Metadata;

namespace RemeTask.Migrations
{
    public partial class addInvitations : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Invitations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    InvitationDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    WorkspaceId = table.Column<int>(type: "int", nullable: true),
                    InviteeId = table.Column<int>(type: "int", nullable: true),
                    InviterId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Invitations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Invitations_Users_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Invitations_Users_InviterId",
                        column: x => x.InviterId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Invitations_Workspaces_WorkspaceId",
                        column: x => x.WorkspaceId,
                        principalTable: "Workspaces",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "Invitations",
                columns: new[] { "Id", "InvitationDate", "InviteeId", "InviterId", "WorkspaceId" },
                values: new object[] { 1, new DateTime(2021, 10, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 3 });

            migrationBuilder.InsertData(
                table: "Invitations",
                columns: new[] { "Id", "InvitationDate", "InviteeId", "InviterId", "WorkspaceId" },
                values: new object[] { 2, new DateTime(2021, 10, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 75 });

            migrationBuilder.InsertData(
                table: "Invitations",
                columns: new[] { "Id", "InvitationDate", "InviteeId", "InviterId", "WorkspaceId" },
                values: new object[] { 3, new DateTime(2021, 10, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 15, 1, 1 });

            migrationBuilder.CreateIndex(
                name: "IX_Invitations_InviteeId",
                table: "Invitations",
                column: "InviteeId");

            migrationBuilder.CreateIndex(
                name: "IX_Invitations_InviterId",
                table: "Invitations",
                column: "InviterId");

            migrationBuilder.CreateIndex(
                name: "IX_Invitations_WorkspaceId",
                table: "Invitations",
                column: "WorkspaceId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Invitations");
        }
    }
}
