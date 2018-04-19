package com.erickudler.ghost.data;

import android.net.Uri;
import android.provider.BaseColumns;

import com.erickudler.ghost.datasets.Duration;

/**
 * Created by ekudler on 4/9/18.
 */

public class GhostContract  {
    public static final String AUTHORITY = "com.erickudler.ghost";
    public static final Uri BASE_CONTENT_URI = Uri.parse("content://" + AUTHORITY);
    public static final String PATH_TIMERS = "timers";

    public static final class TimerEntry implements BaseColumns {
        public static final Uri CONTENT_URI =
                BASE_CONTENT_URI.buildUpon().appendPath(PATH_TIMERS).build();
        public static final String TABLE_NAME = "timers";
        public static final String COLUMN_NAME = "name";
        public static final String COLUMN_NUM_OF_STEPS = "num_of_steps";
        public static final String COLUMN_TIMESTAMP = "timestamp";
    }
}
