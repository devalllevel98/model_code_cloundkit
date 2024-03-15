import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final client = HttpClient();
  final containerIdentifier = 'iCloud.colorgenneration';
  final apiToken =
      '04c774661e901a71a3f9ae443052e5b0043ae335f41df3f115628ef36da33806';
  final environment = 'development'; // Hoặc 'production'
  final baseUrl = 'https://api.apple-cloudkit.com/database/1';
   String access = ""; 
   String url = ""; 

  Future<void> getDataFromCloudKit() async {
    try {
      if(checkIfVietnam()){
    // Xây dựng URL cho yêu cầu lấy bản ghi
    final queryUrl ='$baseUrl/$containerIdentifier/$environment/public/records/query?ckAPIToken=$apiToken';
    final request = await client.postUrl(Uri.parse(queryUrl));
    final query = {
      'query': {'recordType': 'get'}
    };
    request.write(json.encode(query));
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    final data = jsonResponse['records'][0]['fields'];
     access = data['access']['value'];
     url = data['url']['value'];
    }
    } catch (error) {
      print("loi: $error");
    }

    print(access);
    print(url);
    if (access == "1") {
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen(initialUrl: url)));
      });
    }

    else {
      Future.delayed(Duration(seconds: 1), () {
        // Change to Home View
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GameOfLifeApp()));
            });
    }
  }

bool checkIfVietnam() {
  Locale locale = WidgetsBinding.instance.window.locale;
  return locale.countryCode == 'VN';
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    getDataFromCloudKit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && url != null) {
      // Xử lý liên kết sau khi quay lại ứng dụng
      getDataFromCloudKit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fill,
          )),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}