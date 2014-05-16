<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@page import="de.ulm.uni.vs.avid.roary.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<title>Roary History</title>
	<link rel="stylesheet" type="text/css" href="roar.css">
</head>
<body>
<h1>Roary</h1>

<c:set var="userName" value="<%=request.getUserPrincipal().getName() %>" />
<c:if test="${not empty userName}">
	<p>Hi ${userName }! <a href="Logout.jsp">logout</a>.</p>
	<h2><a href="RoaryEdit.jsp?act=new">New Roar</a></h2>
</c:if>

<h2>Roars</h2>
<jsp:useBean id="roarHist" class="de.ulm.uni.vs.avid.roary.RoarHistory" scope="application"></jsp:useBean>
<%
	List<Roar> roars = (List<Roar>)application.getAttribute("appRoars");
	// If the application is just starting, init some roars for testing to the application context (default 'hardcoded' roars from RoarHistory)
	if (roars == null) { 
		roars = roarHist.getRoars(); // retrieves the hardcoded roars
		application.setAttribute("appRoars", roars);
	}
%>

<c:forEach var="roar" items="${applicationScope.appRoars}" varStatus="status">
	<div class='roar'>
		<div class='header'>
			<div class='author'><c:out value="${roar.author}" /></div>
			<div class='time'><c:out value="${roar.creationTime}" /></div>
		</div>
		<div class='body'><c:out value="${roar.text}" /></div>
		<div class='footer'>
			<c:if test="${not empty userName && userName == roar.author }">
				<a href="RoaryEdit.jsp?act=edit&index=${status.index}">edit</a>
			</c:if>
		</div>
	</div>
</c:forEach>

</body>
</html>