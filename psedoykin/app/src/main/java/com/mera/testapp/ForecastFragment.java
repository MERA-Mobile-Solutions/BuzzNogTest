package com.mera.testapp;

import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.maps.model.LatLng;
import com.mera.testapp.model.DataPoint;
import com.mera.testapp.model.ForecastResponse;

import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.net.CookieHandler;
import java.net.CookieManager;
import java.net.CookiePolicy;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Locale;

/**
 * A simple {@link Fragment} subclass.
 */
public class ForecastFragment extends Fragment implements View.OnClickListener,
        GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener {

    public static final String TAG = ForecastFragment.class.getName();
    private final static String FORECAST_URL = "https://api.forecast.io/forecast/bd9602f6464348eb3d89eaf5d7e9e8b0/";
    private final static double DEFAULT_LAT = 37.8267;
    private final static double DEFAULT_LNG = -122.423;
    private static final String COMMA = ",";
    private RecyclerView mListView;
    private TextView mTextViewLocation;
    private ForecastAdapter mForecastAdapter;
    private FloatingActionButton mMapFAB;
    private FloatingActionButton mUpdateFAB;
    private DownloadForecastTask mDownloadForecastTask;
    private Location mLastLocation;
    private LatLng mLatLng;
    private GoogleApiClient mGoogleApiClient;
    private ProgressBar mProgressBar;
    private String mCurrentLocation;
    private Mode mCurrentUIMode = Mode.InProgress;
    private boolean mNewLatLng = false;

    public ForecastFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_forecast, container, false);

        mMapFAB = (FloatingActionButton) view.findViewById(R.id.map_fab);
        mUpdateFAB = (FloatingActionButton) view.findViewById(R.id.update_fab);
        mProgressBar = (ProgressBar) view.findViewById(R.id.forecast_progress_bar);
        mTextViewLocation = (TextView) view.findViewById(R.id.forecast_location);

        mMapFAB.setOnClickListener(this);
        mUpdateFAB.setOnClickListener(this);
        mListView = (RecyclerView) view.findViewById(R.id.recycler_view);

        LinearLayoutManager llm = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);
        llm.setSmoothScrollbarEnabled(true);

        mListView.setLayoutManager(llm);

        if (mForecastAdapter == null) {
            mForecastAdapter = new ForecastAdapter();

            mForecastAdapter.setOnItemClickListener(new ForecastAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(View view) {

                    if (isResumed()) {
                        DataPoint dataPoint = mForecastAdapter.getDataPointItem(mListView.getChildAdapterPosition(view));
                        ForecastDetailsFragment fr = ForecastDetailsFragment.newInstance(dataPoint);
                        getActivity().getSupportFragmentManager().beginTransaction()
                                .replace(R.id.base_content_frame, fr, ForecastDetailsFragment.TAG)
                                .addToBackStack(ForecastDetailsFragment.TAG).commitAllowingStateLoss();
                    }
                }
            });
        }

        mListView.setAdapter(mForecastAdapter);
        mListView.setHasFixedSize(false);

        updateUI(mCurrentUIMode);

        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
        if (mNewLatLng) {
            updateForecast();
            mNewLatLng = false;
        }
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        if (mGoogleApiClient == null) {
            mGoogleApiClient = new GoogleApiClient.Builder(getActivity())
                    .addConnectionCallbacks(this)
                    .addOnConnectionFailedListener(this)
                    .addApi(LocationServices.API)
                    .build();

            mGoogleApiClient.connect();
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        if (mGoogleApiClient != null) {
            mGoogleApiClient.disconnect();
        }

        if (mDownloadForecastTask != null) {
            mDownloadForecastTask.cancel(true);
        }

        mListView.setAdapter(null);
        mListView.setLayoutManager(null);
        mMapFAB.setOnClickListener(null);
        mUpdateFAB.setOnClickListener(null);
    }

    @Override
    public void onConnected(Bundle bundle) {
        if (mLastLocation == null) {
            mLastLocation = LocationServices.FusedLocationApi.getLastLocation(mGoogleApiClient);
            updateForecast();
        }
    }

    @Override
    public void onConnectionSuspended(int i) {

    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {
        Log.e(TAG, connectionResult.toString());
    }

    @Override
    public void onClick(View view) {
        if (view == mMapFAB) {

            if (isResumed()) {
                double lat = DEFAULT_LAT;
                double lng = DEFAULT_LNG;
                if (mLatLng != null) {
                    lat = mLatLng.latitude;
                    lng = mLatLng.longitude;
                } else {
                    if (mLastLocation != null) {
                        lat = mLastLocation.getLatitude();
                        lng = mLastLocation.getLongitude();
                    }
                }

                MapFragment fragment = MapFragment.newInstance(lat, lng);
                getActivity().getSupportFragmentManager().beginTransaction()
                        .replace(R.id.base_content_frame, fragment, MapFragment.TAG)
                        .addToBackStack(MapFragment.TAG).commitAllowingStateLoss();
            }
        } else if (view == mUpdateFAB) {
            updateUI(Mode.InProgress);
            updateForecast();
        }
    }

    private void updateUI(Mode mode) {
        switch (mode) {
            case Done:
                mListView.setVisibility(View.VISIBLE);
                mMapFAB.setVisibility(View.VISIBLE);
                mUpdateFAB.setVisibility(View.VISIBLE);
                mProgressBar.setVisibility(View.INVISIBLE);
                if (mCurrentLocation != null && !mCurrentLocation.isEmpty()) {
                    mTextViewLocation.setText(mCurrentLocation);
                }
                break;
            case InProgress:
                mListView.setVisibility(View.INVISIBLE);
                mMapFAB.setVisibility(View.INVISIBLE);
                mUpdateFAB.setVisibility(View.INVISIBLE);
                mProgressBar.setVisibility(View.VISIBLE);
                mTextViewLocation.setText(getString(R.string.loading));
                break;
        }

        mCurrentUIMode = mode;
    }

    private void updateForecast() {
        updateUI(Mode.InProgress);

        double lat = DEFAULT_LAT;
        double lng = DEFAULT_LNG;
        if (mLatLng != null) {
            lat = mLatLng.latitude;
            lng = mLatLng.longitude;
        } else {
            if (mLastLocation != null) {
                lat = mLastLocation.getLatitude();
                lng = mLastLocation.getLongitude();
            }
        }

        String latLngStr = Double.toString(lat).concat(COMMA.concat(Double.toString(lng)));
        mDownloadForecastTask = new DownloadForecastTask();
        mDownloadForecastTask.execute(FORECAST_URL + latLngStr);
    }

    public void setLatLng(LatLng latLng) {
        mLatLng = latLng;
        if (isResumed()) {
            updateForecast();
        } else {
            mNewLatLng = true;
        }
    }

    private enum Mode {InProgress, Done}

    private class DownloadForecastTask extends AsyncTask<String, Void, ForecastResponse> {

        @Override
        protected ForecastResponse doInBackground(String... params) {

            String urlString = params[0]; // URL to call

            InputStream inp = null;
            ForecastResponse response = null;
            HttpURLConnection connection = null;

            try {

                CookieHandler.setDefault(new CookieManager(null, CookiePolicy.ACCEPT_ALL));

                URL url = new URL(urlString);

                connection = (HttpURLConnection) url.openConnection();

                inp = new BufferedInputStream(connection.getInputStream());

                Reader reader = new InputStreamReader(inp);

                StringWriter writer = new StringWriter();

                char[] buffer = new char[1024];

                int count;

                while ((count = reader.read(buffer)) != -1) {
                    writer.write(buffer, 0, count);
                }

                JSONObject obj = new JSONObject(writer.toString().toString());
                response = new ForecastResponse(obj);

                close(inp);
            } catch (Exception e) {
                Log.e(TAG, e.toString());
            } finally {
                if (connection != null) {
                    connection.disconnect();
                }
                close(inp);
            }

            return response;
        }

        @Override
        protected void onPostExecute(ForecastResponse resp) {
            super.onPostExecute(resp);
            if (resp != null) {

                Geocoder geocoder = new Geocoder(getActivity(), Locale.getDefault());
                List<Address> address = null;
                String location;

                try {
                    address = geocoder.getFromLocation(resp.mLatitude, resp.mLongitude, 1);
                } catch (IOException e) {
                    Log.e(TAG, e.toString());
                }

                if (address != null && !address.isEmpty()) {
                    location = address.get(0).getLocality();
                } else {
                    location = resp.getLatLng();
                }

                mCurrentLocation = location;
                mForecastAdapter.setList(resp.mListDataPoint);
            } else {
                mForecastAdapter.setList(null);
                mTextViewLocation.setText(getString(R.string.error));
            }
            updateUI(Mode.Done);
        }

        private void close(Closeable closeable) {
            if (closeable != null) {
                try {
                    closeable.close();
                } catch (RuntimeException e) {
                    throw e;
                } catch (Exception e) {
                    Log.e(TAG, e.toString());
                }
            }
        }
    }
}
