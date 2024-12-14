<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New Team</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center">New Team</h1>
        <a href="/homepage">dashboard</a>
        <form:form action="/create/team" method="post" modelAttribute="team">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <td><form:label path="teamName">Team Name</form:label></td>
                            <td><form:input type="text" path="teamName" class="form-control" /></td>
                            <td><form:errors class="text-danger" path="teamName" /></td>
                        </tr>
                        <tr>
                            <td><form:label path="skill">Skill Level (1-5)</form:label></td>
                            <td><form:input type="number" path="skill" class="form-control" /></td>
                            <td><form:errors class="text-danger" path="skill" /></td>
                        </tr>
                        <tr>
                            <td><form:label path="gameDay">Game Day</form:label></td>
                            <td><form:input type="text" path="gameDay" class="form-control" /></td>
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
    </div>
</body>
</html>
