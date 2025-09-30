package com.cdp.health.calendar;

import java.time.LocalDate;

public class WeekDay {
    private final LocalDate date;
    private final String isoYmd; // yyyy-MM-dd
    private final String labelMd; // M/d
    private final String labelE;  // 요일
    private final boolean today;

    public WeekDay(LocalDate date, String isoYmd, String labelMd, String labelE, boolean today) {
        this.date = date;
        this.isoYmd = isoYmd;
        this.labelMd = labelMd;
        this.labelE = labelE;
        this.today = today;
    }

    public LocalDate getDate() { return date; }
    public String getIsoYmd() { return isoYmd; }
    public String getLabelMd() { return labelMd; }
    public String getLabelE() { return labelE; }
    public boolean isToday() { return today; }
}
