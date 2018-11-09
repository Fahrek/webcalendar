<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String usuario  = request.getParameter("usuario");
		String password = request.getParameter("password");
		int logueado = 0;
		
		try {
			String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			Connection conn = null;
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance(); //com.mysql.jdbc.Driver
			conn = DriverManager.getConnection(connect, "web", "calendario" );
			
			Statement stmt = conn.createStatement();
			ResultSet rset;
			
			String query = "SELECT * FROM usuarios WHERE usuario = '" + usuario + "' AND contrasena = '" + password + "'";
			rset = stmt.executeQuery(query);
			
			while(rset.next())
			{
				logueado = 1;
				session.setAttribute("idusuario", rset.getInt("idusuario"));
			}
			
			if(logueado == 1){
				session.setAttribute("usuario", usuario);
				out.println("<meta http-equiv=refresh content='0; url=../index.jsp'>");
			} else {
				out.println("<meta http-equiv=refresh content='0; url=../login.jsp'>");
			}
			
			stmt.close();
			conn.close();
		} catch(Exception e) {
			out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
		}
	%>
</body>
</html>