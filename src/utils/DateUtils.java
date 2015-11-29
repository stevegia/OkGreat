package utils;

import java.time.Duration;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.concurrent.TimeUnit;

/**
 * Created by Daniel on 11/27/2015.
 */
public class DateUtils {

    public static Calendar getStartOfDay(Calendar calendar){
        return getStartOfDay(calendar.getTime());
    }
    public static Calendar getStartOfDay(Date date){
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);

        return calendar;
    }

    public static Calendar getEndOfDay(Calendar calendar){
        return getStartOfDay(calendar.getTime());
    }
    public static Calendar getEndOfDay(Date date){
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);

        return calendar;
    }

    public static double getDurationInHours(Date startDate, Date endDate){
        long millis = endDate.getTime() - startDate.getTime();
        long seconds = millis / 1000;
        long minutes = seconds / 60;
        double hours = minutes / 60.0;
        return hours;
    }

    public static int getNumberOfDaysInRange(Date startDate, Date endDate){
        long millis = endDate.getTime() - startDate.getTime();
        long seconds = millis / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        int days =(int) hours / 24;
        return days;
    }
}
