<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@page import="de.ulm.uni.vs.avid.roary.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

<% 
String editText = "";
String roarIndex = "";
String act = request.getParameter("act");

if (act != null && act.equals("edit")) { // are we in edit mode
	if (application.getAttribute("appRoars") != null) { // do we have a Roar history?
		roarIndex = request.getParameter("index");
		List<Roar> roars = (List<Roar>)application.getAttribute("appRoars");
		editText = roars.get(Integer.parseInt(roarIndex)).getText(); 
	} else {
		out.write("Sorry, there are no Roars available for editing.");
	}
}
%>

What's your Roar?
<form method="get" action="/Roary-JSP/RoarHistoryUpdate">
	<textarea rows="5" cols="60" name="roarText"><%=editText%></textarea>
	<input type="hidden" name="index" value=<%=roarIndex%>></input>
	<input type="hidden" name="act" value=<%=act%>></input>
	<input value="Submit" type="submit" />
</form>

</body>
</html>