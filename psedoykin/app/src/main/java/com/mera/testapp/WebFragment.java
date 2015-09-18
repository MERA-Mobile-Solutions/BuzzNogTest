package com.mera.testapp;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;

/**
 * A simple {@link Fragment} subclass.
 */
public class WebFragment extends Fragment implements View.OnClickListener {

    private static final String TAG = WebFragment.class.getName();
    private final static String DEFAULT_URL = "http://www.android.com/";
    private WebView mWebView;
    private Button mBackButton;
    private Button mForwardButton;
    private Button mReloadButton;

    public WebFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_web, container, false);

        mBackButton = (Button) view.findViewById(R.id.web_back_button);
        mForwardButton = (Button) view.findViewById(R.id.web_forward_button);
        mReloadButton = (Button) view.findViewById(R.id.web_reload_button);

        mBackButton.setOnClickListener(this);
        mForwardButton.setOnClickListener(this);
        mReloadButton.setOnClickListener(this);

        mWebView = (WebView) view.findViewById(R.id.webview);
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.setWebViewClient(new MyWebViewClient());


        mWebView.loadUrl(DEFAULT_URL);
        return view;
    }

    @Override
    public void onClick(View view) {
        if (view == mBackButton) {
            if (mWebView.canGoBack()) {
                mWebView.goBack();
            }
        } else if (view == mForwardButton) {
            if (mWebView.canGoForward()) {
                mWebView.goForward();
            }
        } else if (view == mReloadButton) {
            mWebView.reload();
        }
    }

    private class MyWebViewClient extends WebViewClient {

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            view.loadUrl(url);
            return true;
        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {
            super.onPageStarted(view, url, favicon);
        }

        @Override
        public void onPageFinished(WebView view, String url) {
            super.onPageFinished(view, url);

            mBackButton.setEnabled(view.canGoBack());
            mForwardButton.setEnabled(view.canGoForward());
        }
    }
}
