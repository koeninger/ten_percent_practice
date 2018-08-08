package com.erickudler.ghost.database.relation;

import android.arch.persistence.room.Embedded;
import android.arch.persistence.room.Relation;

import com.erickudler.ghost.database.entity.Step;
import com.erickudler.ghost.database.entity.Timer;

import java.util.List;

public class TimerWithSteps {
    @Embedded
    private Timer timer;

    @Relation(parentColumn =  "id", entityColumn = "timer_id")
    private List<Step> steps;

    public Timer getTimer() {
        return timer;
    }

    public List<Step> getSteps() {
        return steps;
    }

    public void setTimer(Timer timer) {
        this.timer = timer;
    }

    public void setSteps(List<Step> steps) {
        this.steps = steps;
    }
}
