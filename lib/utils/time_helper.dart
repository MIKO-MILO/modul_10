import 'package:intl/intl.dart';

class TimeHelper {
  static String timeAgo(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "Baru saja";

    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return "Baru saja";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} menit yang lalu";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} jam yang lalu";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} hari yang lalu";
      } else {
        return DateFormat('dd MMM yyyy').format(dateTime);
      }
    } catch (e) {
      return "Baru saja";
    }
  }

  static String calculateReadTime(String? content) {
    if (content == null || content.isEmpty) return "1 mnt baca";
    
    // Asumsi rata-rata kecepatan membaca adalah 200 kata per menit
    int wordCount = content.split(' ').length;
    int minutes = (wordCount / 200).ceil();
    
    return "$minutes mnt baca";
  }
}
