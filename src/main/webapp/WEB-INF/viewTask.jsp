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
		<h1>Task: ${task.description}</h1>

		<table class="table">
			<tbody>
				<tr>
					<td>Creator:</td>
					<td>${task.creator.name}</td>

				</tr>
				<tr>
					<td>Assignee:</td>
					<td>${task.assignee.name}</td>

				</tr>
				<tr>
					<td>Priority:</td>
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

			</tbody>
		</table>

		<c:if test="${cur_user.id == task.creator.id}">
			<div class="row">
				<form action="/tasks/${task.id}/edit">
					<button type="submit" class="btn btn-secondary rounded-pill">Edit</button>
				</form>
				<div class="ml-3"></div>
				<form action="/tasks/${task.id}/delete">
					<button type="submit" class="btn btn-secondary rounded-pill">Delete</button>
				</form>
			</div>
		</c:if>
		<c:if test="${cur_user.id == task.assignee.id}">
		<div class="row mt-5">
			<form action="/tasks/${task.id}/delete">
				<button type="submit" class="btn btn-secondary rounded-pill">Complete</button>
			</form>
		</div>
		</c:if>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>