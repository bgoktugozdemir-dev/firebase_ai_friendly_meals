extension CompactNum on num {
  /// Drops a trailing `.0` so `2.0` prints as `2`.
  String toCompactString() {
    return this == truncateToDouble() ? toInt().toString() : toString();
  }
}
