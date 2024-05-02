package com.classicspace.spaceinvadersclassic;

import android.content.Intent;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.appcompat.app.AppCompatActivity;

import com.appsflyer.AppsFlyerLib;

public class WebviewScreen extends AppCompatActivity {
    WebView myWebView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        getSupportActionBar().hide();
        setContentView(R.layout.activity_webview_screen);
        AppsFlyerLib.getInstance().init("5KdHrUkfV4DdFh5kr3JYS", null, this);
        AppsFlyerLib.getInstance().start(this);
        AppsFlyerLib.getInstance().setDebugLog(true);

        Intent i = getIntent();
        String url = i.getStringExtra("Variable");
//        String url = "https://hi.game/?pid=1023";
//        String url = "https://google.com";
        myWebView = (WebView) findViewById(R.id.webview);
        myWebView.addJavascriptInterface(new WebAppInterface(this), "apkClient");

        myWebView.getSettings().setJavaScriptEnabled(true);
        myWebView.getSettings().setDomStorageEnabled(true);
        myWebView.loadUrl(url);
        myWebView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;

            }
            @Override
            public void onPageFinished(WebView view, String url) {
//                view.loadUrl("javascript:(function() { " +
//                        "document.getElementsByClassName('form-input-btn')[0].addEventListener('click', ()=>{window.apkClient.appsFlyerEvent(JSON.stringify({\"event_type\": \"af_complete_registration\", \"uid\": res.uid, \"pid\": getQueryString('pid')}))    }) })()");
                super.onPageFinished(view, url);
            }
        });
    }

    @Override
    public void onBackPressed() {
        System.out.println("Can go" + myWebView.canGoBack());
        if (myWebView.canGoBack()) {
            myWebView.goBack();
        } else {
            super.onBackPressed();
        }
    }
}

