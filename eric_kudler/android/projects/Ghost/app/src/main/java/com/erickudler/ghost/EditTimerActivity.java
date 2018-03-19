package com.erickudler.ghost;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;

public class EditTimerActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_timer);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar_edit_timer);
        setSupportActionBar(toolbar);
    }
}
