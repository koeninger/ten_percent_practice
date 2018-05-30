package com.erickudler.ghost.database.viewmodels;

import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.ViewModel;

import com.erickudler.ghost.database.Timer;
import com.erickudler.ghost.database.accessors.AppDatabase;

/**
 * Created by ekudler on 5/30/18.
 */

public class EditTimerViewModel extends ViewModel {

    // COMPLETED (6) Add a task member variable for the TaskEntry object wrapped in a LiveData
    private LiveData<Timer> task;

    // COMPLETED (8) Create a constructor where you call loadTaskById of the taskDao to initialize the tasks variable
    // Note: The constructor should receive the database and the taskId
    public EditTimerViewModel(AppDatabase database, int taskId) {
        task = database.timerDao().loadTimerById(taskId);
    }

    // COMPLETED (7) Create a getter for the task variable
    public LiveData<Timer> getTask() {
        return task;
    }
}
