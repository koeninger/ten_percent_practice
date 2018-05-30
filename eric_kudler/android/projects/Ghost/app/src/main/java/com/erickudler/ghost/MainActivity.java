package com.erickudler.ghost;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.AsyncTaskLoader;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.erickudler.ghost.adapters.TimersAdapter;
import com.erickudler.ghost.data.GhostContract;
import com.erickudler.ghost.database.AppDatabase;
import com.erickudler.ghost.database.Timer;

import java.util.List;

public class MainActivity extends AppCompatActivity implements
        LoaderManager.LoaderCallbacks<List<Timer>> {

    private AppDatabase mDb;
    private RecyclerView mTimersView;
    private TimersAdapter mTimersAdapter;
    private RecyclerView.LayoutManager mTimersLayoutManager;

    private static final int TIMERS_LOADER_ID = 0;

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

        getSupportLoaderManager().initLoader(TIMERS_LOADER_ID, null, this);
    }

    protected void onResume() {
        super.onResume();

        // re-queries for all tasks
        getSupportLoaderManager().restartLoader(TIMERS_LOADER_ID, null, this);
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

    @Override
    public Loader<List<Timer>> onCreateLoader(int id, Bundle args) {
        return new AsyncTaskLoader<List<Timer>>(this) {

            // Initialize a Cursor, this will hold all the task data
            List<Timer> mTimerData = null;

            // onStartLoading() is called when a loader first starts loading data
            @Override
            protected void onStartLoading() {
                if (mTimerData != null) {
                    // Delivers any previously loaded data immediately
                    deliverResult(mTimerData);
                } else {
                    // Force a new load
                    forceLoad();
                }
            }

            // loadInBackground() performs asynchronous loading of data
            @Override
            public List<Timer> loadInBackground() {
                // Will implement to load data

                // Query and load all task data in the background; sort by priority
                // [Hint] use a try/catch block to catch any errors in loading data

                try {
                    return mDb.timerDao().loadAllTimers();

                } catch (Exception e) {
                    Log.e("com.erickudler.ghost", "Failed to asynchronously load data.");
                    e.printStackTrace();
                    return null;
                }
            }

            // deliverResult sends the result of the load, a Cursor, to the registered listener
            public void deliverResult(List<Timer> data) {
                mTimerData = data;
                super.deliverResult(data);
            }
        };
    }

    @Override
    public void onLoadFinished(Loader<List<Timer>> loader, List<Timer> data) {
        mTimersAdapter.setTimers(data);
    }

    @Override
    public void onLoaderReset(Loader<List<Timer>> loader) {
        mTimersAdapter.setTimers(null);
    }
}
