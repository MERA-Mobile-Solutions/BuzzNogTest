package com.mera.testapp;

import android.app.Application;
import android.content.Context;

/**
 * Created by pavsedoy on 9/17/2015.
 */
public class App extends Application {

    private static Context mContext;

    public static Context getContext() {
        return mContext;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this.getApplicationContext();
    }
}
