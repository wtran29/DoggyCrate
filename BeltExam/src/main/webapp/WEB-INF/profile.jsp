<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Profile</title>
<link rel="stylesheet" type="text/css" href="css/profile.css">
</head>
<body>
<h1 class="title">Welcome to <span class="name">DoggyCrate</span><span class="username">, <c:out value="${currentUser.firstname}"/></span></h1>
<div class="nav-bar">
	<ul>
		<li><a href="#">BREEDS</a></li>
		<li><a href="#">DOG PHOTOS</a></li>
		<li><a href="#">TIPS AND TRICKS</a></li>
		<li><a href="#">ADOPT</a></li>
	</ul>
<div class="logout">
<form id="logoutForm" method="POST" action="/logout">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
       <input class="logout" type="submit" value="LOGOUT" />
</form>
</div>
</div>
<a class="back" href="/subscribe">back</a>

<h1 class="thanks">Thank you for subscribing to DoggyCrate</h1>
<div class="thanks">
	<img src="images/group.jpg" alt="group" width="800">
</div>
<div class="section">
<h3>Your package will arrive soon.</h3>
<p>You have selected <span><c:out value="${currentUser.box.name}"/></span> as your current package.</p>
<p>Your box is curated as described: <c:out value="${currentUser.box.description}"></c:out></p>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate var="date" value="${now}" pattern="dd"/>
<fmt:formatDate var="month" value="${now}" pattern="MM"/>
<c:choose>
<c:when test="${date lt currentUser.dueDate}">
<fmt:formatDate var="month" value="${now}" pattern="MMMM"/>
<p>Next Due Date: ${month} ${currentUser.dueDate} </p>
</c:when>
<c:otherwise>
<jsp:useBean id="monthNames" class="java.text.DateFormatSymbols"/>
<c:set value="${monthNames.months}" var="months" />
<p>Next Due Date: ${months[month]} ${currentUser.dueDate}</p> 
</c:otherwise>
</c:choose>

<p>Amount: <fmt:formatNumber value="${currentUser.box.price}" type="currency" currencySymbol="$"/></p>
<p>User since: <fmt:formatDate value="${currentUser.createdAt}" pattern="MM/dd/yyyy"/></p>
</div>

</body>
</html>