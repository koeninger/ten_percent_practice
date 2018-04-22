package com.erickudler.ghost.data;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by ekudler on 4/9/18.
 */

public class GhostDbHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "ghost.db";
    private static final int DATABASE_VERSION = 7;

    public GhostDbHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        final String SQL_CREATE_TIMER_TABLE = "CREATE TABLE " + GhostContract.TimerEntry.TABLE_NAME + " (" +
                GhostContract.TimerEntry._ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                GhostContract.TimerEntry.COLUMN_NAME + " TEXT NOT NULL, " +
                GhostContract.TimerEntry.COLUMN_BEST_TIME + " INTEGER NOT NULL, " +
                GhostContract.TimerEntry.COLUMN_NUM_OF_STEPS + " INTEGER NOT NULL, " +
                GhostContract.TimerEntry.COLUMN_TIMESTAMP + " TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ");";
        db.execSQL(SQL_CREATE_TIMER_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + GhostContract.TimerEntry.TABLE_NAME);
        onCreate(sqLiteDatabase);
    }
}
