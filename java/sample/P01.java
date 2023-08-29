import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class P01 {
  public static void main(String[] a) {
    System.out.println(getDaysBetween(Date.valueOf("0000-01-01"),
        Date.valueOf("2023-03-12")));
  }

  public static int getDaysBetween(Date start, Date end) {
    boolean negative = false;
    if (end.before(start)) {
      negative = true;
      Date temp = start;
      start = end;
      end = temp;
    }
    GregorianCalendar cal = new GregorianCalendar();
    cal.setTime(start);
    cal.set(Calendar.HOUR_OF_DAY, 0);
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0);
    cal.set(Calendar.MILLISECOND, 0);
    GregorianCalendar calEnd = new GregorianCalendar();
    calEnd.setTime(end);
    calEnd.set(Calendar.HOUR_OF_DAY, 0);
    calEnd.set(Calendar.MINUTE, 0);
    calEnd.set(Calendar.SECOND, 0);
    calEnd.set(Calendar.MILLISECOND, 0);
    if (cal.get(Calendar.YEAR) == calEnd.get(Calendar.YEAR)) {
      if (negative)
        return (calEnd.get(Calendar.DAY_OF_YEAR) - cal
            .get(Calendar.DAY_OF_YEAR)) * -1;
      return calEnd.get(Calendar.DAY_OF_YEAR)
          - cal.get(Calendar.DAY_OF_YEAR);
    }
    int counter = 0;
    while (calEnd.after(cal)) {
      cal.add(Calendar.DAY_OF_YEAR, 1);
      counter++;
    }
    if (negative)
      return counter * -1;
    return counter;
  }
}
