 <%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        HMSHelper mgr = new HMSHelper();

        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            session.setAttribute("class", "alert-error");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("addcharacteristic".equals(request.getParameter("action"))) {
            String characteristicOption = null;
            



            try {
                characteristicOption = request.getParameter("name");


            } catch (NullPointerException e) {
                out.print("Question field cannot be empty");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Category Name is Required");
                response.sendRedirect("../addclerkingcategory.jsp");
                return;

            }


            CharacteristicOptions bPartOption = mgr.addCharacteristicOptions(characteristicOption);


            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Characteristic Option Saved Successfully!");
            response.sendRedirect("../addcharacteristicoptions.jsp");
            out.print("Characteristic Option Option Saved Successfully");
            return;
        }
        if ("editcharacteristic".equals(request.getParameter("action"))) {
            String characteristicOption = null;
            int characteristicOptionId = -1;
           
            try {
                characteristicOption = request.getParameter("option");
                characteristicOptionId = Integer.parseInt(request.getParameter("optionId"));
            } catch (NumberFormatException e) {
                out.print("Empty fields not allowed");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addcharacteristicoptions.jsp");
                return;
            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Edit Not Successful");
                response.sendRedirect("../addcharacteristicoptions.jsp");
                return;
            }

            CharacteristicOptions characteristic = null;
            characteristic = mgr.updateCharacteristicOptions(characteristicOptionId, characteristicOption);
            out.print("Category Edited Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Characteristic Option Edited Successfully");
            response.sendRedirect("../addcharacteristicoptions.jsp");
            return;
        }

        if ("deletecharacteristic".equals(request.getParameter("action"))) {

            int characteristicId = 1;

            try {

                characteristicId = Integer.parseInt(request.getParameter("characteristicId"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addcharacteristicoptions.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                session.setAttribute("class", "alert-error");
                session.setAttribute("lasterror", "Delete Not Successful");
                response.sendRedirect("../addcharacteristicoptions.jsp");
                return;
            }




            CharacteristicOptions bPart = null;
            bPart = mgr.deleteCharacteristicOption(characteristicId);
            
            
           
            out.print("Characteristic Option Deleted Successfully");
            session.setAttribute("class", "alert-success");
            session.setAttribute("lasterror", "Characteristic Option Deleted Successfully");
            response.sendRedirect("../addcharacteristicoptions.jsp");
            return;
        }




        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../addcharacteristicoptions.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>