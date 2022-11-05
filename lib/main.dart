// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

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
  const _Portrait({
    Key key,
  }) : super(key: key);

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

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({Key key}) : super(key: key);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Switch(
        value: _value,
        onChanged: (_) {
          setState(() {
            _value = !_value;
            themeChange.darkTheme = _value;
          });
        });
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

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.lightBlue,
      primaryColor: isDarkTheme ? Color(0x121212FF) : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia(this.imageUrl, this.url);
  final String imageUrl;
  final Uri url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        imageUrl,
        width: 24,
        height: 24,
      ),
      onTap: () {
        _launchUrl(url);
      },
    );
  }
}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
