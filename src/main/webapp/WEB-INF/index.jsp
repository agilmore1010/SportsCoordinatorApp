<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Kickball League</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<div class="container text-center content">
		<h1>Authentication</h1>
		<h2>Register</h2>
		<form:form action="/register/user" method="post"
			modelAttribute="newUser">
			<p>
				<form:label path="username">User Name:</form:label>
				<form:errors class="text-danger" path="username" />
				<form:input class="w-100" path="username" />
			</p>
			<p>
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input type="email" class="w-100" path="email" />
			</p>
			<p>
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" />
				<form:input class="w-100" path="password" type="password" />
			</p>
			<p>
				<form:label path="confirm">Confirm Password</form:label>
				<form:errors class="text-danger" path="confirm" />
				<form:input class="w-100" path="confirm" type="password" />
			</p>
			<button>Register</button>
		</form:form>
		<h2>Login</h2>
		<form:form action="/login/user" method="post"
			modelAttribute="newLogin">
			<p>
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input type="email" class="w-100" path="email" />
			</p>
			<p>
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" />
				<form:input class="w-100" path="password" type="password" />
			</p>
			<button>Login</button>
		</form:form>
	</div>
</body>
</html>