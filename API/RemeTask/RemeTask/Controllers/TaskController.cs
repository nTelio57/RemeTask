﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using RemeTask.Data;
using RemeTask.Dtos.Task;
using RTTask = RemeTask.Models.Task;

namespace RemeTask.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly ITaskRepository _repository;
        private readonly IMapper _mapper;
        public TaskController(ITaskRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<IActionResult> CreateTask(TaskCreateDto taskCreateDto)
        {
            var taskModel =  _mapper.Map<RTTask>(taskCreateDto);

            await _repository.CreateTask(taskModel);
            await _repository.SaveChanges();

            var taskReadDto = _mapper.Map<TaskReadDto>(taskModel);
            return CreatedAtRoute(nameof(GetTaskById), new {Id = taskReadDto.Id}, taskReadDto);
        }

        [HttpGet]
        public async Task<IActionResult> GetAllTasks()
        {
            var task = await _repository.GetAllTasks();
            return Ok(_mapper.Map<IEnumerable<TaskReadDto>>(task));
        }

        [HttpGet("{id}", Name = "GetTaskById")]
        public async Task<IActionResult> GetTaskById(int id)
        {
            var task = await _repository.GetTaskById(id);
            if (task == null)
                return NotFound();
            return Ok(_mapper.Map<TaskReadDto>(task));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTask(int id)
        {
            var taskModel = await _repository.GetTaskById(id);
            if (taskModel == null)
                return NotFound();

            await _repository.DeleteTask(taskModel);
            await _repository.SaveChanges();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTask(int id, TaskUpdateDto taskUpdateDto)
        {
            var taskModel = await _repository.GetTaskById(id);
            if (taskModel == null)
                return NotFound();

            _mapper.Map(taskUpdateDto, taskModel);
            await _repository.UpdateTask(taskModel);
            await _repository.SaveChanges();
            return NoContent();
        }
    }
}
