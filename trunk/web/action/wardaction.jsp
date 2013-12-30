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

        if ("addward".equals(request.getParameter("action"))) {
            String wardName = null;
            double numberOfBeds = 0.0;

            try {
                wardName = request.getParameter("name");
                numberOfBeds = Double.parseDouble(request.getParameter("beds"));
            } catch (NumberFormatException e) {
                out.print("Bed number cannot be a string");

                response.sendRedirect("index.jsp");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Ward ward = null;
            ward = mgr.addWard(wardName, numberOfBeds);
            session.setAttribute("lasterror", "Ward Successfully Added");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addward.jsp");
            out.print("Ward Successfully Added");
            return;
        }
        if ("editward".equals(request.getParameter("action"))) {
            String wardName = null;
            int wardid = 0;
            //int numberOfBeds = -1;
            //int wardid = numberOfBeds - 1;
            //int occupied = numberOfBeds - 1;
            double cost = 0.0;
            try {
                wardName = request.getParameter("uname");

                //numberOfBeds = Integer.parseInt(request.getParameter("beds"));
                wardid = Integer.parseInt(request.getParameter("uid"));
                //occupied = Integer.parseInt(request.getParameter("occupied"));
                cost = Double.parseDouble(request.getParameter("cost"));
                System.out.println(wardName + " | " + cost + " | " + wardid);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.print("Bed number cannot be a string 1");
                return;

            } catch (NullPointerException e) {
                e.printStackTrace();

                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Ward ward = null;
            ward = mgr.updateWardInfo(wardid, wardName, cost);
            session.setAttribute("lasterror", "Ward Successfully Edited");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addward.jsp");
            out.print("Ward Successfully Edited");
            return;
        }
        if ("delete".equals(request.getParameter("action"))) {

            int wardid = -1;

            try {

                wardid = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Ward ward = null;
            ward = mgr.deleteWard(wardid);
            session.setAttribute("lasterror", "Ward Successfully Deleted");
            session.setAttribute("class", "alert-success");
            out.print("Ward Successfully Deleted");
            return;
        }

        if ("addbed".equals(request.getParameter("action"))) {
            String wardName = null;
            String type = null;

            try {
                wardName = request.getParameter("name");
                type = request.getParameter("beds");

            } catch (NumberFormatException e) {
                out.print("Bed number cannot be a string");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Bed ward = null;

            String[] roomward = type.split("_");
            int wardorroom = Integer.parseInt(roomward[1]);
            if (roomward[0].equalsIgnoreCase("room")) {
                ward = mgr.addBed(wardName, type, 0 ,wardorroom );

            } else{
                ward = mgr.addBed(wardName, type, wardorroom, 0 );
            }
            
            if (roomward[0].equalsIgnoreCase("ward")) {
                mgr.updateNumberofBed(Integer.parseInt(roomward[1]));
            }
            if (roomward[0].equalsIgnoreCase("room")) {
                mgr.updateNumberofBed(Integer.parseInt(roomward[1]));
                mgr.updateNumberofRoomBed(Integer.parseInt(roomward[1]));
            }
            session.setAttribute("lasterror", "Bed Successfully Added");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addbed.jsp");
            out.print("Bed successfully Added");
            return;
        }
        if ("editbed".equals(request.getParameter("action"))) {
            String bedname = null;
            int bedid = -1;
            String wardRoom = null;
            boolean occupied = Boolean.FALSE;
            double cost = 0.0;
            try {

                bedname = request.getParameter("uname");
                wardRoom = request.getParameter("wardRoom");
                bedid = Integer.parseInt(request.getParameter("uid"));

                System.out.println(occupied + " +++++++++++++++++++++++++++++++++++++");

            } catch (NumberFormatException e) {
                out.print("Bed number cannot be a string");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Bed ward = null;
            
            String[] roomward = wardRoom.split("_");
            int wardorroom = Integer.parseInt(roomward[1]);
            if (roomward[0].equalsIgnoreCase("room")) {
                ward = mgr.updateBed(bedid, bedname, wardRoom , 0 ,wardorroom );

            } else{
                ward = mgr.updateBed(bedid, bedname, wardRoom , wardorroom, 0 );
            }
           
            session.setAttribute("lasterror", "Bed Successfully Edited");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addbed.jsp");

            out.print("Bed Successfully Edited");
            return;
        }
        if ("deletebed".equals(request.getParameter("action"))) {

            int wardid = -1;

            try {

                wardid = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Bed ward = null;
            ward = mgr.deleteBed(wardid);
            session.setAttribute("lasterror", "Bed Successfully Deleted");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addbed.jsp");
            out.print("Bed Successfully Added");
            return;
        }
        if ("addroom".equals(request.getParameter("action"))) {
            String name = null;
            int ward = 0;
            double cost = 0.0;

            try {
                ward = Integer.parseInt(request.getParameter("ward"));
                cost = Double.parseDouble(request.getParameter("cost"));
                name = request.getParameter("name");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.print("Bed number cannot be a string");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Room room = null;
            room = mgr.addRoom(name, ward, cost);
            session.setAttribute("lasterror", "Room Successfully Added");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addroom.jsp");

            out.print("Bed successfully Added");
            return;
        }
        if ("editroom".equals(request.getParameter("action"))) {
            String roomname = null;
            int roomid = -1;
            int ward = -1;
            // boolean occupied = Boolean.FALSE;
            double cost = 0.0;
            try {

                roomname = request.getParameter("uname");
                ward = Integer.parseInt(request.getParameter("wardRoom"));
                roomid = Integer.parseInt(request.getParameter("uid"));
                cost = Double.parseDouble(request.getParameter("ubeds"));

            } catch (NumberFormatException e) {
                out.print("Bed number cannot be a string");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Room room = null;
            room = mgr.updateRoom(roomid, roomname, ward, cost);
            session.setAttribute("lasterror", "Room Successfully Edited");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addroom.jsp");
            out.print("Room successfully updated");
            return;
        }
        if ("deleteroom".equals(request.getParameter("action"))) {

            int wardid = -1;

            try {

                wardid = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                out.print("There is a problem please try again");
                return;

            } catch (NullPointerException e) {
                out.print("There is a problem please try again");
                return;
            }

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            Room ward = null;
            ward = mgr.deleteRoom(wardid);
            session.setAttribute("lasterror", "Room Successfully Deleted");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../addroom.jsp");
            out.print("Room successfully Added");
            return;
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        response.sendRedirect("../adminpanel.jsp");
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>