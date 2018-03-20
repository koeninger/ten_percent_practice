package com.erickudler.ghost.adapters;

import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.erickudler.ghost.R;
import com.erickudler.ghost.datasets.Timer;

public class TimersAdapter extends RecyclerView.Adapter<TimersAdapter.ViewHolder> {
    private Timer[] mDataset;

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder {
        // each data item is just a string in this case
        public TextView mTimerName;
        public TextView mBestTime;
        public ViewHolder(View v) {
            super(v);
            mTimerName = itemView.findViewById(R.id.tv_timer_name);
            mBestTime = itemView.findViewById(R.id.tv_timer_best_time);
        }
    }

    // Provide a suitable constructor (depends on the kind of dataset)
    public TimersAdapter() {
        mDataset = new Timer[3];

        mDataset[0] = new Timer();
        mDataset[0].setName("Getting Up");
        mDataset[1] = new Timer();
        mDataset[1].setName("Driving to Work");
        mDataset[2] = new Timer();
        mDataset[2].setName("Picking up Lunch");

    }

    // Create new views (invoked by the layout manager)
    @Override
    public TimersAdapter.ViewHolder onCreateViewHolder(ViewGroup parent,
                                                   int viewType) {
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
        holder.mTimerName.setText(mDataset[position].getName());
        holder.mBestTime.setText(mDataset[position].getBestTime().toString());
        Log.d("TimersAdapter", mDataset[position].getBestTime().getMinutes() + " " + mDataset[position].getBestTime().getSeconds());
    }

    // Return the size of your dataset (invoked by the layout manager)
    @Override
    public int getItemCount() {
        return mDataset.length;
    }
}