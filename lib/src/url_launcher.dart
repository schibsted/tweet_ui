import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  final uri = Uri.tryParse(url);

  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
