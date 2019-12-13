package com.codingdojo.authentication.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.authentication.models.Task;
import com.codingdojo.authentication.repositories.TaskRepository;

@Service
public class TaskService {
	private TaskRepository taskRepository;

	public TaskService(TaskRepository taskRepository) {
		super();
		this.taskRepository = taskRepository;
	}

	public Task findTaskById(Long id) {
		Optional<Task> task = taskRepository.findById(id);
		if (task.isPresent()) {
			return task.get();
		} else {
			return null;
		}
	}

}
