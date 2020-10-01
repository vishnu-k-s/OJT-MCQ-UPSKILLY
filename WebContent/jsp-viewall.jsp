<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="\OJT-UPSKILLY\css\upskilly-common.css"> 
<link rel="stylesheet" href="\OJT-UPSKILLY\css\upskilly-bootstrap.min.css">
   
</head>
<body>
<nav class="navbar navbar-chalk" id="top_banner">
        <div class="nav_container">
        <a class="logo logo_enterprise pull-left">
            <img src="\OJT-UPSKILLY\images\logo.png">
        </a>
            <div class="controls_wrapper">    
                
                <a class="fc4" href="index.html">Log Out</a>
            </div>
        </div>
</nav>
<br><br>
		<center>
			<table border="2">
			<tr>

			<th>NAME</th>
			<th>EMAIL</th>
			<th>USERNAME</th>
			<th>PASSWORD</th>

			</tr>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");	
	Connection con=null;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
	Statement stn=con.createStatement();
	ResultSet rs=stn.executeQuery("select * from user_registration");
	while(rs.next())
	{

%>	
	<tr>
	<td><%=rs.getString("name") %></td>
    <td><%=rs.getString("email") %></td>
    <td><%=rs.getString("username") %></td>
    <td><%=rs.getString("password") %></td>
    
    </tr>
       <%

}
%>
    </table>
    </center>
    <%
    rs.close();
    stn.close();
    con.close();
    }
catch(Exception e)
{
    e.printStackTrace();
    }




%>
<center>
BACK TO <a href="upskilly-admin-page.html">DASHBOARD</a>
</center>

</body>
</html>