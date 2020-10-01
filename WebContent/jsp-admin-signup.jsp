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
		String name=request.getParameter("name"); 
		String email=request.getParameter("email");
		String username=request.getParameter("username"); 
		String password=request.getParameter("password");
		
		Class.forName("com.mysql.jdbc.Driver");	
		Connection con=null;
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
		Statement stn=con.createStatement();
		String str1= "INSERT INTO user_registration VALUES('"+name+"','"+email+"','"+username+"','"+password+"')";
		stn.execute(str1);
						
		response.sendRedirect("upskilly-admin-page.html");
		
%>
</body>
</html>