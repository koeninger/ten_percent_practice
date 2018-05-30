package com.erickudler.ghost;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;

import com.erickudler.ghost.database.accessors.AppDatabase;
import com.erickudler.ghost.database.Timer;

import java.util.Date;

public class EditTimerActivity extends AppCompatActivity {

    private AppDatabase mDb;
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

        mDb = AppDatabase.getInstance(getApplicationContext());

        mTimerName = (EditText) findViewById(R.id.edit_timer_name);
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
