<%-- 
    Document   : getPatientDetails
    Created on : Aug 11, 2011, 5:38:12 AM
    Author     : sdot
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.*,helper.HibernateUtil"%>
<%

    HMSHelper mgr = new HMSHelper();
    Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
    sess.beginTransaction();


    String invNumber = request.getParameter("invnumber").toString();
    System.out.println("invNumber.size : " + invNumber);

    if (invNumber != null) {

        int labTypeId = Integer.parseInt(invNumber);
        Investigation detailedInv = null;
        String detInvList = "";

        List mainInvs = mgr.listLabTypeDetailedInv(labTypeId);
        System.out.println("courses.size : " + mainInvs.size());

        for (Iterator iterator = mainInvs.iterator(); iterator.hasNext();) {
            LabtypeDetailedinv detInv = (LabtypeDetailedinv) iterator.next();
            System.out.println("akjdlfajdflkajdflk ::: " + detInv.getDetailedInvId());

            if (detInv != null) {
                detailedInv = mgr.getDetailedInvById(detInv.getDetailedInvId());

             //   if (detailedInv.getRefRangeType().equalsIgnoreCase("non")) {
                    detInvList += detailedInv.getDetailedInvId() + "))" + detailedInv.getName() + "^";
            //    }
            }
     //       System.out.println("detInvList ::: " + detInvList);
        }

        try {
            detInvList = "$" + (detInvList.substring(0, detInvList.length() - 1)).trim();
            System.out.println("detInvList : " + detInvList);
            out.write(detInvList);
        } catch (Exception e) {
        //     e.printStackTrace();
            out.write("djaldjfakfalkdjfalkdjflajkdfalkflka");
        }
    } else {%>
<jsp:forward page="addsubinv.jsp"/>
<% }%>

