package com.mera.testapp;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;

import com.google.android.gms.maps.model.LatLng;

import java.util.List;

public class MainActivity extends AppCompatActivity implements MapFragment.MapListener{

    private TabFragment mTabFragment = new TabFragment();
    private Toolbar mToolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mToolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(mToolbar);
        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction().replace(R.id.base_content_frame, mTabFragment, TabFragment.TAG).commit();
        }
    }

    @Override
    public void updateLocation(LatLng latLng) {

        TabFragment tabFragment = (TabFragment) getSupportFragmentManager().findFragmentByTag(TabFragment.TAG);

        if (tabFragment != null) {

            List<Fragment> listFragment = tabFragment.getChildFragmentManager().getFragments();

            for (Fragment fr : listFragment) {
                if (fr.getClass().equals(ForecastFragment.class)) {
                    if (fr != null) {
                        ((ForecastFragment) fr).setLatLng(latLng);
                    }
                    break;
                }
            }
        }
        getSupportFragmentManager().popBackStack();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                getSupportFragmentManager().popBackStack();
                getSupportActionBar().setDisplayHomeAsUpEnabled(false);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onBackPressed() {
        if (getSupportFragmentManager().getBackStackEntryCount() == 1) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(false);
        }
        super.onBackPressed();
    }
}
