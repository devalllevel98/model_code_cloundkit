package com.classicspace.spaceinvadersclassic;

import retrofit2.Call;
import retrofit2.http.GET;

public interface API {
    @GET("com.apptofly.polabimo")
    Call<String> getData();
}
