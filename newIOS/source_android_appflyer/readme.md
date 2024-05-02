# Add lib
    implementation 'com.android.installreferrer:installreferrer:2.2'
    implementation 'com.squareup.retrofit2:converter-scalars:2.9.0'
    implementation 'com.appsflyer:af-android-sdk:6.12.1'
# Add manifest.xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:usesCleartextTraffic="true"
        tools:replace="android:fullBackupContent"
        />