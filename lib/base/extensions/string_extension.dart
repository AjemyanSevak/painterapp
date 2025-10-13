extension StringExtension on String? {
  String? capitalize() {
    if (this == null) return null;

    if (this!.isEmpty == true) return '';
    if (this!.length == 1) return this!.toUpperCase();
    return this![0].toUpperCase() + this!.substring(1);
  }
}
