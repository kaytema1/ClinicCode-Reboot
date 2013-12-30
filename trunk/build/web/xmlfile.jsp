<%-- 
    Document   : xmlfile
    Created on : Oct 24, 2012, 9:11:25 AM
    Author     : drac852002
--%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@ page contentType="text/xml" %>

<books>
    <book>
        <name>Padam History</name>
        <author>ZARA</author>
        <price>100</price>
    </book>
    <book>
        <name>Great Mistry</name>
        <author>NUHA</author>
        <price>2000</price>
    </book>
</books>
