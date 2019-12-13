package com.codingdojo.authentication.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.authentication.models.Task;


@Repository
public interface TaskRepository extends CrudRepository<Task, Long>{
	List<Task> findAll();

	
}
