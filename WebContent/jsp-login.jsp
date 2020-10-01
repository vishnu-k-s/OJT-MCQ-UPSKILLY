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

				String strUser = request.getParameter("username");
				session.setAttribute("myUser", strUser);

				String strPass = request.getParameter("password");
				session.setAttribute("myPass", strPass);

								
				String a="admin";
				
				String username=request.getParameter("username"); 
				String password=request.getParameter("password");
				
				if(username.equals(a) && password.equals(a))
				{
					response.sendRedirect("upskilly-admin-page.html"); 					
					
				}
				
				Class.forName("com.mysql.jdbc.Driver");	
				Connection con=null;
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
				Statement stn=con.createStatement();
				ResultSet rs=stn.executeQuery("select * from user_registration");
				while(rs.next())
				{
					
					String username_1=rs.getString("username");					
					String password_1=rs.getString("password");						
										
					if(username_1.equals(username) && password_1.equals(password))  
					{	
						
						response.sendRedirect("upskilly-user-page.html");  						
					}
				}
				
%>
</body>
</html>