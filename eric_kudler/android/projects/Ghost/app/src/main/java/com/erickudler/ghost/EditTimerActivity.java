package com.erickudler.ghost;

import android.arch.lifecycle.Observer;
import android.arch.lifecycle.ViewModelProviders;
import android.content.Intent;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;

import com.erickudler.ghost.database.accessors.AppDatabase;
import com.erickudler.ghost.database.entity.Timer;
import com.erickudler.ghost.database.relation.TimerWithSteps;
import com.erickudler.ghost.database.viewmodels.EditTimerViewModel;
import com.erickudler.ghost.database.viewmodels.EditTimerViewModelFactory;

import java.util.Date;

public class EditTimerActivity extends AppCompatActivity {

    public static final String EXTRA_TIMER_ID = "id";
    public static final int DEFAULT_TIMER_ID = 0;

    private AppDatabase mDb;
    private int mTimerId;
    EditText mTimerName;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_timer);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar_edit_timer);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowHomeEnabled(true);
        getSupportActionBar().setDisplayShowTitleEnabled(false);

        mTimerId = DEFAULT_TIMER_ID;

        mDb = AppDatabase.getInstance(getApplicationContext());

        mTimerName = (EditText) findViewById(R.id.edit_timer_name);

        loadTimer();
    }

    public void loadTimer() {
        Intent intent = getIntent();
        if (intent != null && intent.hasExtra(EXTRA_TIMER_ID)) {
            // populate the UI
            mTimerId = intent.getIntExtra(EXTRA_TIMER_ID, DEFAULT_TIMER_ID);

            EditTimerViewModelFactory factory = new EditTimerViewModelFactory(mDb, mTimerId);
            final EditTimerViewModel viewModel = ViewModelProviders.of(this, factory).get(EditTimerViewModel.class);

            viewModel.getTimer().observe(this, new Observer<TimerWithSteps>() {
                @Override
                public void onChanged(@Nullable TimerWithSteps timer) {
                    viewModel.getTimer().removeObserver(this);
                    populateUI(timer);
                }
            });
        }
    }

    public void populateUI(TimerWithSteps timer) {
        mTimerName.setText(timer.getTimer().getName());
    }

    public void onClickAddTime(View view) {
        String name = mTimerName.getText().toString();
        int bestTime = (int)Math.round(Math.random() * 60 * 1000 * 5);
        int numOfSteps = (int)Math.round(Math.random() * 10 + 1);
        Date timestamp = new Date();

        Timer timer = new Timer(name, numOfSteps, bestTime, timestamp);
        mDb.timerDao().insertTimer(timer);

        finish();
    }
}
