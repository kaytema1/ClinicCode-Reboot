<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users current = (Users) session.getAttribute("staff");
        if (current == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("sponsor".equals(request.getParameter("action"))) {
            String sponsorid = request.getParameter("sponsorid");
            String sponsorName = request.getParameter("sponsorname");
            String sponsorType = request.getParameter("type");
            String sponsorAddress = request.getParameter("address");
            String sponsorContact = request.getParameter("contact");
            String sponsorEmail = request.getParameter("email");



            String treatmentmarkup = "10";
            String labmarkup = "10";
            String treatmentmarkupperc = "10";
            String labmarkupperc = "10";
            
        /*       if (request.getParameter("markupprice") != null  || request.getParameter("markupprice") != "") {
                labmarkup = request.getParameter("markupprice");

            } else {
                System.out.println("labmarkup = "+labmarkup);
                labmarkup = "0";
            }

            if (request.getParameter("treatmentmarkupprice") != null || request.getParameter("treatmentmarkupprice") != "") {
                treatmentmarkup = request.getParameter("treatmentmarkupprice");
            } else {
                treatmentmarkup = "0";
                System.out.println("treatmentmarkup = "+treatmentmarkup);
            }
            
            if (request.getParameter("treatmentpricepercentage") != null || request.getParameter("treatmentpricepercentage") != "") {
                treatmentmarkupperc = request.getParameter("treatmentpricepercentage");

            } else {
                treatmentmarkupperc = "0";
                System.out.println("treatmentmarkupperc = "+treatmentmarkupperc);
            }

            if (request.getParameter("markuppercentage") != null || request.getParameter("markuppercentage") != "") {
                labmarkupperc = request.getParameter("markuppercentage");
            } else {
                labmarkupperc = "0";
                System.out.println("labmarkupperc = "+labmarkupperc);
            }
 */
            double labmark = Double.parseDouble(labmarkup);
            double treatmarkup = Double.parseDouble(treatmentmarkup);
            double labmarkperc = Double.parseDouble(labmarkupperc);
            double treatmarkupperc = Double.parseDouble(treatmentmarkupperc);
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            Sponsorship sp = null;
            sp = mgr.createSponsor(sponsorid, sponsorName, sponsorType, sponsorAddress, sponsorContact, sponsorEmail, labmark, treatmarkup, treatmarkupperc, labmarkperc);
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Sponsor Added Successfully");
        }

        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");
            unitName  =  unitName.trim();
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();

            mgr.deleteSponsor(unitName);
            out.print("Sponsor Successfully Deleted");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Sponsor Deleted Successfully");
            response.sendRedirect("../addsponsor.jsp");
            return;
        }
        if ("edit".equals(request.getParameter("action"))) {
            
            String id = request.getParameter("sponsorid");
            
            String sponsorName = request.getParameter("sponsorname");
            String sponsorType = request.getParameter("type");
            String sponsorAddress = request.getParameter("address");
            String sponsorContact = request.getParameter("contact");
            String sponsorEmail = request.getParameter("email");

         
            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();
            Sponsorship sponsor = null;
           
            sponsor = mgr.updateSponsorInfo(id, sponsorName, sponsorType, sponsorAddress, sponsorContact, sponsorEmail);
            out.print("Sponsor Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Sponsor Edited Successfully");
            response.sendRedirect("../addsponsor.jsp");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addsponsor.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>

