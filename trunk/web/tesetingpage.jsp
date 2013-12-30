<%-- 
    Document   : tesetingpage
    Created on : Jul 31, 2013, 11:19:19 PM
    Author     : emmanueladdo-yirenkyi
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ArrayList<Integer> permissions = (ArrayList<Integer>) session.getAttribute("staffPermission");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            DateFormat formatter, formatter1;
            formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            formatter = new SimpleDateFormat("yyyy-MM-dd");

            Date date, date1;
            date1 = new Date();
            String strDate = formatter1.format(date1);
            date1 = formatter1.parse(strDate);
            out.print(date1);
        %>
    </body>
</html>
