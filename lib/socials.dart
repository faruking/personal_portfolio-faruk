import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
