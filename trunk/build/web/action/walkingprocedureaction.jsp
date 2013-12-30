<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();



        if ("addwalkingprocedure".equals(request.getParameter("action"))) {

            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String gender = request.getParameter("gender") == "" ? "N/A" : request.getParameter("gender");
            String procedures[] = request.getParameterValues("procedures");
            String year = request.getParameter("year") == "" ? "0000-" : request.getParameter("year");
            String month = request.getParameter("month") == "" ? "00-" : request.getParameter("month");
            String day = request.getParameter("day") == "" ? "00" : request.getParameter("day");
            
            
            String dob = year + "-" + month + "-" + day;
            
            


            if (procedures != null) {
                double total = 0.0;

                List orders = mgr.listWalkinProcedures();
                int previousNumber = 0;
                String orderid = "13WP1";
                if (orders.size() > 0) {
                    Procedureorderswalkin lastOrder = (Procedureorderswalkin) orders.get(orders.size() - 1);
                    String lastOrderid = lastOrder.getOrderid();
                    String previousNumberString = lastOrderid.substring(4);
                    previousNumber = Integer.parseInt(previousNumberString);
                    int current = previousNumber + 1;
                    orderid  = "13WP" + current;
                }

                for (int index = 0; index < procedures.length; index++) {
                    String sym = procedures[index];
                    String[] syms = sym.split("><");
                    total = total + Double.parseDouble(syms[2]);

                    mgr.addPatientProcedureWalkins(orderid, syms[1], Double.parseDouble(syms[2]));
                }
                Procedureorderswalkin procedureorders = mgr.addProcedureOrder(orderid, firstname, lastname, gender, dob,  total, user.getStaffid());


            }

            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Selected Successfully!");
            response.sendRedirect("../walk-inprocedures.jsp");
            return;
        }
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>