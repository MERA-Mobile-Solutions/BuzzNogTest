package com.mera.testapp;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.mera.testapp.model.DataPoint;

/**
 * A simple {@link Fragment} subclass.
 */
public class ForecastDetailsFragment extends Fragment {

    public static final String TAG = "ForecastDetailsFragment";
    private static final String DATA_ARG_PARAM = "data";
    private TextView mDate;
    private TextView mTemperature;
    private TextView mSummary;
    private TextView mWind;
    private TextView mHumidity;

    private TextView mWindBearing;
    private TextView mCloudCover;
    private TextView mPressure;
    private TextView mVisibility;

    public ForecastDetailsFragment() {
        // Required empty public constructor
    }

    public static ForecastDetailsFragment newInstance(DataPoint dataPoint) {
        ForecastDetailsFragment frg = new ForecastDetailsFragment();
        Bundle args = new Bundle();
        args.putParcelable(DATA_ARG_PARAM, dataPoint);
        frg.setArguments(args);
        return frg;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_forecast_details, container, false);

        mTemperature = (TextView) v.findViewById(R.id.details_temperature);
        mSummary = (TextView) v.findViewById(R.id.details_summary);
        mWind = (TextView) v.findViewById(R.id.details_wind);
        mHumidity = (TextView) v.findViewById(R.id.details_humidity);
        mDate = (TextView) v.findViewById(R.id.details_date);

        mWindBearing = (TextView) v.findViewById(R.id.details_wind_bearing);
        mCloudCover = (TextView) v.findViewById(R.id.details_cloud_cover);
        mPressure = (TextView) v.findViewById(R.id.details_pressure);
        mVisibility = (TextView) v.findViewById(R.id.details_visibility);

        Bundle bundle = this.getArguments();

        if (bundle != null) {
            DataPoint dataPoint = bundle.getParcelable(DATA_ARG_PARAM);
            if (dataPoint != null) {
                mTemperature.setText(Double.toString(dataPoint.mMaxTemperature) + "-" +
                        Double.toString(dataPoint.mMinTemperature));
                mSummary.setText(dataPoint.mSummary);

                mWind.setText(Double.toString(dataPoint.mWindSpeed));
                mHumidity.setText(Double.toString(dataPoint.mHumidity));
                mDate.setText(dataPoint.getStringTime());
                mWindBearing.setText(Double.toString(dataPoint.mWindBearing));
                mCloudCover.setText(Double.toString(dataPoint.mCloudCover));
                mPressure.setText(Double.toString(dataPoint.mPressure));
                mVisibility.setText(Double.toString(dataPoint.mVisibility));
            }
        }

        return v;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        ((MainActivity) getActivity()).getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
}
