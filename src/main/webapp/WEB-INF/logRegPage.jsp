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
			<div class="col">
				<h1>Register!</h1>
				<p>
					<form:errors path="user_r.*" />
				</p>

				<form:form method="POST" action="/registration"	modelAttribute="user_r">
					<p>
						<form:label path="name">Name:</form:label>
						<form:input type="text" path="name" />
					</p>
					<p>
						<form:label path="email">Email:</form:label>
						<form:input type="email" path="email" />
					</p>
					<p>
						<form:label path="password">Password:</form:label>
						<form:password path="password" />
					</p>
					<p>
						<form:label path="passwordConfirmation">Password Confirmation:</form:label>
						<form:password path="passwordConfirmation" />
					</p>
					<button type="submit" class="btn btn-secondary rounded-pill">Register</button>
				</form:form>
			</div>

			<div class="col">
				<h1>Login</h1>
				<p>
					<c:out value="${error}" />
				</p>
				<form method="post" action="/login">
					<p>
						<label for="email">Email</label> <input type="text" id="email"
							name="email_l" />
					</p>
					<p>
						<label for="password">Password</label> <input type="password"
							id="password" name="password_l" />
					</p>
					<button type="submit" class="btn btn-secondary rounded-pill">Login</button>
				</form>
			</div>
		</div>


	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>