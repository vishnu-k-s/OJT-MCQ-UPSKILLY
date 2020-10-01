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
		
		String currentPassword =request.getParameter("password");
		String Newpass=request.getParameter("newpassword");
		String conpass=request.getParameter("conpassword");
		
		String pass="";
		String uname="";
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=null;
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
			Statement stn=con.createStatement();
			ResultSet rs=stn.executeQuery("select * from user_registration where password='"+currentPassword+"'");
			while(rs.next())
			{
				uname=rs.getString("username");
				pass=rs.getString("password");
				
				if(pass.equals(currentPassword))
				{
					Statement st1=con.createStatement();
					int i=st1.executeUpdate("update user_registration set password='"+Newpass+"' where username='"+uname+"'");
					response.sendRedirect("upskilly-admin-page.html");
					//st1.close();
					//con.close();
				}
				else
				{
					out.println("Invalid Current Password");
				}
			} 
			
		}
		catch(Exception e){
		out.println(e);
		}		
%>
</body>
</html>