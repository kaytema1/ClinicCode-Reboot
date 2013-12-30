/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import helper.HibernateUtil;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author drac852002
 */
public class TransactionEntityManager extends HMSHelper {

    public TransactionEntityManager() {
        super();
    }

    public Object save(Object location) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.save(location);
        session.getTransaction().commit();
        return location;
    }

    public Object update(Object location) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.update(location);
        session.getTransaction().commit();
        return location;
    }

    public void delete(Object location) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.delete(location);
        session.getTransaction().commit();
        //return location;
    }

    public List listObjects(String object) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List list = session.createQuery(object).list();
        //session.getTransaction().commit(); 
        return list;
    }

    public Object getStringObject(Object object, String id) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Object obj = session.get(object.getClass(), id);
        //session.getTransaction().commit();
        return obj;
    }

    public Object getIntegerObject(Object object, int id) throws Exception {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Object obj = session.get(object.getClass(), id);
        //session.getTransaction().commit();
        return obj;
    }

    public static int getMonthsBetweenDates(Date startDate, Date endDate) {
        if (startDate.getTime() > endDate.getTime()) {
            Date temp = startDate;
            startDate = endDate;
            endDate = temp;
        }
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(startDate);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(endDate);

        int yearDiff = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
        int monthsBetween = endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH) + 12 * yearDiff;

        if (endCalendar.get(Calendar.DAY_OF_MONTH) >= startCalendar.get(Calendar.DAY_OF_MONTH)) {
            monthsBetween = monthsBetween + 1;
        }
        return monthsBetween;

    }
}
