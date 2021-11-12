using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;

namespace RemeTask.Models
{
    public class RolesAttribute : AuthorizeAttribute
    {
        public RolesAttribute(params string[] roles)
        {
            Roles = string.Join(",", roles);
        }
    }

    public static class UserRoles
    {
        public const string Admin = nameof(Admin);
        public const string Pro = nameof(Pro);
        public const string Basic = nameof(Basic);

        public static readonly IReadOnlyCollection<string> All = new[] {Admin, Pro, Basic};
        public static readonly IReadOnlyCollection<string> AllNonAdmin = new[] { Pro, Basic };
    }
}
