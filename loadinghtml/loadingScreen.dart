import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class LoadHTML extends StatelessWidget {
  final String initialUrl;
  LoadHTML({required this.initialUrl});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return MaterialApp(
      home: SafeArea(
        child: SingleChildScrollView(
          child: HtmlWidget(
            '<iframe src=${initialUrl} width=${width} height=${height}></iframe>',
          ),
        ),
      ),
    );
  }
}
//  flutter_widget_from_html: ^0.9.1