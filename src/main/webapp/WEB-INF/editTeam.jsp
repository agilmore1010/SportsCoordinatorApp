<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Team</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
</head>
<body>
	<div class="container mt-4">
		<h1 class="text-center">Edit Team</h1>
		<a href="/homepage">dashboard</a>
		<p class="text-danger">
			<c:out value="${error}" />
		</p>
		<form:form action="/update/team/${team.id}" method="post"
			modelAttribute="team">
			<input type="hidden" name="_method" value="put" />
			<div class="table-responsive">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td><form:label path="teamName">Team Name</form:label></td>
							<td><form:input type="text" path="teamName"
									class="form-control" /></td>
							<td><form:errors class="text-danger" path="teamName" /></td>
						</tr>
						<tr>
							<td><form:label path="skill">Skill Level (1-5)</form:label></td>
							<td><form:input type="number" path="skill"
									class="form-control" /></td>
							<td><form:errors class="text-danger" path="skill" /></td>
						</tr>
						<tr>
							<td><form:label path="gameDay">Game Day:</form:label></td>
							<td><form:input type="text" path="gameDay"
									class="form-control" /></td>
							<td><form:errors class="text-danger" path="gameDay" /></td>
						</tr>
						<tr>
							<td colspan="3" class="text-center">
								<button type="submit" class="btn btn-primary">Submit</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form:form>
		<form action="/delete/team/${team.id}" method="post"
			style="display: inline;">
			<input type="hidden" name="_method" value="delete" />
			<button type="submit" class="btn btn-link p-0">delete</button>
		</form>
	</div>
</body>
</html>
