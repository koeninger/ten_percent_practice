package com.erickudler.ghost.database;

import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.OnConflictStrategy;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Update;

import java.util.List;

/**
 * Created by ekudler on 5/14/18.
 */

public interface TimerDao {

    @Query("SELECT * FROM timers")
    List<Timer> loadAllTasks();

    @Insert
    void insertTask(Timer timer);

    @Update(onConflict = OnConflictStrategy.REPLACE)
    void updateTask(Timer timer);

    @Delete
    void deleteTask(Timer timer);
}
