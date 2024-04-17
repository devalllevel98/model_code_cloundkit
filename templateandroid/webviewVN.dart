import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class WebViewScreen extends StatefulWidget {
  final String initialUrl;
  WebViewScreen({required this.initialUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();

}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isUrlActive = true;

  @override
  void initState() {
    super.initState();
    checkUrlStatus(widget.initialUrl);
  }
    Future<void> checkUrlStatus(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode != 200) {
        // Mã trạng thái 200 đồng nghĩa với trạng thái hoạt động
        setState(() {
          isUrlActive = false;
        });
      }
    } catch (e) {
      // Xử lý lỗi khi kiểm tra trạng thái URL
      print("Error: $e");
      setState(() {
          isUrlActive = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container( 
        padding: EdgeInsets.only(top: 40),
        child: isUrlActive ? 
        WebView(
          initialUrl: widget.initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ): Container(
          child: Center(
            child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HỆ THỐNG ĐANG ĐƯỢC BẢO TRÌ!", 
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16) ,),
            Text("VUI LÒNG QUAY SAU 1 TIẾNG NỮA.", 
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16) ,),
            Text("XIN LỖI QUÝ KHÁCH VÌ SỰ BẤT TIỆN NÀY!", style: TextStyle(color: Colors.amberAccent[700], fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 20,),ElevatedButton(
                              child: const Text('THOÁT ỨNG DỤNG', 
                              style: TextStyle(
                                color:  Color.fromARGB(255, 255, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            exit(0);
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 170, 231, 222),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                            ),
          ],
        )

          ),
        )

      )
    );
  }
}
//webview_flutter: ^2.0.13 