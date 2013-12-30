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

        if ("addpriceitem".equals(request.getParameter("action"))) {
            String[] sponsorids = request.getParameterValues("sponsor_id[]") == null ? null : request.getParameterValues("sponsor_id[]");
            String[] prices = request.getParameterValues("price[]") == null ? null : request.getParameterValues("price[]");
            String[] labitems = request.getParameterValues("labitems[]") == null ? null : request.getParameterValues("labitems[]");
            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            SponsorLabitemPrice sponsorLabitemPrice = null;
            if ((sponsorids != null && sponsorids.length > 0)) {
                for (int i = 0; i < sponsorids.length; i++) {
                    try {
                        mgr.deletePriceList(sponsorids[i]);

                    } catch (NullPointerException ex) {
                        continue;
                    }
                }
            }
            if (sponsorids != null && prices != null && labitems != null) {
                for (int i = 0; i < sponsorids.length; i++) {
                    sponsorLabitemPrice = mgr.addSponsorPrice(sponsorids[i], Double.parseDouble(prices[i]), Integer.parseInt(labitems[i]));
                }
            }
            //sponsorLabitemPrice = mgr.addSponsorPrice(sponsorid, price) ;
            session.setAttribute("lasterror", "Prices added successfully");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../labpricesetup.jsp");
            //out.print("Consulting Room Added Successfully");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("Consultation room could not be added please try again");
        return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>