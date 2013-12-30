<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }

        System.out.println("+++++++++++++++++++++++++");


        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        double rFee = 0;
        List regFees;
        RegFee rF;
        if ("units".equals(request.getParameter("action"))) {
            String regFee = request.getParameter("regFee");

            try {
                rFee = Double.parseDouble(regFee);
            } catch (Exception e) {
                response.sendRedirect("../addregfee.jsp");
                return;
            }

            HMSHelper mgr = new HMSHelper();
            RegFee unit = null;
            String status = "Yes";
            regFees = mgr.listRegFees();
            
            if(!regFees.isEmpty()){
                for(int k = 0; k < regFees.size(); k++){
                    rF = (RegFee) regFees.get(k);
                    
                    if(rF.getStatus().equals("Yes")){
                        rF.setStatus("No");
                        
                        mgr.updateRegFee(rF.getId(), "No");
                        break;
                    }
                }
            }
            unit = mgr.addRegFee(rFee, user.getStaffid(), new java.sql.Timestamp(new java.util.Date().getTime()), status);
            out.print("Reg Fee Successfully Added");
            response.sendRedirect("../addregfee.jsp");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {
            String unitName = request.getParameter("id");

            //String registrationDate = request.getParameter("dor");

            HMSHelper mgr = new HMSHelper();

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

            HMSHelper mgr = new HMSHelper();
            Labtypes unit = null;
            //unit = mgr.updateLabType(Integer.parseInt(id), unitName);
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