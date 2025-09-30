package com.cdp.health.calendar;

import java.time.LocalDate;
import java.util.List;

public class WeekView {
    private LocalDate monday;
    private LocalDate sunday;
    private LocalDate prevWeek;
    private LocalDate nextWeek;
    private List<WeekDay> days;

    public static Builder builder() { return new Builder(); }

    public static class Builder {
        private final WeekView v = new WeekView();
        public Builder monday(LocalDate d){ v.monday=d; return this; }
        public Builder sunday(LocalDate d){ v.sunday=d; return this; }
        public Builder prevWeek(LocalDate d){ v.prevWeek=d; return this; }
        public Builder nextWeek(LocalDate d){ v.nextWeek=d; return this; }
        public Builder days(List<WeekDay> ds){ v.days=ds; return this; }
        public WeekView build(){ return v; }
    }

    // getters
    public LocalDate getMonday(){ return monday; }
    public LocalDate getSunday(){ return sunday; }
    public LocalDate getPrevWeek(){ return prevWeek; }
    public LocalDate getNextWeek(){ return nextWeek; }
    public List<WeekDay> getDays(){ return days; }
}
