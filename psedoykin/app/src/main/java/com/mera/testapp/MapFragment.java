package com.mera.testapp;


import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

/**
 * A simple {@link Fragment} subclass.
 */
public class MapFragment extends SupportMapFragment implements OnMapReadyCallback {


    public interface MapListener {
        void updateLocation(LatLng latLng);
    }

    public static final String TAG = "MapFragment";
    private static final String LAT_ARG_PARAM = "lat";
    private static final String LNG_ARG_PARAM = "lng";
    private GoogleMap mGoogleMap;
    private LatLng mCurrentLatLng;
    private Button mOkButton;
    private MapListener mMapListener;

    public static MapFragment newInstance(double lat, double lng) {
        MapFragment frg = new MapFragment();
        Bundle args = new Bundle();
        args.putDouble(LAT_ARG_PARAM, lat);
        args.putDouble(LNG_ARG_PARAM, lng);
        frg.setArguments(args);
        return frg;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        mMapListener = (MapListener) activity;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.fragment_map, container, false);

        mOkButton = (Button) view.findViewById(R.id.map_ok_button);

        mOkButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mMapListener != null) {
                    mMapListener.updateLocation(mCurrentLatLng);
                }
            }
        });

        Bundle bundle = this.getArguments();

        if (bundle != null) {
            mCurrentLatLng = new LatLng(bundle.getDouble(LAT_ARG_PARAM), bundle.getDouble(LNG_ARG_PARAM));
        }
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        ((SupportMapFragment) this.getChildFragmentManager().findFragmentById(R.id.mapFragment)).getMapAsync(this);
    }

    @Override
    public void onMapReady(final GoogleMap googleMap) {
        mGoogleMap = googleMap;
        if (mCurrentLatLng != null) {
            updateMarkerPosition();
        }

        mGoogleMap.setOnMapLongClickListener(new GoogleMap.OnMapLongClickListener() {
            @Override
            public void onMapLongClick(LatLng latLng) {
                mCurrentLatLng = latLng;
                updateMarkerPosition();
            }
        });
    }

    private void updateMarkerPosition() {
        if (mCurrentLatLng != null && mGoogleMap != null) {
            MarkerOptions markerOptions = new MarkerOptions();
            markerOptions.position(mCurrentLatLng);
            markerOptions.title(mCurrentLatLng.latitude + " : " + mCurrentLatLng.longitude);
            mGoogleMap.clear();
            mGoogleMap.animateCamera(CameraUpdateFactory.newLatLng(mCurrentLatLng));
            mGoogleMap.addMarker(markerOptions);
        }
    }
}
