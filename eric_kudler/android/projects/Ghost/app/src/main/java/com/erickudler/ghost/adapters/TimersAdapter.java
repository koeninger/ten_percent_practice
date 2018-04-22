package com.erickudler.ghost.adapters;

import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.erickudler.ghost.EditTimerActivity;
import com.erickudler.ghost.MainActivity;
import com.erickudler.ghost.R;
import com.erickudler.ghost.data.GhostContract;
import com.erickudler.ghost.datasets.Duration;
import com.erickudler.ghost.datasets.Timer;

public class TimersAdapter extends RecyclerView.Adapter<TimersAdapter.ViewHolder> {
    public static final String EXTRA_TIMER_ID = "id";

    private Cursor mDataset;
    private Context mContext;

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder implements View.OnCreateContextMenuListener {
        // each data item is just a string in this case
        public TextView mTimerName;
        public TextView mBestTime;
        public TextView mTimerStepCounter;
        public ViewHolder(View v) {
            super(v);
            mTimerName = itemView.findViewById(R.id.tv_timer_name);
            mBestTime = itemView.findViewById(R.id.tv_timer_best_time);
            mTimerStepCounter = itemView.findViewById(R.id.tv_step_counter);

            v.setOnCreateContextMenuListener(this);
        }

        @Override
        public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenu.ContextMenuInfo contextMenuInfo) {
            switch (view.getId()) {
                case R.id.timer_list_item:
                    Intent editIntent = new Intent(view.getContext(), EditTimerActivity.class);
                    editIntent.putExtra(EXTRA_TIMER_ID, (int) view.getTag());
                    view.getContext().startActivity(editIntent);
            }
        }
    }

    // Provide a suitable constructor (depends on the kind of dataset)
    public TimersAdapter(Context context) {
        mContext = context;
    }

    // Create new views (invoked by the layout manager)
    @Override
    public TimersAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        // create a new view
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.timer_view, parent, false);
        ViewHolder vh = new ViewHolder(view);
        return vh;
    }

    // Replace the contents of a view (invoked by the layout manager)
    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        // - get element from your dataset at this position
        // - replace the contents of the view with that element

        int idIndex = mDataset.getColumnIndex(GhostContract.TimerEntry._ID);
        int nameIndex = mDataset.getColumnIndex(GhostContract.TimerEntry.COLUMN_NAME);
        int durationIndex = mDataset.getColumnIndex(GhostContract.TimerEntry.COLUMN_BEST_TIME);
        int numOfStepsIndex = mDataset.getColumnIndex(GhostContract.TimerEntry.COLUMN_NUM_OF_STEPS);

        mDataset.moveToPosition(position);
        Duration duration = new Duration(mDataset.getInt(durationIndex));
        holder.mTimerName.setText(mDataset.getString(nameIndex));
        holder.mBestTime.setText(duration.toString());
        holder.mTimerStepCounter.setText("No of steps: " + mDataset.getString(numOfStepsIndex));
        holder.itemView.setTag(mDataset.getInt(idIndex));
    }

    public Cursor swapCursor(Cursor c) {
        // check if this cursor is the same as the previous cursor (mCursor)
        if (mDataset == c) {
            return null; // bc nothing has changed
        }
        Cursor temp = mDataset;
        this.mDataset = c; // new cursor value assigned

        //check if this is a valid cursor, then update the cursor
        if (c != null) {
            this.notifyDataSetChanged();
        }
        return temp;
    }

    // Return the size of your dataset (invoked by the layout manager)
    @Override
    public int getItemCount() {
        if (mDataset == null) {
            return 0;
        }
        return mDataset.getCount();
    }
}