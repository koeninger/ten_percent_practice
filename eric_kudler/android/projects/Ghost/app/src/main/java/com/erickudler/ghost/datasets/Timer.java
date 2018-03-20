package com.erickudler.ghost.datasets;

/**
 * Created by ekudler on 3/20/18.
 */

public class Timer {
    private String name;
    private int numOfSteps;
    private Duration bestTime;
    public Timer() {
        numOfSteps = (int)(Math.random() * 10);
        bestTime = new Duration();
        bestTime.addMinutes((int)(Math.random() * 30));
        bestTime.addMinutes((int)(Math.random() * 60));
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumOfSteps() {
        return numOfSteps;
    }

    public Duration getBestTime() {
        return bestTime;
    }
}
