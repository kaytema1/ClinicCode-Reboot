<%@page import="entities.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<% Users user = (Users) session.getAttribute("staff");
            if(user == null){
                session.setAttribute("lasterror", "Please Login");
                response.sendRedirect("index.jsp");
            } %>
<%    
    HMSHelper mm = new HMSHelper();
    
    String query = request.getParameter("q");
   // mm.removeTrim();
    List diagnosis = mm.listDiagnosisShow("s");
    out.print(diagnosis.size());
    Iterator<Diagnosis> iterator = diagnosis.iterator();
    while (iterator.hasNext()) {
        Diagnosis investigation = (Diagnosis) iterator.next();
   //     System.out.println(investigation);
        out.println(investigation.getDiagnosis());
        System.out.println(investigation.getDiagnosis());
    }
    %>