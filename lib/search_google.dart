import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';



class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(MaterialApp(home: MyApp(), theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFA7A5A5)),
      debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  final ChromeSafariBrowser browser = new MyChromeSafariBrowser();

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   widget.browser.addMenuItem(new ChromeSafariBrowserMenuItem(
  //       id: 1,
  //       label: 'Custom item menu 1',
  //       action: (url, title) {
  //         print('Custom item menu 1 clicked!');
  //       }));
  //   super.initState();
  // }

  TextEditingController controller=TextEditingController();
  var urlString="";
  launchUrl()
  async {
    String prefix = "https://www.google.com/search?q=";
    urlString=controller.text;
    if(!urlString.startsWith("http://") && !urlString.startsWith("https://")&&
        !urlString.endsWith(".com")  && !urlString.endsWith(".as") &&
        !urlString.endsWith(".uk") && !urlString.endsWith(".biz")&&!urlString.endsWith(".in")|| urlString.contains(" ") )
    {
      urlString=prefix+urlString;
    }
    if(urlString.endsWith(".com") || urlString.endsWith(".as") || urlString.endsWith(".uk") || urlString.endsWith(".biz")||urlString.endsWith(".in") )
    {
      if(!urlString.startsWith("http://") && !urlString.startsWith("https://"))
      {
        urlString = "http://"+urlString;
      }
    }
    await widget.browser.open(
        url: Uri.parse(urlString),
        options: ChromeSafariBrowserClassOptions(
            android: AndroidChromeCustomTabsOptions(
              addDefaultShareMenuItem: false,),
            ios: IOSSafariOptions(barCollapsingEnabled: true)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  TextField(
          autofocus: false,
          controller: controller,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.search,
          onSubmitted: (url)=>launchUrl(),
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border:InputBorder.none,
            hintText: "Search Google Or Enter URL",
            hintStyle: TextStyle(color:Colors.grey),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),

      body:


      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Column(children: <Widget>[


          Row(children: <Widget>[
            Container(
              // padding: EdgeInsets.all(50),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30.0,left:10.0),
              child:
              Text(
                'In Apps',
                style: TextStyle(fontSize: 25),
              ) ,
            ),
          ]),





        ]),


      ),


    );
  }
}
