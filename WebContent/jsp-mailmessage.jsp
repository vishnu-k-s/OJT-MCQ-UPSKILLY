<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.util.*,javax.mail.*"%>

	<%@ page import="javax.mail.internet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mail Verification</title>
</head>
<body>

<%

    //Creating a result for getting status that messsage is delivered or not!
    String result="";
    		
	String pasword="";
    int count=0;
    
    // Get recipient's email-ID
    final String to = request.getParameter("mail");

    final String subject ="Your password";

    
    Class.forName("com.mysql.jdbc.Driver");	
	Connection con=null;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ojt-upskilly","root","");
	Statement stn=con.createStatement();
	ResultSet rs=stn.executeQuery("select email,password from user_registration");
	while(rs.next())
	{
		
		String mail_1=rs.getString("email");					
		String password_1=rs.getString("password");						
		
		if(mail_1.equals(to))  
		{
			pasword= password_1; 
			count=1;
			break;
		}
		else
		{
			count=0;
		}
		
	}
	
	if(count==0){	
		response.sendRedirect("upskilly-warning-page.html");
	}
    
	final String messg=pasword;
 
    // Sender's email ID and password 
    final String from = "vishnusajeevks@gmail.com";
    final String pass = "*vishnu123";

 
    // Defining the gmail host

    String host = "smtp.gmail.com";

 
    // Creating Properties object

    Properties props = new Properties();

 
    // Defining properties

    props.put("mail.smtp.host", host);

    props.put("mail.transport.protocol", "smtp");

    props.put("mail.smtp.auth", "true");

    props.put("mail.smtp.starttls.enable", "true");

    props.put("mail.user", from);

    props.put("mail.password", pass);

    props.put("mail.port", "443");

 

    // Authorized the Session object.

    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

        @Override

        protected PasswordAuthentication getPasswordAuthentication() {

            return new PasswordAuthentication(from, pass);

        }

    });

 

    try {

        // Create a default MimeMessage object.

        MimeMessage message = new MimeMessage(mailSession);

        // Set From: header field of the header.

        message.setFrom(new InternetAddress(from));

        // Set To: header field of the header.

        message.addRecipient(Message.RecipientType.TO,

                new InternetAddress(to));

        // Set Subject: header field

        message.setSubject(subject);

        // Now set the actual message

        message.setText(messg);

        // Send message

        Transport.send(message);

        result = "Your mail sent successfully....";
        
        

    } catch (MessagingException mex) {

        mex.printStackTrace();

        result = "Error: unable to send mail....";

    }
   
%>
<% 
 		
		if(count==1)
		{
			response.sendRedirect("upskilly-login-page.html");
		}
 %>

</body>
</html>