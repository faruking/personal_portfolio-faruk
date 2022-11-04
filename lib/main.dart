import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

final Uri _url = Uri.parse('https://flutter.dev');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Personal portfolio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset("assets/images/faruk.jpg", width: 240, height: 240),
            Text("Faruk Abdulganiyu"),
            Text("A mobile developer"),
            TextButton(
              onPressed: () {
                if (kDebugMode) {
                  print("pressed");
                }
              },
              child: Text("Hire me"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
              ),
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
    );
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia(this.imageUrl, this.url, {super.key});
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

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
