package com.codingdojo.authentication.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.authentication.models.User;
import com.codingdojo.authentication.services.UserService;
import com.codingdojo.authentication.validator.UserValidator;

@Controller
public class UserController {
	private final UserService userService;
	private final UserValidator userValidator;

	public UserController(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
	}

	@RequestMapping("/")
	public String registerLoginForm(Model model) {
		model.addAttribute("user_r", new User());
//		model.addAttribute("user_l", new User());
		return "logRegPage.jsp";
	}
	
//  Second way of doing this
//	@RequestMapping("/")
//	public String registerLoginForm(@ModelAttribute("user_r") User user_r, @ModelAttribute("user_l") User user_l ) {
//		return "registrationPage.jsp";
//	}

	
	//500 error: syntax or logic
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user_r") User user, BindingResult result, HttpSession session) {
		// if result has errors, return the registration page (don't worry about
		// validations just now)
		// else, save the user in the database, save the user id in session, and
		// redirect them to the /home route
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "logRegPage.jsp";
		} 
		//use userService for user and findById
		User u = userService.registerUser(user);
		session.setAttribute("userid", u.getId());
		return "redirect:/tasks";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@RequestParam("email_l") String email, @RequestParam("password_l") String password, Model model,
			HttpSession session) {
		// if the user is authenticated, save their user id in session
		// else, add error messages and return the login page
		if (userService.authenticateUser(email, password)) {
			User u = userService.findByEmail(email);
			session.setAttribute("userid", u.getId());
			return "redirect:/tasks";
		} else {
			model.addAttribute("error", "Invalid Credentials. Please try again");
			return "logRegPage.jsp";
		}
	}


	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		// invalidate session
		// redirect to login page
		if (session != null)
			session.invalidate();
		return "redirect:/";
	}
}