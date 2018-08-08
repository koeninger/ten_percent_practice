package com.erickudler.ghost.database.viewmodels;

import android.app.Application;
import android.arch.lifecycle.AndroidViewModel;
import android.arch.lifecycle.LiveData;

import com.erickudler.ghost.database.entity.Timer;
import com.erickudler.ghost.database.accessors.AppDatabase;

import java.util.List;

/**
 * Created by ekudler on 5/30/18.
 */

public class MainViewModel extends AndroidViewModel {

    // Constant for logging
    private static final String TAG = MainViewModel.class.getSimpleName();

    private LiveData<List<Timer>> tasks;

    public MainViewModel(Application application) {
        super(application);
        AppDatabase database = AppDatabase.getInstance(this.getApplication());
        tasks = database.timerDao().loadAllTimers();
    }

    public LiveData<List<Timer>> getTimers() {
        return tasks;
    }
}
