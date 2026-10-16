import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Exposes the résumé URL only once the PDF is confirmed to be deployed, so the
/// site never shows a download link that leads to a 404.
class ResumeService {
  ResumeService._();

  static final ResumeService instance = ResumeService._();

  final ValueNotifier<Uri?> url = ValueNotifier<Uri?>(null);

  Future<void> resolve(String path) async {
    // Uri.base is the page URL, which already includes the GitHub Pages
    // project path. Link treats relative URIs as in-app routes, so resolve it.
    final Uri candidate;
    try {
      candidate = Uri.base.resolve(path);
    } catch (_) {
      return;
    }
    if (!candidate.isScheme('http') && !candidate.isScheme('https')) return;

    try {
      final response = await http
          .head(candidate)
          .timeout(const Duration(seconds: 8));
      final type = response.headers['content-type'] ?? '';
      if (response.statusCode == 200 && type.contains('pdf')) {
        url.value = candidate;
      }
    } catch (_) {
      // Offline or blocked: keep the button hidden.
    }
  }
}
