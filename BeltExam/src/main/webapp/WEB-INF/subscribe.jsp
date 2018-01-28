<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Package Selection!</title>
<link rel="stylesheet" type="text/css" href="css/subscribe.css">
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
<h2 class="dow">Dog of the Week</h2>
<p class="dow">Each week we feature a dog of the week. If you would like you dog to be featured, send us a pic of your dog!</p>
<div class="dow">
	<img src="images/dow.jpg" alt="dow">
</div>
<h1 class="name">Subscription Boxes</h1>
<h3 class="here">Here are a couple of packages to choose from</h3>
	<div class="section">
	<div>
		<div class="small">
    	<img src="images/hotdog.jpg" alt="small" width="500">
    	</div>
    	<p class="expect">*Expect at least 6 items</p>
    	<p class="desc">We don't forget about the little guys. This package is made for the smaller breeds.
    	Expect this package to include 2 bully beef sticks, toy, slow feeder bowl, cleaning solution, 
    	coat/fur shampoo, dental chews, dry and moist treats.</p>
    </div>
    <div>
	    <div class="medium">
	    	<img src="images/doge.jpg" alt="medium" width="500">
	    </div>
    	<p class="expect">*Expect at least 9 items</p>
    	<p class="desc">This package was inspired by the Doge meme. It is curated for the medium sized breeds. 
    	Expect this package to include 3 bully beef sticks, bone marrow, toy, slow feeder bowl, cleaning solution, 
    	coat/fur shampoo, dental chews, dry and moist treats.</p>
    </div>
    <div>
    	<div class="large">
    		<img src="images/husky.jpg" alt="large" width="500">
    	</div>
    	<p class="expect">*Expect at least 11 items</p>
    	<p class="desc">Big dogs have big appetites. This package is aimed to satisfy any hound. The package comes with 4 bully beef sticks,
    	bone marrow, beef femur, toy, slow feeder bowl, cleaning solution, 
    	coat/fur shampoo, dental chews, dry and moist treats.</p>
    </div>
    <div>
    	<div class="giant">
    		<img src="images/mastiff.jpg" alt="giant" width="500">
    	</div>
    	<p class="expect">*Expect at least 14 items</p>
    	<p class="desc">For the intimidating but friendly giant. This one is for the Dogue De Bordeaux, the Mastiffs, the Great Danes, and so on.
    	This package will be worthy of these big fellas. It comes with 5 bully beef sticks, bone marrow, beef femur, big chew bone, 
    	2 toys, slow feeder bowl, cleaning solution, coat/fur shampoo, dental chews, dry and moist treats.</p>
    </div>
    </div>
    <p class="message">*All packages are an example of what to expect but every month will be curated with new items.</p>
	<div class="subscribe">
	<h2>Choose Your Subscription</h2>
	<p><form:errors path="user.*"/></p>
	<form:form method="POST" action="/subscribe" modelAttribute="user">
        <p class="due">
            <form:label path="dueDate">Due Day:</form:label>
            <form:input path="dueDate" type="number" name="dueDate" min="1" max="31"/>
        </p>
        <p class="due-ex">*The day will reflect on the nearest available due date. Ex. if today is 1/5/2018 and day 15 is selected, then payment will be due 1/15/2018. If day 4 is chosen, then payment will be due 2/4/18.</p>
        <p>
        	<form:label path="box">Package:</form:label>
        	<form:select path="box" name="box">
        	<c:forEach var="box" items="${allBoxes}">
        		<form:option value="${box}"><c:out value="${box.name}"/> (<fmt:formatNumber value="${box.price}" type="currency" currencySymbol="$"/>)</form:option>
	        </c:forEach>
	        </form:select>
	    </p>
        <input class="subscribe" type="submit" value="SUBSCRIBE"/>
	</form:form>
	</div>
	<div class="subscribe">
		<h2>Current Subscription</h2>
		<c:choose>
		<c:when test="${currentUser.box.id != null}">
		<p class="ending">Your are currently subscribed to: <c:out value="${currentUser.box.name}"></c:out></p>
		<jsp:useBean id="now" class="java.util.Date"/>
		<fmt:formatDate var="date" value="${now}" pattern="dd"/>
		<fmt:formatDate var="month" value="${now}" pattern="MM"/>
		<c:choose>
		<c:when test="${date lt currentUser.dueDate}">
		<fmt:formatDate var="month" value="${now}" pattern="MMMM"/>
		<p class="ending">Next Due Date: ${month} ${currentUser.dueDate} </p>
		</c:when>
		<c:otherwise>
		<jsp:useBean id="monthNames" class="java.text.DateFormatSymbols"/>
		<c:set value="${monthNames.months}" var="months" />
		<p class="ending">Next Due Date: ${months[month]} ${currentUser.dueDate}</p> 
		</c:otherwise>
		</c:choose>
		
		<p class="ending">Amount: <fmt:formatNumber value="${currentUser.box.price}" type="currency" currencySymbol="$"/></p>
		<p class="ending">User since: <fmt:formatDate value="${currentUser.createdAt}" pattern="EEEE, MM/dd/yyyy"/></p>
		<p class="ending">Thanks for being a part of DoggyCrate. Hope you and your pal(s) are enjoying your subscription.</p>
		</c:when>
		<c:otherwise>
		<p>You are currently not subscribed yet.</p>
		</c:otherwise>
		</c:choose>
	</div>
	
</body>
</html>