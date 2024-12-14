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
<title>Kickball League Dashboard</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
</head>
<body>
	<div class="container">
		<h1>
			Welcome,
			<c:out value="${user.username }" />
			!
		</h1>
		<a href="/logout">Log out</a>

		<div class="container">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Team Name</th>
						<th>Skill Level(1-5)</th>
						<th style = "color: purple"> Players</th>
						<th>Game Day</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="team" items="${teams}">
						<tr>
							<td><a href="view/team/${team.id}">${team.teamName}</a></td>
							<td><c:out value="${team.skill}" /></td>
							<td style = "color:purple">${team.players.size()}/9</td>
							<td><c:out value="${team.gameDay}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<a href="/new/team" class="btn btn-primary">Create A New Team</a>
	</div>
</body>
</html>
