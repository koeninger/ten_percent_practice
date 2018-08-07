package com.erickudler.ghost.database;

import android.arch.lifecycle.LiveData;
import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Embedded;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.OnConflictStrategy;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Relation;
import android.arch.persistence.room.Update;

import com.erickudler.ghost.database.entity.Step;
import com.erickudler.ghost.database.entity.Timer;
import com.erickudler.ghost.database.relation.TimerWithSteps;

import java.util.List;

/**
 * Created by ekudler on 5/14/18.
 */

@Dao
public interface TimerDao {

    @Query("SELECT * FROM timers")
    LiveData<List<Timer>> loadAllTimers();

    @Insert
    void insertTimer(Timer timer);

    @Update(onConflict = OnConflictStrategy.REPLACE)
    void updateTimer(Timer timer);

    @Delete
    void deleteTimer(Timer timer);

    @Query("SELECT * FROM timers WHERE id = :id")
    LiveData<Timer> loadTimerById(int id);

    @Query("SELECT * FROM timers WHERE id = :id")
    LiveData<TimerWithSteps> loadTimerWithStepsById(int id);
}
