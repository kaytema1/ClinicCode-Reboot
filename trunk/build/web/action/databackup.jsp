<%-- 
    Document   : sponsoraction
    Created on : Mar 30, 2012, 11:54:06 PM
    Author     : Arnold Isaac McSey
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="entities.*,helper.HibernateUtil" %>
<% try {
       
        HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
        ExtendedHMSHelper mgr = new ExtendedHMSHelper();

        List<DetailedinvPosinvresults> allPossibleResults = mgr.listAllPossibleResults();

        System.out.println("butter allPossibleResults :  " + allPossibleResults.size());

        Set<Integer> resultsSet = new HashSet<Integer>();

        for (DetailedinvPosinvresults dp : allPossibleResults) {
            resultsSet.add(dp.getDetailedinvId());
        }

        System.out.println("butter resultsSet :  " + resultsSet.size());

        Iterator iter = resultsSet.iterator();
        int invId, posResId;
        Investigation inv;
        List individualInvPossibleResults;
        BackUpPossibleInvestigationsResultsMapping bR = null;
        String invName;
        PossibleinvResults pr;
        while (iter.hasNext()) {
         //   System.out.println(iter.next());
            invId = (Integer) iter.next();
            System.out.println("invId : " + invId);
            inv = mgr.getDetailedInvById(invId);
            invName = inv.getName();
            
            for(DetailedinvPosinvresults dp : allPossibleResults) {
                System.out.println("dp.getdetailedinvid : " + dp.getDetailedinvId() + " : " + " invid - " + invId);
                if(dp.getDetailedinvId() == invId) {
                    bR = new BackUpPossibleInvestigationsResultsMapping();
                    bR.setInvId(invId);
                    bR.setInvName(invName);
                    bR.setPossibleResultId(dp.getPosinvresultId());
                    
                    pr = mgr.getPossibleInvResultById(dp.getPosinvresultId());
                    
                    bR.setPossibleResult(pr.getPosinvResult());
                    
                    
                    mgr.addBackUpOfPosInvRes(bR);
                }
            }
            
            
            
        }



    } catch (Exception ex) {
        HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
        if (ServletException.class.isInstance(ex)) {
            throw (ServletException) ex;
        } else {
            throw new ServletException(ex);
        }
    }%>