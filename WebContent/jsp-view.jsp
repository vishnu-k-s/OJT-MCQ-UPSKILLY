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
<%
String thisUser = (String) session.getAttribute("myUser");

String thisPass = (String) session.getAttribute("myPass");

%>


<center>
<table border="2">
<tr>
<th>MARK</th>
<th>TYPE</th>
</tr>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");	
	Connection con=null;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
	Statement stn=con.createStatement();
	ResultSet rs=stn.executeQuery("select * from marks where username='"+thisUser+"'");
while(rs.next())
{

%>
    
    <tr>
    <td><%=rs.getString("mark") %></td>
     <td><%=rs.getString("type") %></td>
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
BACK TO <a href="upskilly-user-page.html">DASHBOARD</a>
</center>
</body>
</html>