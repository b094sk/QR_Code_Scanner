import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myweb2/qrscanner.dart';
import 'package:url_launcher/url_launcher.dart';


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

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/qr.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QRApp()),
                      );
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/moreapps.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      // await widget.browser.open(
                      //     url: Uri.parse("https://play.google.com/store/search?q=pub%3ABAPPA%20SAIKH&c=apps"),
                      //
                      //     options: ChromeSafariBrowserClassOptions(
                      //         android: AndroidChromeCustomTabsOptions(
                      //           addDefaultShareMenuItem: false,
                      //            ),
                      //         ios: IOSSafariOptions(barCollapsingEnabled: true)));
                      launch("https://play.google.com/store/search?q=pub%3ABAPPA%20SAIKH&c=apps" );                     },
                  ),
                ),
              ]),
        ),







        Row(children: <Widget>[
          Container(
            // padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30.0,left:10.0),
            child:
            Text(
              'Search Engines',
              style: TextStyle(fontSize: 25),
            ) ,
          ),
        ]),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/google.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://google.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),




                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/bing.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.bing.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),

                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/yahoo.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.yahoo.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/ask-com.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.ask.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
              ]),
        ),



        Row(children: <Widget>[
          Container(
            // padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30.0,left:10.0),
            child:
            Text(
              'Shopping in India',
              style: TextStyle(fontSize: 25),
            ) ,
          ),
        ]),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/Amazon_icon.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.amazon.in/?&_encoding=UTF8&tag=bappasaikh-21&linkCode=ur2&linkId=e3b009b026920c3cfdd6185fadfb7e67&camp=3638&creative=24630"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/flipkart_icon.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://Flipkart.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/ebay.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://Ebay.in"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/shopclues-512.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://Shopclues.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),



                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/snapdeal-512.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.snapdeal.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/myntra_.JPG'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.myntra.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/ajio.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.ajio.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
              ]),
        ),






        Row(children: <Widget>[
        Container(
          // padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 30.0,left:10.0),
          child:
          Text(
            'Social Media',
            style: TextStyle(fontSize: 25),
          ) ,
        ),
      ]),
      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
    child: Row(
    children: [

      Container(
        // padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: IconButton(
          icon: Image.asset('assets/icon/facebook.png'),
          iconSize: 50,
          color: Colors.green,
          splashColor: Colors.purple,
          onPressed: () async {
            await widget.browser.open(
                url: Uri.parse("https://www.facebook.com/"),
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false,),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          },
        ),
      ),



      Container(
        // padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: IconButton(
          icon: Image.asset('assets/icon/Twitter-featured.png'),
          iconSize: 50,
          color: Colors.green,
          splashColor: Colors.purple,
          onPressed: () async {
            await widget.browser.open(
                url: Uri.parse("https://twitter.com/"),
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false,),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          },
        ),
      ),


      Container(
        // padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: IconButton(
          icon: Image.asset('assets/icon/pinterest.png'),
          iconSize: 50,
          color: Colors.green,
          splashColor: Colors.purple,
          onPressed: () async {
            await widget.browser.open(
                url: Uri.parse("https://www.pinterest.com/"),
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false,),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          },
        ),
      ),


      Container(
        // padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: IconButton(
          icon: Image.asset('assets/icon/Instagram.png'),
          iconSize: 50,
          color: Colors.green,
          splashColor: Colors.purple,
          onPressed: () async {
            await widget.browser.open(
                url: Uri.parse("https://www.instagram.com/"),
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false,),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          },
        ),
      ),
    ]),
    ),





        Row(children: <Widget>[
          Container(
            // padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30.0,left:10.0),
            child:
            Text(
              'Entertainments',
              style: TextStyle(fontSize: 25),
            ) ,
          ),
        ]),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/YouTube-logo.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.youtube.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),



                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/netflixlogo.0.0.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.netflix.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/prime-video.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.primevideo.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/hotstar.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.hotstar.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/gana.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://gaana.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/saavn.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.jiosaavn.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/wynk-music.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.wynk.in/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
              ]),
        ),









        Row(children: <Widget>[
          Container(
            // padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30.0,left:10.0),
            child:
            Text(
              'Hotels and Travels',
              style: TextStyle(fontSize: 25),
            ) ,
          ),
        ]),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/IRCTC_Logo.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://irctc.co.in/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),



                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/OYO-Rooms-Logo-.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.oyorooms.com"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/makemytrip.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://makemytrip.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/booking.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.booking.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/airbnb-transparent.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://www.airbnb.co.in/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/expedia.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://expedia.co.in/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/yatra.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://yatra.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/goibibo_india_logo.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://goibibo.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/agoda.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://agoda.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/Easemytrip.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://easemytrip.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/clear_trip.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://cleartrip.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/travelguru.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://travelguru.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/IcredibleIndia-EN-Preview.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://incredibleindia.org/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),
              ]),
        ),











        Row(children: <Widget>[
          Container(
            // padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30.0,left:10.0),
            child:
            Text(
              'Food Services in India',
              style: TextStyle(fontSize: 25),
            ) ,
          ),
        ]),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [

                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/big-basket-new.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://bigbasket.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),



                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/Swiggy-Logo-Tagline-Slogan.jpg'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://swiggy.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),


                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/icon/zomato-logo.png'),
                    iconSize: 50,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () async {
                      await widget.browser.open(
                          url: Uri.parse("https://zomato.com/"),
                          options: ChromeSafariBrowserClassOptions(
                              android: AndroidChromeCustomTabsOptions(
                                addDefaultShareMenuItem: false,),
                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                    },
                  ),
                ),



              ]),
        ),









      ]),


      ),


    );
  }
}
