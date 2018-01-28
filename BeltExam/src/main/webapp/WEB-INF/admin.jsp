<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
	<div class="header">
		<img class="logo" alt="logo" src="images/logo1.png" width="80">
	    <h1 class="title"><span class="name">DoggyCrate</span> Admin Dashboard</h1>
	    <div class="logout">
	    <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input class="logout-button" type="submit" value="Logout!" />
	    </form>
	    </div>
    </div>
    <h3>Customers</h3>
    <fieldset>
    <table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Next Due Date</th>
				<th>Amount Due</th>
				<th>Package Type</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${allUsers}">
			<tr>
				<td><c:out value="${user.firstname}"/> <c:out value="${user.lastname}"/></td>
				<jsp:useBean id="now" class="java.util.Date"/>
				<fmt:formatDate var="date" value="${now}" pattern="dd"/>
				<fmt:formatDate var="month" value="${now}" pattern="MM"/>
				<c:choose>
				<c:when test="${date lt user.dueDate}">
				<fmt:formatDate var="month" value="${now}" pattern="MMMM"/>
				<td> ${month} ${user.dueDate} </td>
				</c:when>
				<c:otherwise>
				<jsp:useBean id="monthNames" class="java.text.DateFormatSymbols"/>
				<c:set value="${monthNames.months}" var="months" />
				<td> ${months[month]} ${user.dueDate}</td> 
				</c:otherwise>
				</c:choose>
				<td><fmt:formatNumber value="${user.box.price}" type="currency" currencySymbol="$"/></td>
				<td><c:out value="${user.box.name}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</fieldset>
    <h3>Packages</h3>
    <fieldset>
    <table>
		<thead>
			<tr>
				<th>Package Name</th>
				<th>Package Cost</th>
				<th>Availability</th>
				<th>Number of Customers</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="box" items="${allBoxes}">
			<tr>
				<td><c:out value="${box.name}"/></td>
				<td><fmt:formatNumber value="${box.price}" type="currency" currencySymbol="$"/></td>
				
					<c:choose>
					<c:when test="${box.activate}">
						<td><p>available</p></td>
					</c:when>
					<c:otherwise>
						<td><p>unavailable</p></td>
					</c:otherwise>
					</c:choose>
				
				<td><c:out value="${fn:length(box.users)}"/></td>	
				<c:choose>
					<c:when test="${box.activate}">
						<td><a href="/deactivate/${box.id}">deactivate</a> </td>
					</c:when>
					<c:otherwise>					
						<c:choose>						
							<c:when test="${fn:length(box.users) < 1}">
								<td><a href="/activate/${box.id}">activate</a> | <a href="/delete/${box.id}">delete</a></td>
							</c:when>
							<c:otherwise>
								<td><a href="/activate/${box.id}">activate</a> </td>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</fieldset>
	<fieldset class="create">
	<h2>Create Package</h2>
	<c:if test="${boxMessage != null}">
    	<c:out value="${boxMessage}"/>
    </c:if>
	<p><form:errors path="box.*"/></p>
    
    <form:form method="POST" action="/box" modelAttribute="box">
        <p>
            <form:label path="name">Package Name:</form:label>
            <form:input path="name"/>
        </p>
        <p>
        	<form:label path="price">Cost:</form:label>
            <form:input path="price"/>
        </p>
        <p>
        	<form:label class="desc" path="description">Description:</form:label>
            <form:textarea path="description" type="textarea" cols="22" rows="5"/>
        </p>
        <input class="create-button" type="submit" value="NEW PACKAGE"/>
    </form:form>
    </fieldset>
</body>
</html>