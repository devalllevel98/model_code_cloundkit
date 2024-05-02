class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  final client = HttpClient();
  final containerIdentifier = 'iCloud.pongcloud';
  final apiToken = '6ab63c15688e9cc3e76fd0cce0c38dccc8b1f6c68826736054bb89dddbada552';
  final environment = 'development'; // Hoặc 'production'
  final baseUrl = 'https://api.apple-cloudkit.com/database/1';
  String? _link;
  
  Future<void> getDataFromCloudKit() async{
    // Xây dựng URL cho yêu cầu lấy bản ghi
    final queryUrl = '$baseUrl/$containerIdentifier/$environment/public/records/query?ckAPIToken=$apiToken';
    // Tạo yêu cầu HTTP POST
    final request = await client.postUrl(Uri.parse(queryUrl));

    // Tạo yêu cầu HTTP POST
    final query = {
      'query': 
        {
          'recordType': 'get'
        }
    };
 
    request.write(json.encode(query));
    // Gửi yêu cầu và đọc phản hồi
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    Map<String,dynamic> jsonResponse = jsonDecode(responseBody);
    final data = jsonResponse['records'][0]['fields'];
    final access = data['access']['value'];
    final url = data['url']['value'];
    print(access);
    print(url);
    if(access == "1"){
     Future.delayed(Duration(seconds: 1),(){
      launch(url, forceSafariVC: false, forceWebView: false);
      setState(() {
        _link = url;
      });
     });
    }else if(access == "2"){
      launch(url);
    }
    else if (access == "3"){
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen(initialUrl: url)));
      });
    }
    
    else{
      Future.delayed(Duration(seconds: 1),(){
        // Change to Home View
        Navigator.pushReplacementNamed(context, "/game-menu");
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
        fit: StackFit.expand,
        children: [
          // Hình ảnh chính giữa màn hình
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            width: 100,
            height: 100,
          ),
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