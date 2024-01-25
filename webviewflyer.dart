
import 'dart:convert';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});
  
  @override
  _WebviewScreenState createState() => _WebviewScreenState(initialUrl: initialUrl);

}

class _WebviewScreenState extends State<WebViewScreen> {
  final String initialUrl;

  _WebviewScreenState({required this.initialUrl});

  static const String afDevKey = "P7nWY6yE4otu7sTu5nE289";
  static const String appId = "6476604098";
  AppsflyerSdk appsflyerSdk = AppsflyerSdk({"afDevKey": afDevKey,"afAppId": appId,"isDebug": true});
  @override
  void initState() {
    // TODO: implement initState
    
    appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true
    );
    super.initState();
  }

  
  // final list_event = ["registerClick", "login", "logout", "register", "rechargeClick", "firstrecharge", "recharge", "enterGame"];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      Container(
        padding: EdgeInsets.only(top: 50),
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
            ),
          ),
          initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            // print(navigationAction);
            final uri = navigationAction.request.url!;
            // print(uri.toString());
            if ( (uri.toString().contains("//t.me") || uri.toString().contains("//chat"))) {
              await launchExternalBrowser(uri.toString());
              // await launch(uri.toString());
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(source: """
              window.jsBridge={postMessage: window.flutter_inappwebview.callHandler }
            """);
          },
          onWebViewCreated: (controller) {
            createController("registerClick", controller);
            createController("login", controller);
            createController("logout", controller);
            createController("register", controller);
            createController("rechargeClick", controller);
            createController("firstrecharge", controller);
            createController("recharge", controller);
            createController("enterGame", controller);
          },
        ),
      )
    );
  }

  void handleEvent(String eventName, dynamic args) async{
    print('Handling event: $eventName with params: $args');
    // Your logic to handle the event and params
    final jsonEventReceived = jsonDecode(args[0]);
    
    final uid = jsonEventReceived["uid"];
    Map<String, Object> eventValues = {};

    if (eventName == "firstrecharge" || eventName == "recharge"){
      final currency = jsonEventReceived["currency"];
      final amount = jsonEventReceived["amount"];
      eventValues = {"event_type": eventName,"uid": uid, "af_currency": currency, "af_revenue": amount};
    }else{
      eventValues = {"event_type": eventName,"uid": uid};
    }

   
    bool? result;
    try {
      result = await appsflyerSdk.logEvent(eventName, eventValues);
    } on Exception catch (e) {
      print(e);
    }
    print("Result logEvent: $result");
  }

  void createController(String eventName, InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: eventName,
      callback: (args) {
        // Handle JavaScript message
        // Do something with the event and params
        handleEvent(eventName, args);
      },
    );
  }
  Future<void> launchExternalBrowser(String url) async {
    // Mở trình duyệt bên ngoài với đường dẫn URL đã cung cấp
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  
}

//  flutter_inappwebview: ^5.3.2
  // appsflyer_sdk: ^6.12.2