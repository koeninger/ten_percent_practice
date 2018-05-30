package com.erickudler.ghost.database;

import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.OnConflictStrategy;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Update;

import java.util.List;

/**
 * Created by ekudler on 5/14/18.
 */

@Dao
public interface TimerDao {

    @Query("SELECT * FROM timers")
    List<Timer> loadAllTimers();

    @Insert
    void insertTimer(Timer timer);

    @Update(onConflict = OnConflictStrategy.REPLACE)
    void updateTimer(Timer timer);

    @Delete
    void deleteTimer(Timer timer);
}
