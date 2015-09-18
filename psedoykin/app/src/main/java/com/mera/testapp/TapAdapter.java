package com.mera.testapp;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

/**
 * Created by Pavel on 16.09.2015.
 */
class TapAdapter extends FragmentStatePagerAdapter {

    private final static int FORECAST_POSITION = 0;
    private final static int TAP_COUNT = 2;
    FragmentManager mFragmentManager;

    public TapAdapter(FragmentManager fm) {
        super(fm);
        mFragmentManager = fm;
    }

    @Override
    public Fragment getItem(int position) {

        Fragment fr;
        if (position == FORECAST_POSITION) {
            fr = new ForecastFragment();
        } else {
            fr = new WebFragment();
        }

        return fr;
    }

    @Override
    public int getCount() {
        return TAP_COUNT;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        String title;
        if (position == FORECAST_POSITION) {
            title = App.getContext().getString(R.string.forecast_tab);
        } else {
            title = App.getContext().getString(R.string.web_tab);
        }
        return title;
    }
}