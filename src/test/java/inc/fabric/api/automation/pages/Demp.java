package inc.fabric.api.automation.pages;

import java.time.LocalDate;

public class Demp {

    public static void main(String[] args) {
        String[] date = "2022-01-09T00:00:00.199Z".toString().split("T");
        int day = Integer.parseInt(date[0].split("-")[2]);
        int month = Integer.parseInt(date[0].split("-")[1]);
        int year = Integer.parseInt(date[0].split("-")[0]);
        LocalDate date1 = LocalDate.of(year, month, day);
        System.out.println("adsa");
    }
}
