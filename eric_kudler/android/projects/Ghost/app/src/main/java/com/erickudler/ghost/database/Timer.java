package com.erickudler.ghost.database;

import android.arch.persistence.room.ColumnInfo;
import android.arch.persistence.room.Entity;
import android.arch.persistence.room.Ignore;
import android.arch.persistence.room.PrimaryKey;

import com.erickudler.ghost.datasets.Duration;

import java.util.Date;

/**
 * Created by ekudler on 5/14/18.
 */

@Entity(tableName = "task")
public class Timer {

    @PrimaryKey(autoGenerate = true)
    private int id;
    private String name;

    @ColumnInfo(name = "num_of_steps")
    private int numOfSteps;

    @ColumnInfo(name = "best_time")
    private int bestTime;
    private Date timestamp;

    public Timer(int id, String name, int numOfSteps, int bestTime, Date timestamp) {
        this.id = id;
        this.name = name;
        this.numOfSteps = numOfSteps;
        this.bestTime = bestTime;
        this.timestamp = timestamp;
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

    public void setNumOfSteps(int numOfSteps) {
        this.numOfSteps =  numOfSteps;
    }

    public int getBestTime() {
        return bestTime;
    }

    public void setBestTime(int bestTime) {
        this.bestTime =  bestTime;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp =  timestamp;
    }
}
