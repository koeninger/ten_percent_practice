package com.erickudler.ghost.database.entity;

import android.arch.persistence.room.ColumnInfo;
import android.arch.persistence.room.Entity;
import android.arch.persistence.room.ForeignKey;
import android.arch.persistence.room.Ignore;
import android.arch.persistence.room.PrimaryKey;

import com.erickudler.ghost.database.entity.Timer;

@Entity(tableName = "steps", foreignKeys = @ForeignKey(entity = Timer.class, parentColumns = "id", childColumns = "timer_id"))
public class Step {
    @PrimaryKey(autoGenerate = true)
    private int id;
    private String name;
    @ColumnInfo(name = "timer_id")
    private int timerId;

    public Step(int id, String name, int timerId) {
        this.id = id;
        this.name = name;
        this.timerId = timerId;

    }

    @Ignore
    public Step(String name, int timerId) {
        this.name = name;
        this.timerId = timerId;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getTimerId() {
        return timerId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTimerId(int timerId) {
        this.timerId = timerId;
    }


}
