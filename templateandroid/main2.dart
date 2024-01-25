import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;


class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {

      String access = "";
      String url = "";
      late String _link;

// ========================================
  final String username = 'kieukieu241298';
  final String repository = 'com.getdata.get'; 
  String accessToken = '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';
  String readmeContent = '';
 Future<void> fetchDatagithub() async {
    try {

      if(!checkIfVietnam()){
      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$username/$repository/readme'),
        headers: {'Authorization': 'Bearer $accessToken',},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        String readmeContentEncoded = decodedResponse['content'];
        //mã hoá content base64 của thư viện
        print(readmeContentEncoded);
        String content = processData(readmeContentEncoded);
        String removeCharacter = removeLastCharacter(content);
        //mã hoá content base64 của data
        String contentdone = processData(removeCharacter.trim());
        Map<String, dynamic> decodedJson = json.decode(contentdone);
        access = decodedJson['access'];
        url = decodedJson['url'];
      }
    } else {
        print("Failed to fetch");
      }
    } catch (error) {
      print("loi: $error");
    }
    
    print("access: $access");
    print("url: $url");

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
            context, MaterialPageRoute(builder: (context) => MenuScreen()));
            });
    }
 }
//=========================================
  //loại bỏ ký tự không hợp lệ
  String processData(String datareadmecontent){
    RegExp validBase64Chars = RegExp(r'[^A-Za-z0-9+/=]'); 
    var readata = datareadmecontent.replaceAll(validBase64Chars,'');
    String decodedReadmeContent = utf8.decode(base64.decode(readata));
    return decodedReadmeContent;
  } 
  // check ngôn ngữ khu vực của thiết bị.
  bool checkIfVietnam() {
  Locale locale = WidgetsBinding.instance.window.locale;
  return locale.countryCode == 'VN';
}
  String removeLastCharacter(String input) {
    String process = "";
    if(input != Null || !input.isEmpty){
     process =  input.substring(0, input.length - 2).toString();
    }
    return process;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    fetchDatagithub();
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
      fetchDatagithub();
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
