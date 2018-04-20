package com.erickudler.ghost;

import android.content.ContentValues;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;

import com.erickudler.ghost.data.GhostContract;

public class EditTimerActivity extends AppCompatActivity {

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

        mTimerName = (EditText) findViewById(R.id.edit_timer_name);
    }

    public void onClickAddTime(View view) {

        ContentValues values = new ContentValues();
        values.put(GhostContract.TimerEntry.COLUMN_NAME, mTimerName.getText().toString());
        values.put(GhostContract.TimerEntry.COLUMN_BEST_TIME, Math.round(Math.random() * 60 * 1000 * 5) );
        values.put(GhostContract.TimerEntry.COLUMN_NUM_OF_STEPS, Math.round(Math.random() * 10 + 1));

        getContentResolver().insert(GhostContract.TimerEntry.CONTENT_URI, values);
        finish(); 
    }
}
