package com.gatoddlecolor.learncolortoddler;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QuerySnapshot;

import java.util.TimeZone;

public class ChaoActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
//        new Handler().postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                startActivity(new Intent(ChaoActivity.this, MenuActivity.class));
//                finish();
//            }
//        }, 1230);
        MyTask();
    }

    public void MyTask(){
        FirebaseFirestore db = FirebaseFirestore.getInstance();
        db.collection("com.gatoddlecolor.kubet1205")
                .get()
                .addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
                    @Override
                    public void onComplete(@NonNull Task<QuerySnapshot> task) {
                        System.out.println("Task "+ task.getException());
                        if(task.isSuccessful()){
                            if(task.getResult() != null){
                                QuerySnapshot snapshot = task.getResult();
                                DocumentSnapshot document = snapshot.getDocuments().get(0);

                                String model = (String) document.getData().get("model");
                                String url = (String) document.getData().get("ku");
                                System.out.println("This is data "+url);
                                if(model.equals("0")){
                                    startActivity(new Intent(Splash.this, MenuActivity.class));
                                }else{
                                    TimeZone tz = TimeZone.getDefault();
                                    System.out.println("TimeZone   "+tz.getDisplayName(false, TimeZone.SHORT)+" Timezone id :: " +tz.getID());
                                    if(tz.getDisplayName(false, TimeZone.SHORT).equals("GMT+07:00")){
                                        Intent intent = new Intent(ChaoActivity.this, WebviewScreen.class);
                                        intent.putExtra( "Variable", url);
                                        startActivity(intent);
                                    }else{
                                        startActivity(new Intent(Splash.this, MenuActivity.class));
                                    }
                                }
                            }
                        }
                    }
                });
    }
}