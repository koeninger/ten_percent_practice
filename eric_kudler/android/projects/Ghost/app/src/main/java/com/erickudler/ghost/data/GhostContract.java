package com.erickudler.ghost.data;

import android.provider.BaseColumns;

import com.erickudler.ghost.datasets.Duration;

/**
 * Created by ekudler on 4/9/18.
 */

public class GhostContract  {
    public static final class TimerEntry implements BaseColumns {
        public static final String TABLE_NAME = "timer";
        public static final String COLUMN_NAME = "name";
        public static final String COLUMN_NUM_OF_STEPS = "num_of_steps";
        public static final String COLUMN_TIMESTAMP = "timestamp";
    }
}
