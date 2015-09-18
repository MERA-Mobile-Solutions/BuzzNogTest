package com.mera.testapp;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.mera.testapp.model.DataPoint;

import java.util.List;

/**
 * Created by pavsedoy on 9/16/2015.
 */
public class ForecastAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    public static final int EMPTY_ITEM = 0;
    public static final int VIEW_ITEM = 1;
    private OnItemClickListener mOnItemClickListener;
    private List<DataPoint> mListDataPoint;

    public void setList(List<DataPoint> list) {
        mListDataPoint = list;
        notifyDataSetChanged();
    }

    public void setOnItemClickListener(OnItemClickListener listener) {
        mOnItemClickListener = listener;
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup viewGroup, int viewType) {

        View v;
        RecyclerView.ViewHolder vh;

        v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.forecast_item, viewGroup, false);
        vh = new HeaderViewHolder(v);

        return vh;
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder viewHolder, int i) {

        HeaderViewHolder vh = (HeaderViewHolder) viewHolder;

        if (mListDataPoint == null || mListDataPoint.isEmpty()) {
            vh.mNoData.setVisibility(View.VISIBLE);
            vh.mLayout.setVisibility(View.GONE);
        } else {
            vh.mTemperature.setText(Double.toString(mListDataPoint.get(i).mMaxTemperature) + "-" +
                    Double.toString(mListDataPoint.get(i).mMinTemperature));
            vh.mSummary.setText(mListDataPoint.get(i).mSummary);
            vh.mWind.setText(Double.toString(mListDataPoint.get(i).mWindSpeed));
            vh.mHumidity.setText(Double.toString(mListDataPoint.get(i).mHumidity));
            vh.mDate.setText(mListDataPoint.get(i).getStringTime());
        }
    }

    @Override
    public int getItemViewType(int position) {
        int returnType = VIEW_ITEM;

        if (mListDataPoint == null || mListDataPoint.isEmpty()) {
            returnType = EMPTY_ITEM;
        }
        return returnType;
    }

    @Override
    public int getItemCount() {
        int count = 1;
        if (mListDataPoint != null) {
            count = mListDataPoint.size();
        }
        return count;
    }

    public DataPoint getDataPointItem(int index) {
        DataPoint dataPoint = null;
        if (mListDataPoint != null && index < mListDataPoint.size()) {
            dataPoint = mListDataPoint.get(index);
        }
        return dataPoint;
    }

    public static interface OnItemClickListener {
        public void onItemClick(View view);
    }

    public class HeaderViewHolder extends RecyclerView.ViewHolder {
        public LinearLayout mLayout;
        public TextView mDate;
        public TextView mNoData;
        public TextView mTemperature;
        public TextView mSummary;
        public TextView mWind;
        public TextView mHumidity;

        public HeaderViewHolder(View v) {
            super(v);
            mLayout = (LinearLayout) v.findViewById(R.id.forecast_layout);
            mNoData = (TextView) v.findViewById(R.id.forecast_no_data);
            mTemperature = (TextView) v.findViewById(R.id.forecast_temperature);
            mSummary = (TextView) v.findViewById(R.id.forecast_summary);
            mWind = (TextView) v.findViewById(R.id.forecast_wind);
            mHumidity = (TextView) v.findViewById(R.id.forecast_humidity);
            mDate = (TextView) v.findViewById(R.id.forecast_date);
            v.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (mOnItemClickListener != null) {
                        mOnItemClickListener.onItemClick(view);
                    }
                }
            });
        }
    }
}
