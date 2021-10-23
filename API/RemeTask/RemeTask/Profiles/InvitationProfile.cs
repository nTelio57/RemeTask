using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using RemeTask.Dtos.Invitation;
using RemeTask.Models;

namespace RemeTask.Profiles
{
    public class InvitationProfile : Profile
    {
        public InvitationProfile()
        {
            CreateMap<Invitation, InvitationReadDto>()
                .ForMember(dst => dst.Workspace, src => src.MapFrom(mbr => mbr.Workspace))
                .ForMember(dst => dst.Invitee, src => src.MapFrom(mbr => mbr.Invitee))
                .ForMember(dst => dst.Inviter, src => src.MapFrom(mbr => mbr.Inviter));
            CreateMap<InvitationCreateDto, Invitation>();
        }
    }
}
