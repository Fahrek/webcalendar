<%@ page language = "java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*"  %>

<html>
	<head>
		<meta charset = "ISO-8859-1">
		<meta http-equiv = "refresh" content = "0; url=../index.jsp">
		
		<title>Crear Calendario</title>
	</head>
	
	<body>
		<%
			try
			{
				String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				Connection conn = null;
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(connect, "web", "calendario" );
				
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("UPDATE eventos SET dia = "+request.getParameter("nuevodia")+" WHERE idevento = "+request.getParameter("idevento")+"");
				
				stmt.close();
				conn.close();
			} catch(Exception e) {
				out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
			}
		%>
	</body>
</html>