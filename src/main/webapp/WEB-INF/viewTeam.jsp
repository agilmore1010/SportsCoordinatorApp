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
<title>Team Details</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
</head>
<body>
	<div class="container mt-5">
		<h1 class="mb-4">
			<c:out value="${team.teamName}" />
		</h1>
		<a href="/homepage">dashboard</a>
		<table class="table table-bordered table-striped">
			<tbody>
				<tr>
					<th scope="row">Team Name</th>
					<td><c:out value="${team.teamName}" /></td>
				</tr>
				<tr>
					<th scope="row">Added By</th>
					<td><c:out value="${team.user.username}" /></td>
				</tr>
				<tr>
					<th scope="row">Skill Level</th>
					<td><c:out value="${team.skill}" /></td>
				</tr>
				<tr>
					<th scope="row">Game Day:</th>
					<td><c:out value="${team.gameDay}" /></td>
				</tr>
			</tbody>
		</table>
		<h2 class="mt-4" style="color: purple">Players</h2>
		<ul class="list-group">
			<c:forEach items="${team.players}" var="player">
				<li class="list-group-item" style="color: purple"><c:out
						value="${player.name}" /></li>
			</c:forEach>
		</ul>
		<h2 class="mt-4" style="color: purple">Add Player:</h2>
		<c:if test="${not empty success}">
			<div class="alert alert-success">
				<c:out value="${success}" />
			</div>
		</c:if>
		<c:if test="${not empty error}">
			<div class="alert alert-danger">
				<c:out value="${error}" />
			</div>
		</c:if>

		<form action="/add/player/${team.id}" method="post">
			<div class="form-group">
				<label for="playerName" style="color: purple">Player Name:</label> <input
					type="text" name="playerName" id="playerName" class="form-control"
					required />
			</div>
			<button type="submit" class="btn btn-primary">Add Player</button>
		</form>
		<c:if
			test="${not empty sessionScope.userId !=null && team.user.id == sessionScope.userId}">
			<div class="d-flex flex-column">
				<a href="/edit/team/${team.id}">edit </a>
				<form action="/delete/team/${team.id}" method="post"
					style="display: inline;">
					<input type="hidden" name="_method" value="delete" />
					<button type="submit" class="btn btn-link p-0">delete</button>
				</form>
			</div>
		</c:if>
	</div>
</body>
</html>
