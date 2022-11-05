// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'socials.dart';
import 'ui/styles.dart';
import 'package:personal_portfolio/ui/theme.dart';
import 'package:personal_portfolio/ui/switch.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const MyHomePage(title: 'Personal portfolio'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _Portrait()
              : _landscapeLayout();
        },
      ),
    );
  }
}

class _Portrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ToggleSwitch(),
            Image.asset("assets/images/faruk.jpg", width: 240, height: 240),
            Text("Faruk Abdulganiyu", style: TextStyle(fontSize: 25.0)),
            Text(
                "A mobile developer with passion for technology. "
                "I would like to add value to the company by bringing on the company, my experience in the tech world, my positive attitude and my good communication skills.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SocialMedia("assets/images/twitter.png",
                  Uri.parse("https://www.twitter.com/faruking2")),
              SocialMedia("assets/images/facebook.png",
                  Uri.parse("https://www.facebook.com/faruk.abdul3")),
              SocialMedia("assets/images/github.png",
                  Uri.parse("https://www.github.com/faruking")),
            ]),
          ],
        ),
      ),
    );
  }
}

class _landscapeLayout extends StatelessWidget {
  const _landscapeLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("assets/images/faruk.jpg", width: 240, height: 240)
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(),
                  Text(
                    "Faruk Abdulganiyu",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  SizedBox(
                    child: Text(
                        "A mobile developer with passion for technology. \n"
                        "I would like to add value to the company by bringing on the company, my experience in the tech world, my positive attitude and my good communication skills.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SocialMedia("assets/images/twitter.png",
                        Uri.parse("https://www.twitter.com/faruking2")),
                    SocialMedia("assets/images/facebook.png",
                        Uri.parse("https://www.facebook.com/faruk.abdul3")),
                    SocialMedia("assets/images/github.png",
                        Uri.parse("https://www.github.com/faruking")),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
