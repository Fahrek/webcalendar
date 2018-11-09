<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
	<form method='POST' action='acciones/doLogin.jsp'><br>
		<input type='text' name='usuario'><br>
		<input type='text' name='password'><br>
		<input type='submit'>
	</form>
	<h1>Registro</h1>
	<form method='POST' action='acciones/registrar.jsp'><br>
		<input type='text' name='usuario'   placeholder='usuario'><br>
		<input type='text' name='password'  placeholder='password'><br>
		<input type='text' name='nombre'    placeholder='nombre'><br>
		<input type='text' name='apellidos' placeholder='apellidos'><br>
		<input type='text' name='email'     placeholder='email'><br>
		<input type='submit'>
	</form>
</body>
</html>