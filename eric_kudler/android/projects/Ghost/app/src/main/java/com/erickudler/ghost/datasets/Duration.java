package com.erickudler.ghost.datasets;

/**
 * Created by ekudler on 3/20/18.
 */

public class Duration  {
    private int milliseconds;
    public Duration() {
        milliseconds = 0;
    }

    public Duration(int milliseconds) {
        this.milliseconds = milliseconds;
    }

    public Duration(int minutes, int seconds, int milliseconds) {
        this.milliseconds = milliseconds;
        this.milliseconds += (seconds * 1000);
        this.milliseconds += (minutes * 1000 * 60);
    }

    public int getMilliseconds() {
        return milliseconds;
    }

    public int getSeconds() {
        return milliseconds / 1000;
    }

    public int getMinutes() {
        return milliseconds / 1000 / 60;
    }

    public void addMinutes(int minutes) {
        milliseconds += minutes * 60 * 1000;
    }

    public void addSeconds(int seconds) {
        milliseconds += seconds * 1000;
    }

    public String toString() {
        int totalSeconds = milliseconds / 1000;
        int minutes = totalSeconds / 60;

        int seconds = (totalSeconds % 60);
        String minutesString = String.format("%02d", minutes);
        String secondsString = String.format("%02d", seconds);
        return minutesString + ":" + secondsString;
    }
}
