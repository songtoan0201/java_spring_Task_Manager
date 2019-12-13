package com.codingdojo.authentication.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.codingdojo.authentication.models.Task;
import com.codingdojo.authentication.models.User;

@Component
public class TaskValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	public void validate(Object user_target, Object task_target, Errors errors) {
		User user = (User) user_target;
		Task task = (Task) task_target;
		if (user.getAssigned_tasks().size() == 3 && task.getAssignee().getName().equals(user.getName())) {
			errors.rejectValue("assignee", "More");
		}
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub

	}

}
