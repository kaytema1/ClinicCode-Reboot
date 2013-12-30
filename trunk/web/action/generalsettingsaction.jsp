<%--
Document : sponsoraction
Created on : Mar 30, 2012, 11:54:06 PM
Author : Arnold Isaac McSey
--%>
<%@page import="java.util.List"%>
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
            int labReportFooterActive = Integer.parseInt(request.getParameter("lab_report_footer_active"));
            int labReportHeaderActive = Integer.parseInt(request.getParameter("lab_report_header_active"));
            /*String diagnosticsFolderCode = request.getParameter("diagnostics_folder_code");
             int diagnosticsFolderStartNumber = Integer.parseInt(request.getParameter("diagnostics_folder_start_number"));
             */
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++" + facilityName + " " + serviceNumber + " " + telephone + " " + address + " " + eclaimNumber + " " + labReportFooterActive + " " + labReportHeaderActive);

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
            //profile.setLabReportFooterActive(labReportFooterActive);
            //profile.setLabReportHeaderActive(labReportHeaderActive);
            /*/ profile.setDiagnosticsFolderCode(diagnosticsFolderCode);
             profile.setDiagnosticFolderStartNumber(diagnosticsFolderStartNumber); */
            profile = mgr.updateCompanyProfile(profile);
            session.setAttribute("lasterror", "Facility Details Updated Successfully!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../facility_setup.jsp");
            out.print("Deparment Successfully Updated");
            return;
        }

        if ("savePrintSetting".equals(request.getParameter("action"))) {
            boolean saveHeader = true, saveFooter = true;
             ExtendedHMSHelper mgr = new ExtendedHMSHelper();
             
             String labReportHeaderActiveString = request.getParameter("labReportHeaderActiveString") == ""? "Yes" :request.getParameter("labReportHeaderActiveString");
            String labReportFooterActiveString = request.getParameter("labReportFooterActiveString") == ""? "Yes" :request.getParameter("labReportFooterActiveString");
            
            System.out.println("labReportHeaderActiveString : " +  labReportHeaderActiveString);
             System.out.println("labReportFooterActiveString : " +  labReportFooterActiveString);
        
            
            if(labReportHeaderActiveString == null || !labReportHeaderActiveString.trim().equalsIgnoreCase("Yes")) {
                saveHeader = false;
            }
            
             if(labReportFooterActiveString == null || !labReportFooterActiveString.trim().equalsIgnoreCase("Yes")) {
                saveFooter = false;
            }
            
            GeneralSettings setting = mgr.getGeneralSettingByName("lab_report_header_active");
           // List<GeneralSettings> labReportHeaderActiveList = mgr.getGeneralSettingByName("lab_report_header_active");
            GeneralSettings genSettingToSave;
            if(setting == null) {
                genSettingToSave = new GeneralSettings();
                genSettingToSave.setName("lab_report_header_active");
                genSettingToSave.setValue(saveHeader);
                genSettingToSave.setDateAdded(HMSHelper.getCurrentTimestamp());
                genSettingToSave.setStaffId(user.getStaffid());
                
                mgr.addGeneralSetting(genSettingToSave);
                
            } else {
                
                genSettingToSave = setting;
                
                if(genSettingToSave.isValue() != saveHeader) {
                    genSettingToSave.setValue(saveHeader);
                    genSettingToSave.setDateAdded(HMSHelper.getCurrentTimestamp());
                genSettingToSave.setStaffId(user.getStaffid());
                    
                    mgr.updateGeneralSetting(genSettingToSave);
                }
                
            }
            GeneralSettings setting1 = mgr.getGeneralSettingByName("lab_report_footer_active");
            
            GeneralSettings genSettingFooterToSave;
              if(setting1 == null) {
                genSettingFooterToSave = new GeneralSettings();
                genSettingFooterToSave.setName("lab_report_footer_active");
                genSettingFooterToSave.setValue(saveFooter);
                genSettingFooterToSave.setDateAdded(HMSHelper.getCurrentTimestamp());
                genSettingFooterToSave.setStaffId(user.getStaffid());
                
                mgr.addGeneralSetting(genSettingFooterToSave);
            } else {
                
                   genSettingFooterToSave = setting1;
                
                if(genSettingFooterToSave.isValue() != saveFooter) {
                    genSettingFooterToSave.setValue(saveFooter);
                    genSettingFooterToSave.setDateAdded(HMSHelper.getCurrentTimestamp());
                genSettingFooterToSave.setStaffId(user.getStaffid());
                    
                    mgr.updateGeneralSetting(genSettingFooterToSave);
                }
                
            }
            
            session.setAttribute("lasterror", "Printing Setting Saved Successfully!");
            session.setAttribute("class", "alert-success");
            response.sendRedirect("../labprintsettings.jsp");
         //   out.print("Lab Code Successfully Updated");
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

