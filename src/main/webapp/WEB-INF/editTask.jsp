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
		<h1>Edit Task: ${task.description}</h1>
		<p>
			<form:errors path="task.*" />
		</p>

		<form:form method="post" action="/tasks/${task.id}/edit" modelAttribute="task">
			<p>
				<form:label path="description">Task:</form:label>
				<form:input type="text" path="description" />
			</p>
			<p>
				<form:label path="assignee">Assignee:</form:label>
				<form:select path="assignee">
					<c:forEach items="${users}" var="user">
						<form:option value="${user.getId()}">${user.name}</form:option>
					</c:forEach>
				</form:select>
			</p>
			<p>
				<form:label path="priority">Priority</form:label>
				<form:select path="priority">
					<form:option value="1">High</form:option>
					<form:option value="2">Medium</form:option>
					<form:option value="3">Low</form:option>
				</form:select>
			</p>
			<button type="submit" class="btn btn-secondary rounded-pill">Edit</button>
		</form:form>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>