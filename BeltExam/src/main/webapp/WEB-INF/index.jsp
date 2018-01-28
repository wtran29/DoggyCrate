<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login/Registration</title>

<link rel="stylesheet" type="text/css" href="/css/index.css"> 
</head>
<body>

	<c:if test="${logoutMessage != null}">
		<c:out value="${logoutMessage}"/>
	</c:if>
	<div class="header">
		<img alt="logo" src="images/logo1.png" width="80px">
		<h1>DoggyCrate</h1>
		<h3>A subscription platform for your dog!</h3>
	
	<div class="nav-bar">
	<ul>
		<li><a href="#">WHO ARE WE</a></li>
		<li><a href="#">WHAT WE OFFER</a></li>
		<li><a href="#">CONTACT US</a></li>
	</ul>
	</div>
	</div>
	<div class="about">
	<h3><span class="question">Question.</span> When is the last time you did something special for your best friend?</h3>
	<p class="answer">We have the answer you've been looking for. With DoggyCrate, you will be able to show how much they mean to you each month.
	Each package is curated specifically to your size dog with new items each month.</p>
	<p class="join">Join us and start receiving exciting gifts made for your buddy.</p>
    <div class="packages">
    <h3>Here are some subscription boxes available:</h3>
    <div class="small">
    	<img src="images/hotdog.jpg" alt="small" width="200">
    </div>
    <div class="medium">
    	<img src="images/doge.jpg" alt="medium" width="200">
    </div>
    <h3 class="last">Throw your dog a bone and join now.</h3>
    </div>
    </div>
    <div class=login-reg>
    <fieldset class="register">
    <h3>Sign Up Here</h3>
    <c:if test="${regMessage != null}">
    	<c:out value="${regMessage}"/>
    </c:if>
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
        <p>
            <form:label path="firstname">First Name:</form:label>
            <form:input path="firstname"/>
        </p>
        <p>
            <form:label path="lastname">Last Name:</form:label>
            <form:input path="lastname"/>
        </p>
        <p>
            <form:label path="email">Email:</form:label>
            <form:input path="email"/>
        </p>
        <p>
            <form:label path="password">Create Password:</form:label>
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirm:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input class="register-button" type="submit" value="REGISTER"/>
    </form:form>
    </fieldset>
    <fieldset class="login">
    <h3>Login</h3>
    <c:if test="${errorMessage != null}">
    	<c:out value="${errorMessage}"/>
    </c:if>
    <form method="POST" action="/login">
        <p>
            <label for="email">Email</label>
            <input type="text" id="email" name="username"/>
        </p>
        <p>
            <label for="password">Password</label>
            <input type="password" id="password" name="password"/>
        </p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="login-button" type="submit" value="SIGN IN"/>
    </form>
    </fieldset>
    </div>
</body>
</html>