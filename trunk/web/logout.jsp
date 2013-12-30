<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>

<%

        session.removeAttribute("staff");
        session.setAttribute("lasterror", "Log Out Successful!");
        session.setAttribute("class", "alert-success");
        response.sendRedirect("index.jsp");
        return;
    %>