package com.mera.testapp.model;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.format.DateFormat;

import com.mera.testapp.App;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Date;

/**
 * Created by pavsedoy on 9/16/2015.
 */
public class DataPoint implements Parcelable {

    private final static String TIME_NAME = "time";
    private final static String SUMMARY_NAME = "summary";
    private final static String MIN_TEMP_NAME = "temperatureMin";
    private final static String MAX_TEMP_NAME = "temperatureMax";
    private final static String WIND_SPEED_NAME = "windSpeed";
    private final static String WIND_BEARING_NAME = "windBearing";
    private final static String CLOUD_COVER_NAME = "cloudCover";
    private final static String HUMIDITY_NAME = "humidity";
    private final static String PRESSURE_NAME = "pressure";
    private final static String VISIBILITY_NAME = "visibility";

    public final long mTime;

    public final String mSummary;

    public final double mMinTemperature;

    public final double mMaxTemperature;

    public final double mWindSpeed;

    public final double mWindBearing;

    public final double mHumidity;

    public final double mCloudCover;

    public final double mPressure;

    public final double mVisibility;

    public DataPoint(JSONObject jsonObj) throws JSONException {

        if (jsonObj.has(TIME_NAME)) {
            mTime = jsonObj.getLong(TIME_NAME);
        } else {
            mTime = 0;
        }

        if (jsonObj.has(SUMMARY_NAME)) {
            mSummary = jsonObj.getString(SUMMARY_NAME);
        } else {
            mSummary = "";
        }

        if (jsonObj.has(MIN_TEMP_NAME)) {
            mMinTemperature = jsonObj.getDouble(MIN_TEMP_NAME);
        } else {
            mMinTemperature = 0;
        }

        if (jsonObj.has(MAX_TEMP_NAME)) {
            mMaxTemperature = jsonObj.getDouble(MAX_TEMP_NAME);
        } else {
            mMaxTemperature = 0;
        }

        if (jsonObj.has(WIND_SPEED_NAME)) {
            mWindSpeed = jsonObj.getDouble(WIND_SPEED_NAME);
        } else {
            mWindSpeed = 0;
        }

        if (jsonObj.has(WIND_BEARING_NAME)) {
            mWindBearing = jsonObj.getDouble(WIND_BEARING_NAME);
        } else {
            mWindBearing = 0;
        }

        if (jsonObj.has(CLOUD_COVER_NAME)) {
            mCloudCover = jsonObj.getDouble(CLOUD_COVER_NAME);
        } else {
            mCloudCover = 0;
        }

        if (jsonObj.has(HUMIDITY_NAME)) {
            mHumidity = jsonObj.getDouble(HUMIDITY_NAME);
        } else {
            mHumidity = 0;
        }

        if (jsonObj.has(PRESSURE_NAME)) {
            mPressure = jsonObj.getDouble(PRESSURE_NAME);
        } else {
            mPressure = 0;
        }

        if (jsonObj.has(VISIBILITY_NAME)) {
            mVisibility = jsonObj.getDouble(VISIBILITY_NAME);
        } else {
            mVisibility = 0;
        }
    }

    public String getStringTime() {
        Date date = new Date(mTime * 1000);
        java.text.DateFormat df = DateFormat.getLongDateFormat(App.getContext());
        return df.format(date);
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int i) {
        dest.writeLong(mTime);

        dest.writeString(mSummary);

        dest.writeDouble(mWindSpeed);

        dest.writeDouble(mWindBearing);

        dest.writeDouble(mCloudCover);

        dest.writeDouble(mHumidity);

        dest.writeDouble(mPressure);

        dest.writeDouble(mVisibility);
    }
}
