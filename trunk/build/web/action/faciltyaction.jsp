<%--
Document : sponsoraction
Created on : Mar 30, 2012, 11:54:06 PM
Author : Arnold Isaac McSey
--%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
        Users user = (Users) session.getAttribute("staff");
        if (user == null) {
            session.setAttribute("lasterror", "Please Login");
            response.sendRedirect("index.jsp");
        }
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();

        if ("updatefacility".equals(request.getParameter("action"))) {
            String facilityName = request.getParameter("facilityname");
            String serviceNumber = request.getParameter("servicenumber");
            String telephone = request.getParameter("telephone");
            String address = request.getParameter("address");
            String eclaimNumber = request.getParameter("eclaimnumber");
            String clinicFolderCode = request.getParameter("clinic_folder_code");
            int clinicFolderStartNumber = Integer.parseInt(request.getParameter("clinic_folder_start_number"));
            
            /*String diagnosticsFolderCode = request.getParameter("diagnostics_folder_code");
             int diagnosticsFolderStartNumber = Integer.parseInt(request.getParameter("diagnostics_folder_start_number"));
             */
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++" + facilityName + " " + serviceNumber + " " + telephone + " " + address + " " + eclaimNumber);

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            CompanyProfile profile = mgr.getProfile("1");

            profile.setComapnyname(facilityName);
            profile.setServicenumber(serviceNumber);
            profile.setTelephone(telephone);
            profile.setAddress(address);
            profile.setEclaimnumber(eclaimNumber);
            profile.setClinicFolderCode(clinicFolderCode);
            profile.setClinicFolderStartNumber(clinicFolderStartNumber);
            
            profile = mgr.updateCompanyProfile(profile);
            session.setAttribute("lasterror", "Facility Details Updated Successfully!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../facility_setup.jsp");
            out.print("Deparment Successfully Updated");
            return;
        }

        if ("updatelab".equals(request.getParameter("action"))) {
           
            String diagnosticsFolderCode = request.getParameter("diagnostics_folder_code");
            int diagnosticsFolderStartNumber = Integer.parseInt(request.getParameter("diagnostics_folder_start_number"));
           

            
            

            //System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++" + labReportFooterActive + " " + labReportHeaderActive);

            //System.out.println("" + facilityName + " " + serviceNumber + " " + telephone + " " + address + " " + eclaimNumber);

            //String registrationDate = request.getParameter("dor");

            ExtendedHMSHelper mgr = new ExtendedHMSHelper();
            CompanyProfile profile = mgr.getProfile("1");

            /* profile.setComapnyname(facilityName);
             profile.setServicenumber(serviceNumber);
             profile.setTelephone(telephone);
             profile.setAddress(address);
             profile.setEclaimnumber(eclaimNumber);
             profile.setClinicFolderCode(clinicFolderCode);
             profile.setClinicFolderStartNumber(clinicFolderStartNumber); */
            profile.setDiagnosticsFolderCode(diagnosticsFolderCode);
            profile.setDiagnosticFolderStartNumber(diagnosticsFolderStartNumber);
            profile.setLabReportFooterActive(false);
            profile.setLabReportHeaderActive(false);
            profile = mgr.updateCompanyProfile(profile);
            //FolderNumbering folderNumbering = mgr.updateDiagnosticCounter(id, counter);
            mgr.initialDiagnosticNumberSetup(1, diagnosticsFolderCode, diagnosticsFolderStartNumber);

            session.setAttribute("lasterror", "Facility Details Updated Successfully!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../lab_setup.jsp");
            out.print("Lab Code Successfully Updated");
            return;
        }

        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction().commit();
        HibernateUtil.getSessionFactory().close();
        out.print("There was a problem please try again");
        session.setAttribute("lasterror", "Facility Details Updated Successfully!");
        session.setAttribute("class", "alert-success");
        //return;
    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>

