<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("Forward".equals(request.getParameter("action"))) {
            //String unitName = request.getParameter("conroom");
            String bed = request.getParameter("bed");
            String patient = request.getParameter("patient");
            String patientDetails[] = patient.split("_");
            String patientid = patientDetails[0];
            String id = patientDetails[1];
            int code = 0;
            try {
                code = Integer.parseInt(bed);

            } catch (NumberFormatException o) {
                session.setAttribute("lasterror", "Please select a bed");
                response.sendRedirect("../bedassignment.jsp");
                return;
            }
            // out.print(unitName);

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Bed occupied = mgr.updateBedStatus(code, Boolean.TRUE);
            Ward ward=null;
            if (bed != null) {
                String str = occupied.getWardOrRoom();
                int bedid = Integer.parseInt(str.split("_")[1]);
                if (str.split("_")[0].equals("room")) {
                    Room room = mgr.updateRoomStatus(bedid);
                    ward = mgr.updateWardInfo(room.getWardId());
                    mgr.addPatientBed(Integer.parseInt(id), patientid, code);
                }

                if (str.split("_")[0].equals("ward")) {
                    out.print(str);
                    ward = mgr.updateWardInfo(bedid);
                    mgr.addPatientBed(Integer.parseInt(id), patientid, code);
                }
            }
            mgr.updateFolderLocation((String)session.getAttribute("unit"), ward.getType()+"_"+ward.getWardid(), patientid);
            mgr.updateVisitationStatus(Integer.parseInt(id), ward.getType()+"_"+ward.getWardid(), (String)session.getAttribute("unit"));

        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        session.setAttribute("lasterror", "Admission Accepted");
        session.setAttribute("class", "alert-success");
        response.sendRedirect("../bedassignment.jsp");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>