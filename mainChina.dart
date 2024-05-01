import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
FlutterCloudKit cloudKit = FlutterCloudKit(containerId: "iCloud.com.counterappga.gamecounter");
  final databaseScope = CloudKitDatabaseScope.public;
  List<String> fetchedRecordsText = [];
  late String _link; 

  Future<void> getDataFromCloudKit() async {
    // Xây dựng URL cho yêu cầu lấy bản ghi
    List<CloudKitRecord> fetchedRecordsByType = await cloudKit.getRecordsByType(scope: databaseScope, recordType: "get");
    final data = fetchedRecordsByType[0].values;
    final access = data['access'];
    final url = data['url'];
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
    }

    else {
      Future.delayed(Duration(seconds: 1), () {
        // Change to Home View
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyGameApp()));
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
          Positioned.fill(
              child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fill,
          )),
          // Hình ảnh chính giữa màn hình
          // Loading circle nằm dưới màn hình
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
