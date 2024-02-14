/// Convert milliseconds to readable time eg. 5 mins ago
String millisecsToReadableTime(int time) {
  final DateTime now = DateTime.now();
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
  final Duration diff = now.difference(date);

  if (diff.inDays > 365) {
    return '${(diff.inDays / 365).floor()} years ago';
  } else if (diff.inDays > 30) {
    return '${(diff.inDays / 30).floor()} months ago';
  } else if (diff.inDays > 7) {
    return '${(diff.inDays / 7).floor()} days ago';
  } else if (diff.inDays > 0) {
    return '${diff.inDays} days ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} hours ago';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes} mins ago';
  } else {
    return 'just now';
  }
}
