# Xử lý get record by type CloudKit trong scope Public ( K cần dùng tài khoản iCloud trên thiết bị, Phải dùng với database Production )

# Import: 
```Dart
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';
```

# Code:
```Dart
FlutterCloudKit cloudKit = FlutterCloudKit(containerId: "iCloud.com.hantum.ticoe");
  final databaseScope = CloudKitDatabaseScope.public;
  List<String> fetchedRecordsText = [];

  Future<void> getDataFromCloudKit() async {

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
    // else if (access == "3"){
    //   Future.delayed(Duration(seconds: 1),(){
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen(initialUrl: url)));
    //   });
    // }
    else {
      Future.delayed(Duration(seconds: 1), () {
        // Change to Home View
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GameScreen()));
            });
    }
  }
```



# Note Fix lib flutter_cloud_kit: ^0.0.3
 
# Tìm function getDatabaseFromArgs trong Xcode
 
# File FlutterInteropUtils

# Hàm getDatabaseFromArgs sửa thành 

```Dart
func getDatabaseFromArgs(arguments: Dictionary<String, Any>) -> CKDatabase? {
    let container = getContainerFromArgsOrDefault(arguments: arguments);
    if let databaseScope = arguments["databaseScope"] as? String {
        if databaseScope == "private" {
            return container.privateCloudDatabase;
        }
        else if databaseScope == "public" {
            return container.publicCloudDatabase;
        }
        else {
            // not supported
            return nil
        }
    } else {
        return nil
    }
}
```

# Or add lib by Resource Folder:
Copy Resource to Root Source Code


flutter_cloud_kit:
    path: ./flutter_cloud_kit




