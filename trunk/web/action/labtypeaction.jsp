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
            response.sendRedirect("index.jsp");
        }
        

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        HMSHelper mgr = new HMSHelper();
        ExtendedHMSHelper mg = new  ExtendedHMSHelper();


        if ("activate".equals(request.getParameter("action"))) {

            int activeStatus = Integer.parseInt(request.getParameter("active"));
            int labId = Integer.parseInt(request.getParameter("id"));

            Labtypes lt = null;
            lt = mgr.deactivateLabType(labId, activeStatus);

            if (activeStatus == 0) {
                session.setAttribute("lasterror", "Lab Classification Deactivated Successfully");
                out.print("Lab Classification Deactivated Successfully");
            } else {
                session.setAttribute("lasterror", "Lab Classification Activated Successfully");
                out.print("Lab Classification Activate Successfully");
            }


            response.sendRedirect("../addlabtype.jsp");
            session.setAttribute("class", "alert-success");

            return;
        }
        
        

        if ("ordering".equals(request.getParameter("action"))) {
            String newOrder = request.getParameter("newOrder");
            if (!newOrder.isEmpty()) {
                String splittedIds[] = newOrder.split(",");

                if (splittedIds.length > 0) {

                    int incomingId = 0;
                    String sIncomingId;
                    Labtypes lt;
                    int newOrderNum = 1;

                    for (int k = 0; k < splittedIds.length; k++) {
                        sIncomingId = splittedIds[k];
                        incomingId = Integer.parseInt(sIncomingId);
                        mgr.updateLabTypeOrderNum(incomingId, newOrderNum);

                        newOrderNum++;
                    }
                }

            }

            out.print("Lab Type Successfully Updated");
            response.sendRedirect("../reorderlabclassifications.jsp");
            return;
        }

        if ("mainordering".equals(request.getParameter("action"))) {
            String newOrder = request.getParameter("newOrder");
            String labtype = request.getParameter("labtype");
            
            if (!newOrder.isEmpty()) {
                String splittedIds[] = newOrder.split(",");

                if (splittedIds.length > 0) {

                    int incomingId = 0;
                    String sIncomingId;
                    Labtypes lt;
                    int newOrderNum = 1;

                    for (int k = 0; k < splittedIds.length; k++) {
                        sIncomingId = splittedIds[k];
                        incomingId = Integer.parseInt(sIncomingId);
                        mgr.updateInvOrderNum(incomingId, newOrderNum);

                        newOrderNum++;
                    }
                }

            }

            out.print("Lab Type Successfully Updated");
            if(labtype == null || labtype.isEmpty()) {
                response.sendRedirect("../maininvreorderingbackup.jsp");
            }
            response.sendRedirect("../maininvreorderingbackup.jsp?labtype=" + labtype );
            
            return;
        }

        if ("subordering".equals(request.getParameter("action"))) {
            String newOrder = request.getParameter("newOrder");
            
            if (!newOrder.isEmpty()) {
                String splittedIds[] = newOrder.split(",");

                if (splittedIds.length > 0) {

                    int incomingId = 0;
                    String sIncomingId;
                    Labtypes lt;
                    int newOrderNum = 1;

                    for (int k = 0; k < splittedIds.length; k++) {
                        sIncomingId = splittedIds[k];
                        incomingId = Integer.parseInt(sIncomingId);
                        mgr.updateInvOrderNum(incomingId, newOrderNum);

                        newOrderNum++;
                    }
                }

            }

            response.sendRedirect("../subinvreordering.jsp");
            return;
        }





        if ("units".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");
            String labTypeCode = request.getParameter("code");
            Labtypes unit = null;
            unit = mgr.addLabType(unitName, labTypeCode);
            out.print("Lab Type Successfully Added");
            response.sendRedirect("../addlabtype.jsp");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Lab Classification Saved Successfully");
            return;
        }
        if ("editclassification".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");
            String labTypeCode = request.getParameter("code");
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println(labTypeCode);
            Labtypes unit = null;

            unit = mgr.updateLabType(id, labTypeCode, unitName);
            out.print("Lab Type Successfully Added");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Lab Classification Edited Successfully");
            response.sendRedirect("../addlabtype.jsp");
            return;
        }

        // ---- Start Nezer 30th Dec

        if ("antis".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");

            LabAntibiotic lt = null;
            lt = mgr.addLabAntibiotic(unitName);

            if (lt != null) {
                int unitId = lt.getId();
                mgr.updateLabAntibiotic(unitId, unitId);

                response.sendRedirect("../addlabantibiotic.jsp");
            }

        }
        if ("updateantibiotics".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("name");
            int bioid = Integer.parseInt(request.getParameter("id"));
            mgr.updateLabAntibiotic(bioid, unitName);
            response.sendRedirect("../addlabantibiotic.jsp");
            return;
        }

        // ---- End Nezer 30th Dec



        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");


            mgr.deleteLabType(Integer.parseInt(unitName));
            out.print("Lab Type Successfully Removed");
            return;
        }
        if ("edit".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("uname");
            String id = request.getParameter("uid");

            if (unitName.equalsIgnoreCase("")) {
                out.print("Lab Type Name is empty");
                return;
            }
            //String registrationDate = request.getParameter("dor");

            //   HMSHelper mgr = new HMSHelper();
            Labtypes unit = null;
            //  unit = mgr.updateLabType(Integer.parseInt(id), unitName);
            out.print("Lab Type Successfully Updated");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("There was a problem please try again");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>