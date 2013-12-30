<%-- 
    Document   : pdf
    Created on : Oct 23, 2012, 4:23:49 PM
    Author     : drac852002
--%>

<%@page import="java.awt.Color"%>
<%@page import="com.itextpdf.text.Font"%>
<%@page import="com.itextpdf.text.FontFactory"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.PageSize"%>
<%@page import="com.itextpdf.text.Document"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("ITextTest.pdf"));

            document.open();
            document.add(new Paragraph("First page of the document."));

            document.add(new Paragraph("Some more text on the first page with different color and font type."));

//FontFactory.getFont(FontFactory.COURIER, 14, Font.BOLD, new Color(255, 150, 200))));

        %>
        <h1>Hello World!</h1>
        <A HREF="javascript:window.print()">Click to Print This Page</A>
        <SCRIPT LANGUAGE="JavaScript"> 
            if (window.print) {
                document.write('<form><input type=button name=print value="Print" onClick="window.print()"></form>');
            }
        </script>
    </body>
</html>
