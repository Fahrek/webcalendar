<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*"  %>

<html>
	<head>
		<meta charset   ="UTF-8">
		<meta http-equiv="refresh" content="0; url = ../index.jsp">
		
		<title>Crear Evento</title>
	</head>
	
	<body>
		<%-- <%
			out.println("El año recogido es: "        + request.getParameter("anio")       + "<br/>");
			out.println("El mes recogido es: "        + request.getParameter("mes")        + "<br/>");
			out.println("El dia recogido es: "        + request.getParameter("dia")        + "<br/>");
			out.println("El calendario recogido es: " + request.getParameter("calendario") + "<br/>");
			out.println("La hora de inicio es: "      + request.getParameter("hora")       + "<br/>");
			out.println("El minuto de inicio es: "    + request.getParameter("minuto")     + "<br/>");
			out.println("La duracion del evento es: " + request.getParameter("duracion")   + "<br/>");
			out.println("El nombre del evento es: "   + request.getParameter("nombre"));
		%> --%>
		<%
			try
			{
				String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				Connection conn = null;
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(connect, "web", "calendario" );
				
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("INSERT INTO eventos VALUES (NULL, " + request.getParameter("calendario") + ", '" + request.getParameter("nombre") + "', " + request.getParameter("anio") + ", " + request.getParameter("mes") + ", " + request.getParameter("dia") + ", " + request.getParameter("hora") + ", " + request.getParameter("minuto") + ", 0, " + request.getParameter("duracion") + ")");
				
				stmt.close();
				conn.close();
			} catch(Exception e) {
				out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
			}
		%>
	</body>
</html>