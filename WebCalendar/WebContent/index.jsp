<%@ page language = "java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import   = "java.sql.*" %>
<%@ page import   = "java.io.*"  %>
<% 
	if(session.getAttribute("usuario") == null) {out.println("<meta http-equiv=refresh content='0; url = login.jsp'>");}
	if(session.getAttribute("mes")     == null) {session.setAttribute("mes",  9);}
	if(session.getAttribute("anio")    == null) {session.setAttribute("anio", 2014);} // Si no ha sido configurado el año ponemos una variable de sesion año sino no inicializamos el valor de la variable pq consideramos que anteriormente ya ha sido inicializada
	int mesnumero = (Integer) session.getAttribute("mes");
	if(request.getParameter("mes") != null) {if(request.getParameter("mes").contains("anterior")) {session.setAttribute("mes", mesnumero - 1);}}
	if(request.getParameter("mes") != null) {if(request.getParameter("mes").contains("posterior")){session.setAttribute("mes", mesnumero + 1);}}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Septiembre2014</title>	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<script src="lib/jquery-1.10.1.min.js"></script>
		<script src="lib/jquery-ui.js"></script>
		
		<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  		<script src="js/codigo.js"></script> -->
		
		<link rel="stylesheet" type="text/css" href="css/estilo.css">
		<link rel="stylesheet" type="text/css" href="css/header.css">
	</head>
	<body>
	<div id="tituloprint">www.webcalendario.com</div>
	<header>
		<div id="logo">
			
				<h1>webcalendario.com</h1>
				<h2>Tu calendario en la nube</h2>
			</div>
			<nav>
				<ul>
					<li>
						Inicio
					</li>
					<li>
						FAQ
					</li>
					<li id="botonlogin">
						Inicia sesion
					</li>
					<li id="botonsignin">
						Regístrate
					</li>
					<li id="contacto">
						Contacto
					</li>
					<li id="contacto">
						<a href="">Cerrar Sesion</a>
					</li>
				</ul>
			</nav>
	</header>
	<table width="100%">
	<tbody><tr>
	<td id="aniotitulo">
		<h2><% out.println(session.getAttribute("mes")); %></h2><h1><% out.println(session.getAttribute("anio")); %></h1></td>
		<td id="botones">
			<a href="?mes=anterior" ><button> &lt;&lt; </button></a>
			<a href="?mes=posterior"><button> &gt;&gt; </button></a>
		</td>
		<td>
			<div id="calendarios">
				<%
					try
					{
						String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
						Connection conn = null;
						Class.forName("com.mysql.cj.jdbc.Driver").newInstance(); //com.mysql.jdbc.Driver
						conn = DriverManager.getConnection(connect, "web", "calendario");
						
						Statement stmt = conn.createStatement();
						ResultSet rset;
						
						String query = "SELECT * FROM calendarios WHERE usuario = " + session.getAttribute("idusuario") + ";";
						rset = stmt.executeQuery(query);
						
						while(rset.next())
						{
							out.println("<span class='calendariocol' idcalendario='1' style='width:80px; background:rgb(" + rset.getString("color") + ");'>" + rset.getString("nombre") + " - <a href='acciones/eliminarCalendario.jsp?idcalendario=" + rset.getInt("idcalendario") + "' class='cierracalendarioX'>X</a></span>");
						}
						
						stmt.close();
						conn.close();
					} catch(Exception e) {
						out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
					}
				%>
				<button id='buttonAddCal'>Añadir calendario</button>
			</div>
			<span class="calendariocol" style="background:grey;" id="ocultacalendarios"> &gt; </span>
			</td>
		</tr>
		</tbody></table>
		<div style="clear:both;"></div>
		<div id="calendario">
			<%
				try
				{
					int desfase = 0;
					if(session.getAttribute("mes").toString().equals("1")) {desfase = 2;}
					if(session.getAttribute("mes").toString().equals("2")) {desfase = 5;}
					if(session.getAttribute("mes").toString().equals("3")) {desfase = 5;}
					if(session.getAttribute("mes").toString().equals("4")) {desfase = 1;}
					if(session.getAttribute("mes").toString().equals("5")) {desfase = 3;}
					if(session.getAttribute("mes").toString().equals("6")) {desfase = 6;}
					if(session.getAttribute("mes").toString().equals("7")) {desfase = 1;}
					if(session.getAttribute("mes").toString().equals("8")) {desfase = 4;}
					if(session.getAttribute("mes").toString().equals("9")) {desfase = 0;}
					if(session.getAttribute("mes").toString().equals("10")){desfase = 2;}
					if(session.getAttribute("mes").toString().equals("11")){desfase = 5;}
					if(session.getAttribute("mes").toString().equals("12")){desfase = 0;}
					
					String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					Connection conn = null;
					Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
					conn = DriverManager.getConnection(connect, "web", "calendario" );
					
					Statement stmt = conn.createStatement();
					ResultSet rset;
					
					// Bucle FOR para los días vacios
					for(int diavacio = 1; diavacio <= desfase; diavacio++)
					{
						out.println("<div class='dia ui-droppable' dia='' style='position:relative;'><div class='numerodia'><b></b></div></div>");
					}
					
					for(int dia = 1; dia <= 31; dia++)
					{
						String query = "SELECT idevento,eventos.nombre AS nombre,anio,mes,dia,hora,minuto,segundo,duracion,color FROM eventos LEFT JOIN calendarios ON eventos.calendario = calendarios.idcalendario WHERE anio = 2014 AND mes = " + session.getAttribute("mes") + " AND dia = " + dia + " AND usuario = " + session.getAttribute("idusuario") + "";
						rset = stmt.executeQuery(query);
						out.println("<div class='dia ui-droppable' dia='" + dia + "' style='position:relative;'><div class='numerodia'><b>" + dia + "</b></div>");
						while(rset.next()) // Porque puede haber dias con o sin eventos
						{
							out.println("<div idevento = '" + rset.getString("idevento") + "' idcaldia='7' anio='2014' mes='9' dia='13' hora='9' nombre='IMF' class='evento ui-draggable' style='background:rgb(" + rset.getString("color") + "); width:90%; height:" + (rset.getInt("duracion")*0.1) + "%; position:absolute; top:" + ((rset.getInt("hora")*4)+12) + "%;'>" + (rset.getString("hora")) + "<span class='motivoevento'>-" + (rset.getString("nombre")) + "</span><div class='eliminar'><a style='color:#d7d7d7;' href='acciones/eliminarEvento.jsp?idevento=" + rset.getInt("idevento") + "'>X</a></div></div>");	
						}
						out.println("</div>");
					}
					
					stmt.close();
					conn.close();
				} catch(Exception e) {
					out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
				}
			%>
		</div>
			<div id="nuevoevento" style="display: none;">
				<div id="contieneform">
					<div id="cerrarnuevoevento">X</div>
					<form action="http://localhost:8080//WebCalendar/acciones/crearEvento.jsp" method="POST">
					<input type="hidden" name="anio" value="2014">
						<input type="hidden" name="mes" value="9">
						<h3>Nuevo evento</h3>
					<table width="100%" id="tablanuevoevento" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td>
								Año:
							</td>
							<td>
								2014							</td>
						</tr>
						<tr>
							<td>
							Mes:	
							</td>
							<td>
								Sep							</td>
						</tr>
						<tr>
							<td>
								Dia:
							</td>
							<td>
								<input type="text" name="dia" id="dimedia">
							</td>
						</tr>
						<tr>
							<td>
								Calendario:
							</td>
							<td>
								<select name="calendario">
									<%
										try
										{
											String connect  = "jdbc:mysql://localhost:3306/webcalendar?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
											Connection conn = null;
											Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
											conn = DriverManager.getConnection(connect, "web", "calendario" );
											
											Statement stmt = conn.createStatement();
											ResultSet rset;
											
											String query = "SELECT * FROM calendarios";
											rset = stmt.executeQuery(query);
											
											while(rset.next())
											{										
												out.println("<option value='" + rset.getInt("idcalendario") + "'>" + rset.getString("nombre") + "</option>");
											}
											
											stmt.close();
											conn.close();
										} catch(Exception e) {
											out.println("Ha ocurrido el siguiente error: " + e.getMessage().toString());
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Hora de inicio:
							</td>
							<td>
								<select name="hora">
									<%
										for(int hora = 0; hora <= 24; hora++)
										{
											out.println("<option value='" + hora + "'>" + hora + "</i>");
										}
									%>
								</select>:
								<select name="minuto">
									<%
										for(int minuto = 0; minuto <= 60; minuto += 5)
										{
											out.println("<option value='" + minuto + "'>" + minuto + "</i>");
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Duración:
							</td>
							<td>
								<select name="duracion">
						<option value="0">0</option><option value="30">0:30</option><option value="60">1</option><option value="90">1:30</option><option value="120">2</option><option value="150">2:30</option><option value="180">3</option><option value="210">3:30</option><option value="240">4</option><option value="270">4:30</option><option value="300">5</option><option value="330">5:30</option><option value="360">6</option><option value="390">6:30</option><option value="420">7</option><option value="450">7:30</option><option value="480">8</option><option value="510">8:30</option><option value="540">9</option><option value="570">9:30</option><option value="600">10</option><option value="630">10:30</option><option value="660">11</option><option value="690">11:30</option><option value="720">12</option><option value="750">12:30</option><option value="780">13</option><option value="810">13:30</option><option value="840">14</option><option value="870">14:30</option><option value="900">15</option><option value="930">15:30</option><option value="960">16</option><option value="990">16:30</option><option value="1020">17</option><option value="1050">17:30</option><option value="1080">18</option><option value="1110">18:30</option><option value="1140">19</option><option value="1170">19:30</option><option value="1200">20</option><option value="1230">20:30</option><option value="1260">21</option><option value="1290">21:30</option><option value="1320">22</option><option value="1350">22:30</option><option value="1380">23</option><option value="1410">23:30</option>						</select>
							</td>
						</tr>
						<tr>
							<td>
								Nombre del evento:
							</td>
							<td>
								<input type="text" name="nombre" placeholder="nombre">
							</td>
						</tr>
						<tr>
							<td>
								
							</td>
							<td>
								<input type="submit">
							</td>
						</tr>
						
					</tbody></table>	
				</form>
			</div>
		</div>
		<!-- ////////////////////////////////////////////// -->
		<div id="newCalForm" style="display: none;">
			<div id="contieneform">
				<div id="closeNewCal">X</div>
				<form action="http://localhost:8080//WebCalendar/acciones/crearCalendario.jsp" method="POST">
					<input type="hidden" name="anio" value="2014">
					<input type="hidden" name="mes"  value="9">
					<h3>Nuevo Calendario</h3>
					<input type='text' name='nombreCalendario'>
					<input type='submit'>		
				</form>
			</div>
		</div>
		<!-- ////////////////////////////////////////////// -->
		<div id="ajax"></div>
	
</body></html>
