package com.mera.testapp.model;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by pavsedoy on 9/16/2015.
 */
public class ForecastResponse {

    private static final String COMMA = ",";
    private final static String LAT_NAME = "latitude";
    private final static String LNG_NAME = "longitude";
    private final static String TIME_ZONE_NAME = "timezone";
    private final static String DAILY_NAME = "daily";
    private final static String DATA_NAME = "data";

    public final double mLatitude;

    public final double mLongitude;

    public final String mTimeZone;

    public final List<DataPoint> mListDataPoint = new LinkedList<>();

    public ForecastResponse(JSONObject jsonObj) throws JSONException {

        if (jsonObj.has(LAT_NAME)) {
            mLatitude = jsonObj.getDouble(LAT_NAME);
        } else {
            mLatitude = 0;
        }

        if (jsonObj.has(LNG_NAME)) {
            mLongitude = jsonObj.getDouble(LNG_NAME);
        } else {
            mLongitude = 0;
        }

        if (jsonObj.has(TIME_ZONE_NAME)) {
            mTimeZone = jsonObj.getString(TIME_ZONE_NAME);
        } else {
            mTimeZone = "";
        }

        if (jsonObj.has(DAILY_NAME)) {
            JSONObject daily = jsonObj.getJSONObject(DAILY_NAME);
            if (daily.has(DATA_NAME)) {
                JSONArray dailyArray = daily.getJSONArray(DATA_NAME);
                for (int i = 0; i < dailyArray.length(); i++) {
                    JSONObject dataPoint = dailyArray.getJSONObject(i);
                    mListDataPoint.add(new DataPoint(dataPoint));
                }
            }
        }
    }

    public String getLatLng() {
        return Double.toString(mLatitude).concat(COMMA.concat(Double.toString(mLongitude)));
    }
}