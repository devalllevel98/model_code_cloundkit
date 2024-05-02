package com.classicspace.spaceinvadersclassic;

import android.content.Context;
import android.util.Log;
import android.webkit.JavascriptInterface;

import com.appsflyer.AppsFlyerLib;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class WebAppInterface {
    Context mContext;

    /** Instantiate the interface and set the context */
    WebAppInterface(Context c) {
        mContext = c;
    }

    @JavascriptInterface
    public void appsFlyerEvent(String json)
    {
//        E/appsFlyerEvent: {"event_type":"af_purchase","af_currency":"BRL","af_revenue":5,"uid":"28273706"},
//        I/System.out: eventValue: {af_currency=BRL, uid=28273706, event_type=af_purchase, af_revenue=5}
//        E/appsFlyerEvent: {"event_type":"af_first_purchase","af_currency":"BRL","af_revenue":5,"uid":"28273706"},
        Log.e("appsFlyerEvent",json+",");
        try {
            JSONObject obj = new JSONObject(json);
            String event_type = obj.getString("event_type");
            HashMap<String, Object> eventValue = new HashMap<>();

            eventValue.put("event_type", event_type);
            eventValue.put("uid", obj.getString("uid"));

            if (event_type.equals("af_first_purchase") || event_type.equals("af_purchase")) {
                eventValue.put("af_currency", obj.getString("af_currency"));
                eventValue.put("af_revenue", obj.getInt("af_revenue"));
            }
            System.out.println("eventValue: "+ eventValue);
            AppsFlyerLib.getInstance().logEvent(mContext.getApplicationContext(), event_type,eventValue);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }

    }

}
