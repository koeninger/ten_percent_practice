package com.erickudler.ghost.database;

import android.arch.lifecycle.LiveData;
import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.OnConflictStrategy;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Update;

import com.erickudler.ghost.database.entity.Step;
import com.erickudler.ghost.database.entity.Timer;
import com.erickudler.ghost.database.relation.TimerWithSteps;

import java.util.List;

@Dao
public interface StepDao {
    @Query("SELECT * FROM steps")
    LiveData<List<Step>> loadAllSteps();

    @Insert
    void insertStep(Step step);

    @Update(onConflict = OnConflictStrategy.REPLACE)
    void updateStep(Step step);

    @Delete
    void deleteStep(Step step);

}
