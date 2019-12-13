<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/app.js"></script>
</head>
<body>
	<div class="container">
		<div class="row mt-5"></div>
		<div class="row">
			<div class="d-flex bd-highlight mb-3 font-weight-bold">
				<div class="p-2 bd-highlight">Welcome, ${user.name}</div>
				<div class="p-2 bd-highlight"><a href="/highlow">Priority High-Low</a></div>
				<div class="p-2 bd-highlight"><a href="/lowhigh">Priority Low-High</a></div>
				<div class="ml-auto p-2 bd-highlight"><a href="/logout">Logout</a></div>
			</div>

		</div>
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th scope="col">Task</th>
					<th scope="col">Creator</th>
					<th scope="col">Assignee</th>
					<th scope="col">Priority</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="task" items="${tasks}">
					<tr>
						<td><a href="/tasks/${task.id}">${task.description}</a></td>
						<td>${task.creator.name}</td>
						
						<td>${task.assignee.name}</td>

						<c:if test="${task.priority == 1}">
							<td>High</td>
						</c:if>
						<c:if test="${task.priority == 2}">
							<td>Medium</td>
						</c:if>
						<c:if test="${task.priority == 3}">
							<td>Low</td>
						</c:if>
					</tr>
				</c:forEach>


			</tbody>
		</table>
		<form action="tasks/new">
			<button type="submit" class="btn btn-secondary rounded-pill">Create
				Task</button>
		</form>


	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>