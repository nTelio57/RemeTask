using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using RemeTask.Models;

namespace RemeTask.Data
{
    public class RemetaskContext : IdentityDbContext<User>
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Task> Tasks { get; set; }
        public DbSet<TaskGroup> TaskGroups { get; set; }
        public DbSet<Workspace> Workspaces { get; set; }
        public DbSet<UserWorkspace> UserWorkspaces { get; set; }
        public DbSet<Invitation> Invitations { get; set; }
        public RemetaskContext(DbContextOptions<RemetaskContext> opt) : base(opt)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<UserWorkspace>().HasKey(ut => new {ut.UserId, ut.WorkspaceId});
        }
    }
