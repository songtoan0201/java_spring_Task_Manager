package com.codingdojo.authentication.controllers;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codingdojo.authentication.models.Task;
import com.codingdojo.authentication.models.User;
import com.codingdojo.authentication.repositories.TaskRepository;
import com.codingdojo.authentication.repositories.UserRepository;
import com.codingdojo.authentication.services.TaskService;
import com.codingdojo.authentication.services.UserService;
import com.codingdojo.authentication.validator.TaskValidator;
import com.codingdojo.authentication.validator.UserValidator;

@Controller
public class HomeController {
	private final UserRepository userRepository;
	private final TaskRepository taskRepository;
	private final UserService userService;
	private final TaskService taskService;
	
    private final UserValidator userValidator;
    private final TaskValidator taskValidator;


	public HomeController(UserRepository userRepository, TaskRepository taskRepository, UserService userService,
			TaskService taskService, UserValidator userValidator, TaskValidator taskValidator) {
		super();
		this.userRepository = userRepository;
		this.taskRepository = taskRepository;
		this.userService = userService;
		this.taskService = taskService;
		this.userValidator = userValidator;
		this.taskValidator = taskValidator;
	}

	// show all tasks and creators and assignee
	@RequestMapping("/tasks")
	public String home(HttpSession session, Model model) {
		// get user from session, save them in the model and return the home page
		Long userid = (Long) session.getAttribute("userid");
		List<Task> tasks = taskRepository.findAll();
	
		model.addAttribute("user", userService.findUserById(userid));
		model.addAttribute("tasks", tasks);
		return "homePage.jsp";
	}
	
	//Create new task
	@GetMapping("/tasks/new")
	public String renderCreateTask(@ModelAttribute("task") Task task, Model model) {
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		return "newTask.jsp";
	}
	
	@PostMapping("/tasks/new")
	public String createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, HttpSession session) {
		taskValidator.validate(task.getAssignee(), task, result);
		if(result.hasErrors()) {
			return "newTask.jsp";
		} else {
			Long userid = (Long) session.getAttribute("userid");
			task.setCreator(userService.findUserById(userid));
			taskRepository.save(task);
			return "redirect:/tasks";
		}
	}
	
	//View task
	@GetMapping("/tasks/{task_id}")
	public String showTask(@PathVariable("task_id") Long id, Model model, HttpSession session) {
		Task task = taskService.findTaskById(id);
		Long userid = (Long) session.getAttribute("userid");
		
		model.addAttribute("task", task);
		model.addAttribute("cur_user", userService.findUserById(userid));
		return "viewTask.jsp";
	}
	
	@GetMapping("/tasks/{task_id}/edit")
	public String renderEditTask(@PathVariable("task_id") Long id, Model model, HttpSession session) {
		Task task = taskService.findTaskById(id);
		Long userid = (Long) session.getAttribute("userid");
		if (userid != task.getCreator().getId())
			return "redirect:/tasks/";
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		model.addAttribute("task", task);
		return "editTask.jsp";
	}
	
	@PostMapping("/tasks/{task_id}/edit")
	public String editTask(@PathVariable("task_id") Long id, @Valid @ModelAttribute("task") Task task, BindingResult result) {
		if(result.hasErrors()) {
			return "editTask.jsp";
		} else {
			Task cur_task = taskService.findTaskById(id);
			cur_task.setDescription(task.getDescription());
			cur_task.setAssignee(task.getAssignee());
			cur_task.setPriority(task.getPriority());

			taskRepository.save(cur_task);
			return "redirect:/tasks/" + id;
		}
	}

	@GetMapping("/tasks/{task_id}/delete")
	public String deleteTask(@PathVariable("task_id") Long id) {
		taskRepository.deleteById(id);
		return "redirect:/tasks";
	}
	
}
