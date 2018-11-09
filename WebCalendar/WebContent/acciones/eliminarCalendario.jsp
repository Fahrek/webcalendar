<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*"  %>

<html>
	<head>
		<meta charset = "UTF-8">
		<meta http-equiv = "refresh" content="0; url=../index.jsp">
		<title>Eliminar Evento</title>
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
				stmt.executeUpdate("DELETE FROM calendarios WHERE idcalendario = " + request.getParameter("idcalendario") + "");
				stmt.executeUpdate("DELETE FROM eventos WHERE calendario = "       + request.getParameter("idcalendario") + "");
				
				stmt.close();
				conn.close();
			} catch(Exception e) {
				out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
			}
		%>
	</body>
</html>