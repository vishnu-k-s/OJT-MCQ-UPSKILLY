<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String thisUser = (String) session.getAttribute("myUser");

String thisPass = (String) session.getAttribute("myPass");

String thisName = (String) session.getAttribute("myName");
String mark =request.getParameter("results");
%>


<%
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=null;
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
			Statement stn=con.createStatement();
			String str1= "INSERT INTO marks VALUES('"+mark+"','"+"Technical"+"','"+thisUser+"')";
			stn.execute(str1);
								
				
		}
		catch(Exception e){
		out.println(e);
		}
		response.sendRedirect("upskilly-tech-report.html"); 
%>
</body>
</html>