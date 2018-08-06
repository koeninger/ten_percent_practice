package com.erickudler.ghost;

import android.arch.lifecycle.Observer;
import android.arch.lifecycle.ViewModelProviders;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.erickudler.ghost.adapters.TimersAdapter;
import com.erickudler.ghost.database.TimerDao;
import com.erickudler.ghost.database.accessors.AppDatabase;
import com.erickudler.ghost.database.entity.Timer;
import com.erickudler.ghost.database.viewmodels.MainViewModel;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    private AppDatabase mDb;
    private RecyclerView mTimersView;
    private TimersAdapter mTimersAdapter;
    private RecyclerView.LayoutManager mTimersLayoutManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar_main);
        setSupportActionBar(toolbar);

        mDb = AppDatabase.getInstance(getApplicationContext());

        mTimersView = (RecyclerView) findViewById(R.id.rv_timers);
        mTimersView.setHasFixedSize(true);

        mTimersLayoutManager = new LinearLayoutManager(this);
        mTimersView.setLayoutManager(mTimersLayoutManager);

        mTimersAdapter = new TimersAdapter(getApplicationContext());
        mTimersView.setAdapter(mTimersAdapter);


        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent editIntent = new Intent(MainActivity.this, EditTimerActivity.class);
                startActivity(editIntent);
            }
        });

        setupViewModel();
    }

    protected void onResume() {
        super.onResume();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void setupViewModel() {
        MainViewModel viewModel = ViewModelProviders.of(this).get(MainViewModel.class);
        viewModel.getTimers().observe(this, new Observer<List<Timer>>() {
            @Override
            public void onChanged(@Nullable List<Timer> timers) {
                mTimersAdapter.setTimers(timers);
            }
        });
    }
}
