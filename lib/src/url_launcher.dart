import 'package:url_launcher/url_launcher.dart';

void openUrl(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
